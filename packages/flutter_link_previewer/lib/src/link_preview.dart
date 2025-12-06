import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;
import 'package:url_launcher/url_launcher.dart';
import 'utils.dart';

/// A widget that displays a preview of a URL.
///
/// It can be used to display a preview of a URL in a chat message,
/// or in any other context where you want to display a preview of a URL.
///
/// The widget can be customized with a variety of parameters,
/// including the background color, border radius, and text styles.
///
/// It also supports animations, and can be disabled if desired.
class LinkPreview extends StatefulWidget {
  /// Creates a link preview widget.
  const LinkPreview({
    super.key,
    required this.onLinkPreviewDataFetched,
    this.linkPreviewData,
    required this.text,
    this.minWidth = 200,
    this.maxWidth = 400,
    this.squareImageSize = 80,
    this.parentContent,
    this.onTap,
    this.corsProxy,
    this.headers,
    this.requestTimeout = const Duration(seconds: 5),
    this.userAgent,
    this.hideTitle = false,
    this.hideDescription = false,
    this.hideImage = false,
    this.forcedLayout,
    this.backgroundColor,
    this.sideBorderColor,
    this.sideBorderWidth = 4,
    this.borderRadius = 4,
    this.insidePadding = const EdgeInsets.fromLTRB(8, 4, 4, 4),
    this.outsidePadding = const EdgeInsets.symmetric(vertical: 2),
    this.titleTextStyle,
    this.maxTitleLines = 2,
    this.descriptionTextStyle,
    this.maxDescriptionLines = 3,
    this.animationDuration = const Duration(milliseconds: 250),
    this.enableAnimation = true,
    this.imageBuilder,
    this.gap = 4,
  });

  /// A callback that is called when the link preview data is fetched.
  final Function(LinkPreviewData) onLinkPreviewDataFetched;

  /// The link preview data to display. If this is null, the widget will
  /// fetch the data from the URL in the [text] parameter.
  final LinkPreviewData? linkPreviewData;

  /// The text to parse for a URL.
  final String text;

  /// The minimum width of the preview.
  final double minWidth;

  /// The maximum width of the preview.
  final double maxWidth;

  /// The size of the image, if it is a square.
  final double squareImageSize;

  /// The content of the parent widget, typically the text of a message bubble.
  ///
  /// This is used to calculate a minimum width for the preview, ensuring it
  /// aligns visually with other content. The preview's width will be at least
  /// the width of this text. This can cause the preview to be wider than
  /// [maxWidth], but it will still be constrained by the available layout space.
  final String? parentContent;

  /// A callback that is called when the preview is tapped.
  final void Function(String)? onTap;

  /// The CORS proxy to use for fetching the preview data.
  final String? corsProxy;

  /// The headers to use for fetching the preview data.
  final Map<String, String>? headers;

  /// The timeout for the request to fetch the preview data.
  final Duration? requestTimeout;

  /// The user agent to use for fetching the preview data.
  final String? userAgent;

  /// Whether to hide the title of the preview.
  final bool hideTitle;

  /// Whether to hide the description of the preview.
  final bool hideDescription;

  /// Whether to hide the image of the preview.
  final bool hideImage;

  /// The forced layout of the image.
  final LinkPreviewImagePosition? forcedLayout;

  /// The background color of the preview.
  final Color? backgroundColor;

  /// The color of the side border.
  final Color? sideBorderColor;

  /// The width of the side border.
  final double sideBorderWidth;

  /// The border radius of the preview.
  final double borderRadius;

  /// The padding inside the preview.
  final EdgeInsets insidePadding;

  /// The padding outside the preview.
  final EdgeInsets outsidePadding;

  /// The text style of the title.
  final TextStyle? titleTextStyle;

  /// The maximum number of lines for the title.
  final int maxTitleLines;

  /// The text style of the description.
  final TextStyle? descriptionTextStyle;

  /// The maximum number of lines for the description.
  final int maxDescriptionLines;

  /// The duration of the animation.
  final Duration? animationDuration;

  /// Whether to enable the animation.
  final bool enableAnimation;

  /// A builder for the image widget.
  final Widget Function(String)? imageBuilder;

  /// The gap between the elements of the preview.
  final double gap;

