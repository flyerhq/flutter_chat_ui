import 'dart:convert';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image/image.dart' show encodeJpg;
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart' show rgbaToBmp, thumbHashToRGBA;

class SingleImageContainer extends StatefulWidget {
  const SingleImageContainer({
    super.key,
    required this.source,
    this.headers,
    this.customImageProvider,
    this.overlay,
    this.hasOverlay,
    this.placeholderColor,
    this.loadingOverlayColor,
    this.loadingIndicatorColor,
    this.uploadOverlayColor,
    this.uploadIndicatorColor,
    this.thumbhash,
    this.blurhash,
    this.imageFit = BoxFit.fill,
    this.uploadProgressId,
  });
  final String source;
  final Map<String, String>? headers;
  final ImageProvider? customImageProvider;
  final Widget? overlay;
  final bool? hasOverlay;
  final Color? placeholderColor;
  final Color? loadingOverlayColor;
  final Color? loadingIndicatorColor;
  final Color? uploadIndicatorColor;
  final Color? uploadOverlayColor;
  final String? thumbhash;
  final String? blurhash;
  final BoxFit imageFit;
  final String? uploadProgressId;

  @override
  State<SingleImageContainer> createState() => _SingleImageContainerState();
}

class _SingleImageContainerState extends State<SingleImageContainer> {
  late final ChatController _chatController;
  late ImageProvider _imageProvider;
  ImageProvider? _placeholderProvider;

  @override
  void initState() {
    super.initState();

    // TODO: Could be passed down? to avoid recomputing the placeholder
    // already done to the the aspectRatio
    if (widget.thumbhash?.isNotEmpty ?? false) {
      final thumbhashBytes = base64.decode(base64.normalize(widget.thumbhash!));
      final rgbaImage = thumbHashToRGBA(thumbhashBytes);
      final bmp = rgbaToBmp(rgbaImage);
      _placeholderProvider = MemoryImage(bmp);
    } else if (widget.blurhash?.isNotEmpty ?? false) {
      final blurhash = BlurHash.decode(widget.blurhash!);
      final image = blurhash.toImage(35, 20);
      final jpg = encodeJpg(image);
      _placeholderProvider = MemoryImage(jpg);
    }

    _chatController = context.read<ChatController>();
    _imageProvider = _targetProvider;
  }

  @override
  void didUpdateWidget(covariant SingleImageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source ||
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
    final theme = context.watch<ChatTheme>();

    return Stack(
      fit: StackFit.expand,
      children: [
        _placeholderProvider != null
            ? Image(image: _placeholderProvider!, fit: BoxFit.fill)
            : Container(
              color:
                  widget.placeholderColor ?? theme.colors.surfaceContainerLow,
            ),
        Image(
          image: _imageProvider,
          fit: widget.imageFit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return Container(
              color:
                  widget.loadingOverlayColor ??
                  theme.colors.surfaceContainerLow.withValues(alpha: 0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color:
                      widget.loadingIndicatorColor ??
                      theme.colors.onSurface.withValues(alpha: 0.8),
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
                widget.hasOverlay == true &&
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
        if (_chatController is UploadProgressMixin &&
            widget.uploadProgressId != null)
          StreamBuilder<double>(
            stream: (_chatController as UploadProgressMixin).getUploadProgress(
              widget.uploadProgressId!,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data! >= 1) {
                return const SizedBox();
              }

              return Container(
                color:
                    widget.uploadOverlayColor ??
                    theme.colors.surfaceContainerLow.withValues(alpha: 0.5),
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
      ],
    );
  }

  ImageProvider get _targetProvider {
    if (widget.customImageProvider != null) {
      return widget.customImageProvider!;
    } else {
      final crossCache = context.read<CrossCache>();
      return CachedNetworkImage(
        widget.source,
        crossCache,
        headers: widget.headers,
      );
    }
  }
}
