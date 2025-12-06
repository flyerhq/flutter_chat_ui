import 'dart:convert';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image/image.dart' show encodeJpg;
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart'
    show rgbaToBmp, thumbHashToApproximateAspectRatio, thumbHashToRGBA;

import 'get_image_dimensions.dart';

/// Theme values for [FlyerChatImageMessage].
typedef _LocalTheme = ({
  TextStyle labelSmall,
  Color onSurface,
  BorderRadiusGeometry shape,
  Color surfaceContainerLow,
});

/// A widget that displays an image message.
///
/// Uses [CachedNetworkImage] for efficient loading and caching.
/// Supports BlurHash and ThumbHash placeholders.
/// Optionally displays upload progress if the [ChatController]
/// implements [UploadProgressMixin].
class FlyerChatImageMessage extends StatefulWidget {
  /// The image message data model.
  final ImageMessage message;

  /// The index of the message in the list.
  final int index;

  /// Optional custom [ImageProvider] to use for loading the image.
  /// If not provided, defaults to using [CachedNetworkImage] from `cross_cache`
  /// with the `message.source`.
  final ImageProvider? customImageProvider;

  /// Optional HTTP headers for authenticated image requests.
  /// Commonly used for authorization tokens, e.g., {'Authorization': 'Bearer token'}.
  /// Only used when [customImageProvider] is null.
  final Map<String, String>? headers;

  /// Border radius of the image container.
  final BorderRadiusGeometry? borderRadius;

  /// Constraints for the image size.
  final BoxConstraints? constraints;

  /// An optional overlay widget to display on top of the image (e.g., NSFW content).
  /// Requires `message.hasOverlay` to be true.
  final Widget? overlay;

  /// Background color used while the placeholder is visible.
  final Color? placeholderColor;

  /// Color of the overlay shown during image loading.
  final Color? loadingOverlayColor;

  /// Color of the circular progress indicator shown during image loading.
  final Color? loadingIndicatorColor;

  /// Color of the overlay shown during image upload.
  final Color? uploadOverlayColor;

  /// Color of the circular progress indicator shown during image upload.
  final Color? uploadIndicatorColor;

  /// Text style for the message timestamp and status.
  final TextStyle? timeStyle;

  /// Background color for the timestamp and status display.
  final Color? timeBackground;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the image.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// Error builder for the image widget.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// The widget to display on top of the message.
  final Widget? topWidget;

