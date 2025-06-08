import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'widgets/single_image_container.dart';
import 'widgets/time_and_status.dart';

/// A widget that displays an image message.
///
/// Uses [CachedNetworkImage] for efficient loading and caching.
/// Supports BlurHash and ThumbHash placeholders.
/// Optionally displays upload progress if the [ChatController]
/// implements [UploadProgressMixin].
class FlyerChatMultiImagesMessage extends StatefulWidget {
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
  final BoxConstraints constraints;

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

  /// Creates a widget to display an image message.
  const FlyerChatMultiImagesMessage({
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
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlyerChatMultiImagesMessageState createState() =>
      _FlyerChatMultiImagesMessageState();
}

/// State for [FlyerChatMultiImagesMessage].
class _FlyerChatMultiImagesMessageState
    extends State<FlyerChatMultiImagesMessage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final isSentByMe = context.watch<UserID>() == widget.message.authorId;
    final textDirection = Directionality.of(context);
    final timeAndStatus =
        widget.showTime || (isSentByMe && widget.showStatus)
            ? TimeAndStatus(
              time: widget.message.time,
              status: widget.message.status,
              showTime: widget.showTime,
              showStatus: isSentByMe && widget.showStatus,
              backgroundColor:
                  widget.timeBackground ?? Colors.black.withValues(alpha: 0.6),
              textStyle:
                  widget.timeStyle ??
                  theme.typography.labelSmall.copyWith(color: Colors.white),
            )
            : null;

    // TODO adapt this code when we decide how this widget is seeded
    final count = 15;

    final containers = List.generate(
      count,
      (index) => SingleImageContainer(
        source: 'https://picsum.photos/${200 + index * 10}/300?random=$index',
        headers: widget.headers,
        thumbhash: widget.message.thumbhash,
        blurhash: widget.message.blurhash,
        hasOverlay: widget.message.hasOverlay,
        placeholderColor: widget.placeholderColor,
        loadingOverlayColor: widget.loadingOverlayColor,
        loadingIndicatorColor: widget.loadingIndicatorColor,
        uploadOverlayColor: widget.uploadOverlayColor,
        uploadIndicatorColor: widget.uploadIndicatorColor,
        overlay: widget.overlay,
        customImageProvider: widget.customImageProvider,
        imageFit: count == 1 ? BoxFit.fill : BoxFit.cover,
        uploadProgressId: widget.message.id,
      ),
    );

    final imagesCount = containers.length;

    late Widget grid;
    final spacing = 2.0; // TODO: make this dynamic

    if (imagesCount == 1) {
      grid =
          containers[0]; // TODO: We could use only one widget and use AspectRatio here.
    } else if (imagesCount == 2) {
      grid = Row(
        spacing: spacing,
        children: [
          Flexible(child: containers[0]),
          Flexible(child: containers[1]),
        ],
      );
    } else if (imagesCount == 3) {
      grid = Row(
        spacing: spacing,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              spacing: spacing,
              children: [Flexible(child: containers[0])],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              spacing: spacing,
              children: [
                Flexible(child: containers[1]),
                Flexible(child: containers[2]),
              ],
            ),
          ),
        ],
      );
    } else if (imagesCount == 4) {
      grid = Column(
        spacing: spacing,
        children: [
          Expanded(
            child: Row(
              spacing: spacing,
              children: [
                Flexible(child: containers[0]),
                Flexible(child: containers[1]),
              ],
            ),
          ),
          Expanded(
            child: Row(
              spacing: spacing,
              children: [
                Flexible(child: containers[2]),
                Flexible(child: containers[3]),
              ],
            ),
          ),
        ],
      );
    } else if (imagesCount > 4) {
      final hasMore = imagesCount > 5;
      final hasMoreCount = imagesCount - 5;
      grid = Column(
        mainAxisSize: MainAxisSize.max,
        spacing: spacing,
        children: [
          Expanded(
            child: Row(
              spacing: spacing,
              children: [
                Flexible(child: containers[0]),
                Flexible(child: containers[1]),
              ],
            ),
          ),
          Expanded(
            child: Row(
              spacing: spacing,
              children: [
                Flexible(child: containers[2]),
                Flexible(child: containers[3]),
                Flexible(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      containers[4],
                      if (hasMore)
                        Container(
                          color: Colors.black.withValues(
                            alpha: 0.5,
                          ), // TODO: allow color override
                          child: Center(
                            child: Text(
                              // TODO: should we count the overlayed image
                              '+$hasMoreCount',
                              // TODO: allow override
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? theme.shape,
      child: Container(
        constraints: widget.constraints,
        child: Stack(
          fit: StackFit.expand,
          children: [
            grid,
            if (timeAndStatus != null)
              Positioned.directional(
                textDirection: textDirection,
                bottom: 8,
                end:
                    widget.timeAndStatusPosition == TimeAndStatusPosition.end ||
                            widget.timeAndStatusPosition ==
                                TimeAndStatusPosition.inline
                        ? 8
                        : null,
                start:
                    widget.timeAndStatusPosition == TimeAndStatusPosition.start
                        ? 8
                        : null,
                child: timeAndStatus,
              ),
          ],
        ),
      ),
    );
  }
}
