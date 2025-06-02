import 'dart:convert';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image/image.dart' show encodeJpg;
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart'
    show rgbaToBmp, thumbHashToApproximateAspectRatio, thumbHashToRGBA;

import 'helpers/get_image_dimensions.dart';
import 'widgets/single_image_container.dart';
import 'widgets/time_and_status.dart';

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
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlyerChatImageMessageState createState() => _FlyerChatImageMessageState();
}

/// State for [FlyerChatImageMessage].
class _FlyerChatImageMessageState extends State<FlyerChatImageMessage> {
  late final ChatController _chatController;
  late ImageProvider _imageProvider;
  late double _aspectRatio;

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
    } else {
      _aspectRatio = 1;
    }

    _chatController = context.read<ChatController>();

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

    return ClipRRect(
      borderRadius: widget.borderRadius ?? theme.shape,
      child: Container(
        constraints: widget.constraints,
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleImageContainer(
                source: widget.message.source,
                headers: widget.headers,
                thumbhash: widget.message.thumbhash,
                blurhash: widget.message.blurhash,
                overlay: widget.overlay,
                hasOverlay: widget.message.hasOverlay,
                placeholderColor: widget.placeholderColor,
                loadingOverlayColor: widget.loadingOverlayColor,
                loadingIndicatorColor: widget.loadingIndicatorColor,
                uploadOverlayColor: widget.uploadOverlayColor,
                uploadIndicatorColor: widget.uploadIndicatorColor,
                customImageProvider: widget.customImageProvider,
                uploadProgressId: widget.message.id,
              ),
              if (timeAndStatus != null)
                Positioned.directional(
                  textDirection: textDirection,
                  bottom: 8,
                  end:
                      widget.timeAndStatusPosition ==
                                  TimeAndStatusPosition.end ||
                              widget.timeAndStatusPosition ==
                                  TimeAndStatusPosition.inline
                          ? 8
                          : null,
                  start:
                      widget.timeAndStatusPosition ==
                              TimeAndStatusPosition.start
                          ? 8
                          : null,
                  child: timeAndStatus,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