  /// Creates a widget to display an image message.
  const FlyerChatImageMessage({
    super.key,
    required this.message,
    required this.index,
    this.customImageProvider,
    this.headers,
    this.borderRadius,
    this.constraints = const BoxConstraints(maxHeight: 300),
    this.overlay,
    this.placeholderColor,
    this.loadingOverlayColor,
    this.loadingIndicatorColor,
    this.uploadOverlayColor,
    this.uploadIndicatorColor,
    this.timeStyle,
    this.timeBackground,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.errorBuilder,
    this.topWidget,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlyerChatImageMessageState createState() => _FlyerChatImageMessageState();
}

/// State for [FlyerChatImageMessage].
class _FlyerChatImageMessageState extends State<FlyerChatImageMessage>
    with TickerProviderStateMixin {
  late final ChatController _chatController;
  late ImageProvider _imageProvider;
  late double _aspectRatio;
  ImageProvider? _placeholderProvider;

  @override
  void initState() {
    super.initState();

    final height = widget.message.height;
    final width = widget.message.width;

    if (height != null && width != null && height > 0 && width > 0) {
      _aspectRatio = width / height;
    } else if (widget.message.thumbhash?.isNotEmpty ?? false) {
      final thumbhashBytes = base64.decode(
        base64.normalize(widget.message.thumbhash!),
      );

      _aspectRatio = thumbHashToApproximateAspectRatio(thumbhashBytes);

      final rgbaImage = thumbHashToRGBA(thumbhashBytes);
      final bmp = rgbaToBmp(rgbaImage);
      _placeholderProvider = MemoryImage(bmp);
    } else if (widget.message.blurhash?.isNotEmpty ?? false) {
      _aspectRatio = 1;

      final blurhash = BlurHash.decode(widget.message.blurhash!);
      final image = blurhash.toImage(35, 20);
      final jpg = encodeJpg(image);
      _placeholderProvider = MemoryImage(jpg);
    } else {
      _aspectRatio = 1;
    }

    _chatController = context.read<ChatController>();
    _imageProvider = _targetProvider;

    if (width == null || height == null) {
      getImageDimensions(_imageProvider).then((dimensions) {
        if (mounted) {
          _aspectRatio = dimensions.$1 / dimensions.$2;
          _chatController.updateMessage(
            widget.message,
            widget.message.copyWith(
              width: dimensions.$1,
              height: dimensions.$2,
            ),
          );
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant FlyerChatImageMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.source != widget.message.source ||
        oldWidget.headers != widget.headers) {
      final newImage = _targetProvider;

      precacheImage(newImage, context).then((_) {
        if (mounted) {
          _imageProvider = newImage;
        }
      });
    }
  }

  @override
  void dispose() {
    _placeholderProvider?.evict();
    // Evicting the image on dispose will result in images flickering
    // PaintingBinding.instance.imageCache.evict(_imageProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        labelSmall: t.typography.labelSmall,
        onSurface: t.colors.onSurface,
        shape: t.shape,
        surfaceContainerLow: t.colors.surfaceContainerLow,
      ),
    );
    final isSentByMe = context.read<UserID>() == widget.message.authorId;
    final textDirection = Directionality.of(context);
    final timeAndStatus = widget.showTime || (isSentByMe && widget.showStatus)
        ? TimeAndStatus(
            time: widget.message.resolvedTime,
            status: widget.message.resolvedStatus,
            showTime: widget.showTime,
            showStatus: isSentByMe && widget.showStatus,
            backgroundColor:
                widget.timeBackground ?? Colors.black.withValues(alpha: 0.6),
            textStyle:
                widget.timeStyle ??
                theme.labelSmall.copyWith(color: Colors.white),
          )
        : null;

    return ClipRRect(
      borderRadius: widget.borderRadius ?? theme.shape,
      child: Container(
        constraints: widget.constraints,
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: widget.topWidget != null
              ? LayoutBuilder(
                  builder: (context, constraints) => _buildStack(
                    constraints,
                    theme,
                    textDirection,
                    timeAndStatus,
                  ),
                )
              : _buildStack(null, theme, textDirection, timeAndStatus),
        ),
      ),
    );
  }

  Widget _buildStack(
    BoxConstraints? constraints,
    _LocalTheme theme,
    TextDirection textDirection,
    TimeAndStatus? timeAndStatus,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _placeholderProvider != null
            ? Image(image: _placeholderProvider!, fit: BoxFit.fill)
            : Container(
                color: widget.placeholderColor ?? theme.surfaceContainerLow,
              ),
        Image(
          image: _imageProvider,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return Container(
              color:
                  widget.loadingOverlayColor ??
                  theme.surfaceContainerLow.withValues(alpha: 0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color:
                      widget.loadingIndicatorColor ??
                      theme.onSurface.withValues(alpha: 0.8),
                  strokeCap: StrokeCap.round,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            var content = child;

            if (widget.overlay != null &&
                widget.message.hasOverlay == true &&
                frame != null) {
              content = Stack(
                fit: StackFit.expand,
                children: [child, widget.overlay!],
              );
            }

            if (wasSynchronouslyLoaded) {
              return content;
            }

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: frame == null ? 0 : 1,
              curve: Curves.linearToEaseOut,
              child: content,
            );
          },
          errorBuilder: widget.errorBuilder,
        ),
        if (_chatController is UploadProgressMixin)
          StreamBuilder<double>(
            stream: (_chatController as UploadProgressMixin).getUploadProgress(
              widget.message.id,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data! >= 1) {
                return const SizedBox();
              }

              return Container(
                color:
                    widget.uploadOverlayColor ??
                    theme.surfaceContainerLow.withValues(alpha: 0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color:
                        widget.uploadIndicatorColor ??
                        theme.onSurface.withValues(alpha: 0.8),
                    strokeCap: StrokeCap.round,
                    value: snapshot.data,
                  ),
                ),
              );
            },
          ),
        if (widget.topWidget != null && constraints != null)
          Positioned.directional(
            textDirection: textDirection,
            start: 8,
            top: 8,
            child: Container(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth - 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    widget.timeBackground ??
                    Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: widget.topWidget,
            ),
          ),
        if (timeAndStatus != null)
          Positioned.directional(
            textDirection: textDirection,
            bottom: 8,
            end:
                widget.timeAndStatusPosition == TimeAndStatusPosition.end ||
                    widget.timeAndStatusPosition == TimeAndStatusPosition.inline
                ? 8
                : null,
            start: widget.timeAndStatusPosition == TimeAndStatusPosition.start
                ? 8
                : null,
            child: timeAndStatus,
          ),
      ],
    );
  }

  ImageProvider get _targetProvider {
    if (widget.customImageProvider != null) {
      return widget.customImageProvider!;
    } else {
      final crossCache = context.read<CrossCache>();
      return CachedNetworkImage(
        widget.message.source,
        crossCache,
        headers: widget.headers,
      );
    }
  }
}

/// A widget to display the message timestamp and status indicator over an image.
class TimeAndStatus extends StatelessWidget {
  /// The time the message was created.
  final DateTime? time;

  /// The status of the message.
  final MessageStatus? status;

  /// Whether to display the timestamp.
  final bool showTime;

  /// Whether to display the status indicator.
  final bool showStatus;

  /// Background color for the time and status container.
  final Color? backgroundColor;

  /// Text style for the time and status.
  final TextStyle? textStyle;

  /// Creates a widget for displaying time and status over an image.
  const TimeAndStatus({
    super.key,
    required this.time,
    this.status,
    this.showTime = true,
    this.showStatus = true,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = context.watch<DateFormat>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTime && time != null)
            Text(timeFormat.format(time!.toLocal()), style: textStyle),
          if (showStatus && status != null)
            if (status == MessageStatus.sending)
              SizedBox(
                width: 6,
                height: 6,
                child: CircularProgressIndicator(
                  color: textStyle?.color,
                  strokeWidth: 2,
                ),
              )
            else
              Icon(
                getIconForStatus(status!),
                color: textStyle?.color,
                size: 12,
              ),
        ],
      ),
    );
  }
}
