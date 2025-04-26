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

class FlyerChatImageMessage extends StatefulWidget {
  static const BorderRadiusGeometry _sentinelBorderRadius = BorderRadius.zero;
  static const Color _sentinelColor = Colors.transparent;
  static const TextStyle _sentinelTextStyle = TextStyle();

  final ImageMessage message;
  final int index;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;
  final Widget? overlay;
  final Color? placeholderColor;
  final Color? loadingOverlayColor;
  final Color? loadingIndicatorColor;
  final Color? uploadOverlayColor;
  final Color? uploadIndicatorColor;
  final TextStyle? timeStyle;
  final Color? timeBackground;
  final bool showTime;
  final bool showStatus;
  final TimeAndStatusPosition timeAndStatusPosition;

  const FlyerChatImageMessage({
    super.key,
    required this.message,
    required this.index,
    this.borderRadius = _sentinelBorderRadius,
    this.constraints = const BoxConstraints(maxHeight: 300),
    this.overlay,
    this.placeholderColor = _sentinelColor,
    this.loadingOverlayColor = _sentinelColor,
    this.loadingIndicatorColor = _sentinelColor,
    this.uploadOverlayColor = _sentinelColor,
    this.uploadIndicatorColor = _sentinelColor,
    this.timeStyle = _sentinelTextStyle,
    this.timeBackground = _sentinelColor,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
  });

  @override
  FlyerChatImageMessageState createState() => FlyerChatImageMessageState();
}

class FlyerChatImageMessageState extends State<FlyerChatImageMessage>
    with TickerProviderStateMixin {
  late final ChatController _chatController;
  late CachedNetworkImage _cachedNetworkImage;
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

    final crossCache = context.read<CrossCache>();

    _chatController = context.read<ChatController>();
    _cachedNetworkImage = CachedNetworkImage(widget.message.source, crossCache);

    if (width == null || height == null) {
      getImageDimensions(_cachedNetworkImage).then((dimensions) {
        if (mounted) {
          _aspectRatio = dimensions.$1 / dimensions.$2;
          _chatController.update(
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
    if (oldWidget.message.source != widget.message.source) {
      final crossCache = context.read<CrossCache>();
      final newImage = CachedNetworkImage(widget.message.source, crossCache);

      precacheImage(newImage, context).then((_) {
        if (mounted) {
          _cachedNetworkImage = newImage;
        }
      });
    }
  }

  @override
  void dispose() {
    _placeholderProvider?.evict();
    // Evicting the cached network image on dispose will result in images flickering
    // _cachedNetworkImage.evict();
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
                  widget.timeBackground == FlyerChatImageMessage._sentinelColor
                      ? Colors.black.withValues(alpha: 0.6)
                      : widget.timeBackground,
              textStyle:
                  widget.timeStyle == FlyerChatImageMessage._sentinelTextStyle
                      ? theme.typography.labelSmall.copyWith(
                        color: Colors.white,
                      )
                      : widget.timeStyle,
            )
            : null;

    return ClipRRect(
      borderRadius:
          widget.borderRadius == FlyerChatImageMessage._sentinelBorderRadius
              ? theme.shape
              : (widget.borderRadius ?? BorderRadius.zero),
      child: Container(
        constraints: widget.constraints,
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _placeholderProvider != null
                  ? Image(image: _placeholderProvider!, fit: BoxFit.fill)
                  : Container(
                    color:
                        widget.placeholderColor ==
                                FlyerChatImageMessage._sentinelColor
                            ? theme.colors.surfaceContainerLow
                            : widget.placeholderColor,
                  ),
              Image(
                image: _cachedNetworkImage,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Container(
                    color:
                        widget.loadingOverlayColor ==
                                FlyerChatImageMessage._sentinelColor
                            ? theme.colors.surfaceContainerLow.withValues(
                              alpha: 0.5,
                            )
                            : widget.loadingOverlayColor,
                    child: Center(
                      child: CircularProgressIndicator(
                        color:
                            widget.loadingIndicatorColor ==
                                    FlyerChatImageMessage._sentinelColor
                                ? theme.colors.onSurface.withValues(alpha: 0.8)
                                : widget.loadingIndicatorColor,
                        strokeCap: StrokeCap.round,
                        value:
                            loadingProgress.expectedTotalBytes != null
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
                          widget.uploadOverlayColor ==
                                  FlyerChatImageMessage._sentinelColor
                              ? theme.colors.surfaceContainerLow.withValues(
                                alpha: 0.5,
                              )
                              : widget.uploadOverlayColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          color:
                              widget.uploadIndicatorColor ==
                                      FlyerChatImageMessage._sentinelColor
                                  ? theme.colors.onSurface.withValues(
                                    alpha: 0.8,
                                  )
                                  : widget.uploadIndicatorColor,
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
    );
  }
}

class TimeAndStatus extends StatelessWidget {
  final DateTime? time;
  final MessageStatus? status;
  final bool showTime;
  final bool showStatus;
  final Color? backgroundColor;
  final TextStyle? textStyle;

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