  @override
  State<LinkPreview> createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<LinkPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  LinkPreviewData? _previewData;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );

    _previewData = widget.linkPreviewData;

    if (_previewData != null) {
      _controller.value = 1.0;
    } else {
      _fetchData();
    }
  }

  @override
  void didUpdateWidget(covariant LinkPreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text && widget.linkPreviewData == null) {
      _fetchData();
    }

    if (widget.linkPreviewData != null &&
        widget.linkPreviewData != _previewData) {
      setState(() {
        _previewData = widget.linkPreviewData;
      });
      if (widget.enableAnimation) {
        _controller.forward(from: 0);
      } else {
        _controller.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _previewData = null;
    });
    _controller.reset();

    final value = await getLinkPreviewData(
      widget.text,
      proxy: widget.corsProxy,
      headers: widget.headers,
      requestTimeout: widget.requestTimeout,
      userAgent: widget.userAgent,
    );

    if (!mounted) return;

    if (value != null) {
      widget.onLinkPreviewDataFetched(value);
      setState(() {
        _previewData = value;
      });
      if (widget.enableAnimation) {
        await _controller.forward();
      } else {
        _controller.value = 1.0;
      }
    }
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  Widget _buildPreviewLayout(
    BuildContext context,
    BoxConstraints constraints,
    LinkPreviewData previewData,
  ) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    final effectiveTitleTextStyle =
        widget.titleTextStyle ??
        defaultTextStyle.copyWith(fontWeight: FontWeight.bold);
    final effectiveDescriptionTextStyle =
        widget.descriptionTextStyle ?? defaultTextStyle;

    final parentWidth = widget.parentContent == null
        ? 0.0
        : _calculateTextWidth(widget.parentContent!, defaultTextStyle);

    final titleWidth = !previewData.hasTitle(hide: widget.hideTitle)
        ? 0.0
        : _calculateTextWidth(previewData.title!, effectiveTitleTextStyle);

    final descriptionWidth =
        !previewData.hasDescription(hide: widget.hideDescription)
        ? 0.0
        : _calculateTextWidth(
            previewData.description!,
            effectiveDescriptionTextStyle,
          );

    final hasText =
        previewData.hasTitle(hide: widget.hideTitle) ||
        previewData.hasDescription(hide: widget.hideDescription);

    final naturalContentWidth = max(titleWidth, descriptionWidth);

    final isNotImageOnly = hasText;
    final useSideImageLayout =
        widget.forcedLayout == LinkPreviewImagePosition.side ||
        (widget.forcedLayout != LinkPreviewImagePosition.bottom &&
            previewData.isSquareImage &&
            isNotImageOnly);

    final imageWidth = useSideImageLayout
        ? widget.squareImageSize + widget.gap
        : 0.0;
    final textMaxWidth = min(
      widget.maxWidth,
      constraints.maxWidth - imageWidth,
    ).clamp(0.0, double.infinity);

    final finalWidth = max(
      parentWidth,
      min(naturalContentWidth, textMaxWidth),
    ).clamp(widget.minWidth, double.infinity).clamp(0.0, constraints.maxWidth);

    Widget? squareImage;
    Widget? rectangleImage;

    final canShowImage = previewData.hasImage(hide: widget.hideImage);

    if (canShowImage) {
      final image = widget.imageBuilder != null
          ? widget.imageBuilder!(previewData.image!.url)
          : Image.network(
              previewData.image!.url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox.shrink();
              },
            );
      if (useSideImageLayout) {
        squareImage = ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: SizedBox(
            width: widget.squareImageSize,
            height: widget.squareImageSize,
            child: image,
          ),
        );
      } else {
        rectangleImage = Padding(
          padding: EdgeInsets.only(top: hasText ? widget.gap : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: AspectRatio(
              aspectRatio: previewData.image!.width / previewData.image!.height,
              child: image,
            ),
          ),
        );
      }
    }

    final textOnlyBlock = hasText
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (previewData.hasTitle(hide: widget.hideTitle))
                Text(
                  previewData.title!,
                  style: effectiveTitleTextStyle,
                  maxLines: widget.maxTitleLines,
                  overflow: TextOverflow.ellipsis,
                ),
              if (previewData.hasDescription(hide: widget.hideDescription))
                Text(
                  previewData.description!,
                  style: effectiveDescriptionTextStyle,
                  maxLines: widget.maxDescriptionLines,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          )
        : const SizedBox.shrink();

    final mainContentBlock = squareImage != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: textOnlyBlock),
              if (hasText) SizedBox(width: widget.gap),
              squareImage,
            ],
          )
        : textOnlyBlock;

    return SizedBox(
      width: finalWidth,
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color:
                  widget.backgroundColor ?? Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Padding(
              padding: widget.insidePadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainContentBlock,
                  if (rectangleImage != null) rectangleImage,
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: widget.sideBorderWidth,
              decoration: BoxDecoration(
                color:
                    widget.sideBorderColor ??
                    Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.borderRadius),
                  bottomLeft: Radius.circular(widget.borderRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(String url) async {
    if (widget.onTap != null) {
      widget.onTap!(url);
    } else {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _previewData;
    if (data == null ||
        (!data.hasTitle(hide: widget.hideTitle) &&
            !data.hasDescription(hide: widget.hideDescription) &&
            !data.hasImage(hide: widget.hideImage))) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => _onTap(data.link),
      child: Padding(
        padding: widget.outsidePadding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = _buildPreviewLayout(
              context,
              constraints,
              _previewData!,
            );

            if (!widget.enableAnimation) return content;

            return FadeTransition(
              opacity: _animation,
              child: SizeTransition(
                axisAlignment: -1.0,
                sizeFactor: _animation,
                fixedCrossAxisSizeFactor: 1,
                child: content,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The position of the image in the link preview.
enum LinkPreviewImagePosition {
  /// The image is displayed at the bottom of the preview.
  bottom,

  /// The image is displayed on the side of the preview.
  side,
}

extension on LinkPreviewData {
  bool hasTitle({bool hide = false}) =>
      !hide && title != null && title!.isNotEmpty;
  bool hasDescription({bool hide = false}) =>
      !hide && description != null && description!.isNotEmpty;
  bool hasImage({bool hide = false}) {
    if (hide) return false;
    final i = image;
    if (i == null) return false;
    return i.width > 0 && i.height > 0;
  }

  bool get isSquareImage => hasImage() && image!.width == image!.height;
}
