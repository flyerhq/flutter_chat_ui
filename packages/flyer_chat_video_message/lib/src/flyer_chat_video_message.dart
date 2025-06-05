import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart'
    show rgbaToBmp, thumbHashToApproximateAspectRatio, thumbHashToRGBA;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'widgets/full_screen_video_player.dart';
import 'widgets/hero_video_route.dart';
import 'widgets/time_and_status.dart';

/// A widget that displays an [VideoMessage].
///
/// Optionally displays upload progress if the [ChatController]
/// implements [UploadProgressMixin].
class FlyerChatVideoMessage extends StatefulWidget {
  /// The video message data model.
  final VideoMessage message;

  /// Optional HTTP headers for authenticated video requests.
  /// Commonly used for authorization tokens, e.g., {'Authorization': 'Bearer token'}.
  final Map<String, String>? headers;

  /// Border radius of the video container.
  final BorderRadiusGeometry? borderRadius;

  /// Constraints for the video size.
  final BoxConstraints? constraints;

  /// Background color for a sent message while image cover is generated
  final Color? sentBackGroundColor;

  /// Background color for a received message while image cover is generated
  final Color? receivedBackgroundColor;

  /// Color of the overlay shown during video upload.
  final Color? uploadOverlayColor;

  /// Color of the circular progress indicator shown during video upload.
  final Color? uploadIndicatorColor;

  /// Text style for the message timestamp and status.
  final TextStyle? timeStyle;

  /// Background color for the timestamp and status display.
  final Color? timeBackground;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the video.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// Wheter to use the root navigator to push the video player.
  final bool useRootNavigator;

  /// Background color for the full screen video player.
  final Color? fullScreenPlayerBackgroundColor;

  /// Background color for the full screen video player.
  final Color? fullScreenPlayerLoadingIndicatorColor;

  /// Icon data to display as the play button overlay.
  final IconData playIcon;

  /// Size of the play icon.
  final double playIconSize;

  /// Color of the play icon.
  final Color playIconColor;

  /// Optional builder function that returns a Future of high resolution thumbnail [ImageProvider]
  /// for the video message. If provided, this will be used instead of the default
  /// thumbnail generation.
  final Future<ImageProvider?> Function()? highResThumbnailProviderBuilder;

  /// Creates a widget to display an video message.
  const FlyerChatVideoMessage({
    super.key,
    required this.message,
    this.headers,
    this.borderRadius,
    this.constraints = const BoxConstraints(maxHeight: 300),
    this.sentBackGroundColor,
    this.receivedBackgroundColor,
    this.uploadOverlayColor,
    this.uploadIndicatorColor,
    this.timeStyle,
    this.timeBackground,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.useRootNavigator = false,
    this.fullScreenPlayerBackgroundColor,
    this.fullScreenPlayerLoadingIndicatorColor,
    this.playIcon = Icons.play_circle_fill,
    this.playIconSize = 48,
    this.playIconColor = Colors.white,
    this.highResThumbnailProviderBuilder,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlyerChatVideoMessageState createState() => _FlyerChatVideoMessageState();
}

/// State for [FlyerChatVideoMessage].
class _FlyerChatVideoMessageState extends State<FlyerChatVideoMessage> {
  late final ChatController _chatController;
  ImageProvider? _placeholderProvider;
  late double _aspectRatio;

  @override
  void initState() {
    super.initState();

    final height = widget.message.height;
    final width = widget.message.width;
    if (height != null && width != null && height > 0 && width > 0) {
      _aspectRatio = width / height;
    } else {
      _aspectRatio = 9 / 16;
    }

    if (widget.message.thumbhash?.isNotEmpty ?? false) {
      final thumbhashBytes = base64.decode(
        base64.normalize(widget.message.thumbhash!),
      );

      _aspectRatio = thumbHashToApproximateAspectRatio(thumbhashBytes);

      final rgbaImage = thumbHashToRGBA(thumbhashBytes);
      final bmp = rgbaToBmp(rgbaImage);
      _placeholderProvider = MemoryImage(bmp);
    }

    _chatController = context.read<ChatController>();
    try {
      _generateImageCover();
    } catch (e) {
      debugPrint('Could not generate image cover: ${e.toString()}');
    }
  }

  Future<void> _generateImageCover() async {
    if (widget.highResThumbnailProviderBuilder != null) {
      final provider = await widget.highResThumbnailProviderBuilder!();
      if (mounted && provider != null) {
        setState(() {
          _placeholderProvider = provider;
        });
      }
      return;
    }

    // TODO use cache manager (or crosscache? to save the image)
    final coverImageBytes = await VideoThumbnail.thumbnailData(
      video: widget.message.source,
      imageFormat: ImageFormat.WEBP,
      quality: 25,
      headers: widget.headers,
    );
    if (mounted) {
      setState(() {
        // TODO should we add 'image' package to decode and get height and width
        // to update _aspectRatio?

        // import 'package:image/image.dart' as img;

        // final decoded = img.decodeImage(coverImageBytes!);
        // if (decoded != null) {
        //   final width = decoded.width;
        //   final height = decoded.height;
        // }

        _placeholderProvider = MemoryImage(coverImageBytes!);
      });
    }
  }

  @override
  void didUpdateWidget(FlyerChatVideoMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.source != widget.message.source) {
      _generateImageCover();
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
          child: GestureDetector(
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: widget.useRootNavigator,
              ).push(
                HeroVideoRoute(
                  fullscreenDialog: true,
                  builder:
                      (_) => FullscreenVideoPlayer(
                        source: widget.message.source,
                        aspectRatio: _aspectRatio,
                        heroTag: widget.message.id,
                        backgroundColor: widget.fullScreenPlayerBackgroundColor,
                        loadingIndicatorColor:
                            widget.fullScreenPlayerLoadingIndicatorColor ??
                            theme.colors.onSurface.withValues(alpha: 0.8),
                      ),
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: widget.message.id,
                  child:
                      _placeholderProvider != null
                          ? Image(
                            image: _placeholderProvider!,
                            fit: BoxFit.fill,
                          )
                          : Container(
                            color:
                                _resolveBackgroundColor(isSentByMe, theme) ??
                                theme.colors.surfaceContainerLow,
                          ),
                ),
                Icon(
                  widget.playIcon,
                  size: widget.playIconSize,
                  color: widget.playIconColor,
                ),
                if (_chatController is UploadProgressMixin)
                  StreamBuilder<double>(
                    stream: (_chatController as UploadProgressMixin)
                        .getUploadProgress(widget.message.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data! >= 1) {
                        return const SizedBox();
                      }

                      return Container(
                        color:
                            widget.uploadOverlayColor ??
                            theme.colors.surfaceContainerLow.withValues(
                              alpha: 0.5,
                            ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color:
                                widget.uploadIndicatorColor ??
                                theme.colors.onSurface.withValues(alpha: 0.8),
                            strokeCap: StrokeCap.round,
                            value: snapshot.data,
                          ),
                        ),
                      );
                    },
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
      ),
    );
  }

  Color? _resolveBackgroundColor(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return widget.sentBackGroundColor ?? theme.colors.primary;
    }
    return widget.receivedBackgroundColor ?? theme.colors.surfaceContainer;
  }
}
