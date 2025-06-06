import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;
import 'package:url_launcher/url_launcher.dart';

import '../utils.dart' show getLinkPreviewData;

/// A widget that renders text with highlighted links.
/// Eventually unwraps to the full preview of the first found link
/// if the parsing was successful.
@immutable
class LinkPreview extends StatefulWidget {
  /// Creates [LinkPreview].
  const LinkPreview({
    super.key,
    required this.text,
    this.linkPreviewData,
    required this.onLinkPreviewDataFetched,
    this.corsProxy,
    this.requestTimeout,
    this.userAgent,
    this.enableAnimation = false,
    this.animationDuration,
    this.titleTextStyle,
    this.maxTitleLines = 2,
    this.descriptionTextStyle,
    this.maxDescriptionLines = 3,
    this.imageBuilder,
    this.onLinkPressed,
    this.openOnPreviewImageTap = true,
    this.openOnPreviewTitleTap = true,
    this.hideImage = false,
    this.hideTitle = false,
    this.hideDescription = false,
    this.forcedLayout,
    this.insidePadding = const EdgeInsets.all(4),
    this.outsidePadding = const EdgeInsets.symmetric(vertical: 2),
    this.backgroundColor,
    this.sideBorderColor,
    this.sideBorderWidth = 4,
    this.borderRadius = 4,
    this.maxImageHeight = 150,
    this.maxWidth,
    this.maxHeight,
  });

  /// Text used for parsing.
  final String text;

  /// Pass saved [LinkPreviewData] here so [LinkPreview] would not fetch preview
  /// data again.
  final LinkPreviewData? linkPreviewData;

  /// Callback which is called when [LinkPreviewData] was successfully parsed.
  /// Use it to save [LinkPreviewData] to the state and pass it back
  /// to the [LinkPreview.LinkPreviewData] so the [LinkPreview] would not fetch
  /// preview data again.
  final void Function(LinkPreviewData?) onLinkPreviewDataFetched;

  /// CORS proxy to make more previews work on web. Not tested.
  final String? corsProxy;

  /// Request timeout after which the request will be cancelled. Defaults to 5 seconds.
  final Duration? requestTimeout;

  /// User agent to send as GET header when requesting link preview url.
  final String? userAgent;

  /// Enables expand animation. Default value is false.
  final bool? enableAnimation;

  /// Expand animation duration.
  final Duration? animationDuration;

  /// Style of preview's title.
  final TextStyle? titleTextStyle;

  /// Maximum number of lines for the title text.
  final int maxTitleLines;

  /// Style of preview's description.
  final TextStyle? descriptionTextStyle;

  /// Maximum number of lines for the description text.
  final int maxDescriptionLines;

  /// Function that allows you to build a custom image.
  final Widget Function(String)? imageBuilder;

  /// Custom link press handler.
  final void Function(String)? onLinkPressed;

  /// Open the link when the link preview image is tapped. Defaults to true.
  final bool openOnPreviewImageTap;

  /// Open the link when the link preview title/description is tapped. Defaults to true.
  final bool openOnPreviewTitleTap;

  /// Hides image data from the preview.
  final bool hideImage;

  /// Hides title data from the preview.
  final bool hideTitle;

  /// Hides description data from the preview.
  final bool hideDescription;

  /// Force the link image to be displayed on the side of the preview.
  final LinkPreviewImagePosition? forcedLayout;

  /// Padding inside the link preview widget.
  final EdgeInsets insidePadding;

  /// Margin around the link preview widget.
  final EdgeInsets outsidePadding;

  /// Background color.
  final Color? backgroundColor;

  /// Preview border color.
  final Color? sideBorderColor;

  /// Preview border width.
  final double sideBorderWidth;

  /// Preview border radius.
  final double borderRadius;

  /// Max image height.
  final double maxImageHeight;

  /// Max width.
  final double? maxWidth;

  /// Max height.
  final double? maxHeight;

  @override
  State<LinkPreview> createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<LinkPreview>
    with SingleTickerProviderStateMixin {
  bool isFetchingLinkPreviewData = false;
  bool shouldAnimate = false;
  LinkPreviewData? _linkPreviewData;

  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _linkPreviewData = widget.linkPreviewData;

    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad,
    );

