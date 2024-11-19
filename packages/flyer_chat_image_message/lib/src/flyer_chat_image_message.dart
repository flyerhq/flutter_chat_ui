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
  final ImageMessage message;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

  const FlyerChatImageMessage({
    super.key,
    required this.message,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.constraints = const BoxConstraints(maxHeight: 300, minWidth: 170),
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
      final thumbhashBytes =
          base64.decode(base64.normalize(widget.message.thumbhash!));

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

    final crossCache = Provider.of<CrossCache>(context, listen: false);

    _chatController = Provider.of<ChatController>(context, listen: false);
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
    if (oldWidget.message.source != widget.message.source) {
      final crossCache = Provider.of<CrossCache>(context, listen: false);
      final newImage = CachedNetworkImage(widget.message.source, crossCache);

      precacheImage(newImage, context).then((_) {
        if (mounted) {
          _cachedNetworkImage = newImage;
        }
      });
    }
    super.didUpdateWidget(oldWidget);
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
    final imageMessageTheme =
        context.select((ChatTheme theme) => theme.imageMessageTheme);

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Container(
        constraints: widget.constraints,
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _placeholderProvider != null
                  ? Image(
                      image: _placeholderProvider!,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      color: imageMessageTheme.placeholderColor,
                    ),
              Image(
                image: _cachedNetworkImage,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: imageMessageTheme.downloadProgressIndicatorColor,
                      strokeCap: StrokeCap.round,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) {
                    return child;
                  }

                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: frame == null ? 0 : 1,
                    curve: Curves.fastOutSlowIn,
                    child: child,
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
                      color: imageMessageTheme.uploadOverlayColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: imageMessageTheme.uploadProgressIndicatorColor,
                          strokeCap: StrokeCap.round,
                          value: snapshot.data,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
