import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart'
    show rgbaToBmp, thumbHashToApproximateAspectRatio, thumbHashToRGBA;
import 'package:video_player/video_player.dart';
import 'helpers/is_network_source.dart';
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

  /// Color of the overlay shown during video loading for a sent message
  final Color? sentLoadingOverlayColor;

  /// Color of the overlay shown during video loading for a received message
  final Color? receivedLoadingOverlayColor;

  /// Color of the circular progress indicator shown during video loading.
  final Color? loadingIndicatorColor;

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

  /// Background color used while the image thumbnail is visible.
  final Color? placeholderColor;

  /// Creates a widget to display an video message.
  const FlyerChatVideoMessage({
    super.key,
    required this.message,
    this.headers,
    this.borderRadius,
    this.constraints = const BoxConstraints(maxHeight: 300),
    this.sentLoadingOverlayColor,
    this.receivedLoadingOverlayColor,
    this.loadingIndicatorColor,
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
    this.placeholderColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlyerChatVideoMessageState createState() => _FlyerChatVideoMessageState();
}

/// State for [FlyerChatVideoMessage].
class _FlyerChatVideoMessageState extends State<FlyerChatVideoMessage> {
  late final ChatController _chatController;
  VideoPlayerController? _videoPlayerController;
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
    _initalizeVideoPlayerAsync();
  }

  Future<void> _initalizeVideoPlayerAsync() async {
    if (isNetworkSource(widget.message.source)) {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.message.source),
        httpHeaders: widget.headers ?? {},
      );
    } else {
      _videoPlayerController = VideoPlayerController.file(
        File(widget.message.source),
      );
    }
    await _videoPlayerController!.initialize().then((_) {
      setState(() {
        _aspectRatio = _videoPlayerController!.value.aspectRatio;
      });
    });
  }

  @override
  void didUpdateWidget(FlyerChatVideoMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.source != widget.message.source) {
      _initalizeVideoPlayerAsync();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
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
                _placeholderProvider != null
                    ? Image(image: _placeholderProvider!, fit: BoxFit.fill)
                    : Container(
                      color:
                          widget.placeholderColor ??
                          theme.colors.surfaceContainerLow,
                    ),
                Hero(
                  tag: widget.message.id,
                  child:
                      _videoPlayerController?.value.isInitialized == true
                          ? VideoPlayer(_videoPlayerController!)
                          : Container(
                            color: _resolveBackgroundColor(isSentByMe, theme),
                            child: Center(
                              child: CircularProgressIndicator(
                                color:
                                    widget
                                        .fullScreenPlayerLoadingIndicatorColor ??
                                    theme.colors.onSurface.withValues(
                                      alpha: 0.8,
                                    ),
                              ),
                            ),
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
      return widget.sentLoadingOverlayColor ?? theme.colors.primary;
    }
    return widget.receivedLoadingOverlayColor ?? theme.colors.surfaceContainer;
  }
}