    didUpdateWidget(widget);
  }

  Widget _animated(Widget child) => SizeTransition(
    axis: Axis.vertical,
    axisAlignment: -1,
    sizeFactor: _animation,
    child: child,
  );

  Widget _containerWidget({required LinkPreviewImagePosition imagePosition}) {
    final shouldAnimate = widget.enableAnimation == true;

    final preview = Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? double.infinity,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          margin: widget.outsidePadding,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Padding(
            padding: widget.insidePadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: widget.borderRadius),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_shouldShowTitle())
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: _titleWidget(_linkPreviewData!.title!),
                        ),
                      if (_shouldShowDescription())
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: _descriptionWidget(
                            _linkPreviewData!.description!,
                          ),
                        ),
                      if (_shouldShowImage() &&
                          imagePosition == LinkPreviewImagePosition.bottom)
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: _imageWidget(
                            imageUrl: _linkPreviewData!.image!.url,
                            linkUrl: _linkPreviewData!.link,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_shouldShowImage() &&
                    imagePosition == LinkPreviewImagePosition.side) ...[
                  const SizedBox(width: 4),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: _imageWidget(
                            imageUrl: _linkPreviewData!.image!.url,
                            linkUrl: _linkPreviewData!.link,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            margin: widget.outsidePadding,
            width: widget.borderRadius,
            decoration: BoxDecoration(
              color:
                  widget.sideBorderColor ??
                  Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius),
              ),
            ),
          ),
        ),
      ],
    );

    return shouldAnimate ? _animated(preview) : preview;
  }

  Widget _titleWidget(String title) {
    final style =
        widget.descriptionTextStyle ??
        const TextStyle(fontWeight: FontWeight.bold);
    return Text(
      title,
      maxLines: widget.maxTitleLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }

  Widget _descriptionWidget(String description) => Text(
    description,
    maxLines: widget.maxDescriptionLines,
    overflow: TextOverflow.ellipsis,
    style: widget.titleTextStyle,
  );

  Widget _imageWidget({required String imageUrl, required String linkUrl}) =>
      GestureDetector(
        onTap: widget.openOnPreviewImageTap ? () => _onOpen(linkUrl) : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child:
              widget.imageBuilder != null
                  ? widget.imageBuilder!(imageUrl)
                  : Image.network(imageUrl, fit: BoxFit.contain),
        ),
      );

  Future<LinkPreviewData?> _fetchData(String text) async {
    setState(() {
      isFetchingLinkPreviewData = true;
    });

    final linkPreviewData = await getLinkPreviewData(
      text,
      proxy: widget.corsProxy,
      requestTimeout: widget.requestTimeout,
      userAgent: widget.userAgent,
    );
    await _handleLinkPreviewDataFetched(linkPreviewData);
    return linkPreviewData;
  }

  Future<void> _handleLinkPreviewDataFetched(
    LinkPreviewData? linkPreviewData,
  ) async {
    await Future.delayed(
      widget.animationDuration ?? const Duration(milliseconds: 300),
    );

    if (mounted) {
      widget.onLinkPreviewDataFetched(linkPreviewData);
      setState(() {
        isFetchingLinkPreviewData = false;
      });
    }
  }

  bool _hasDisplayableData() =>
      _shouldShowDescription() || _shouldShowTitle() || _shouldShowImage();

  bool _hasOnlyImage() =>
      _shouldShowImage() && !_shouldShowTitle() && !_shouldShowDescription();

  bool _shouldShowImage() =>
      _linkPreviewData?.image != null && !widget.hideImage;
  bool _shouldShowTitle() =>
      _linkPreviewData?.title != null && !widget.hideTitle;
  bool _shouldShowDescription() =>
      _linkPreviewData?.description != null && !widget.hideDescription;

  Future<void> _onOpen(String url) async {
    if (widget.onLinkPressed != null) {
      widget.onLinkPressed!(url);
    } else {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  void didUpdateWidget(covariant LinkPreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!isFetchingLinkPreviewData && widget.linkPreviewData == null) {
      _fetchData(widget.text);
    }

    if (widget.linkPreviewData != null && oldWidget.linkPreviewData == null) {
      _linkPreviewData = widget.linkPreviewData;
      setState(() {
        shouldAnimate = true;
      });
      _controller.reset();
      _controller.forward();
    } else if (widget.linkPreviewData != null) {
      setState(() {
        shouldAnimate = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final linkPreviewData = _linkPreviewData;

    if (linkPreviewData != null && _hasDisplayableData()) {
      final aspectRatio =
          linkPreviewData.image == null
              ? null
              : linkPreviewData.image!.width / linkPreviewData.image!.height;

      final useSideImage =
          widget.forcedLayout == LinkPreviewImagePosition.side ||
          (widget.forcedLayout != LinkPreviewImagePosition.bottom &&
              aspectRatio == 1 &&
              !_hasOnlyImage());

      return _containerWidget(
        imagePosition:
            useSideImage
                ? LinkPreviewImagePosition.side
                : LinkPreviewImagePosition.bottom,
      );
    } else {
      // While loading, we don't want to show anything
      return const SizedBox.shrink();
    }
  }
}

enum LinkPreviewImagePosition { bottom, side }
