import 'dart:convert';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image/image.dart' show encodeJpg;
import 'package:provider/provider.dart';
import 'package:thumbhash/thumbhash.dart'
    show rgbaToBmp, thumbHashToApproximateAspectRatio, thumbHashToRGBA;

import 'custom_network_image.dart';
import 'preload_image_provider.dart';

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
  late ChatController _chatController;
  late CustomNetworkImage _customNetworkImage;
  late double _aspectRatio;
  ImageProvider? _placeholderProvider;

  @override
  void initState() {
    super.initState();

    if (widget.message.width != null && widget.message.height != null) {
      _aspectRatio = widget.message.width! / widget.message.height!;
    } else if (widget.message.thumbhash != null) {
      final thumbhashBytes =
          base64.decode(base64.normalize(widget.message.thumbhash!));

      _aspectRatio = thumbHashToApproximateAspectRatio(thumbhashBytes);

      final rgbaImage = thumbHashToRGBA(thumbhashBytes);
      final bmp = rgbaToBmp(rgbaImage);
      _placeholderProvider = MemoryImage(bmp);
    } else if (widget.message.blurhash != null) {
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
    _customNetworkImage = CustomNetworkImage(widget.message.source, crossCache);

    if (widget.message.width == null || widget.message.height == null) {
      getDimensions(_customNetworkImage).then((dimensions) {
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
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);
    final imagePlaceholderColor =
        context.select((ChatTheme theme) => theme.imagePlaceholderColor);

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
                      color: imagePlaceholderColor,
                    ),
              Image(
                image: _customNetworkImage,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: backgroundColor.withOpacity(0.5),
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
            ],
          ),
        ),
      ),
    );
  }
}
