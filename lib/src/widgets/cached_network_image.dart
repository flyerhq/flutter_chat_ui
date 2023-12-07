import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../service/cache_service.dart';

extension TranslationExtension on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }

  ImageTypeFromUri get _imageType {
    final imageUri = this;

    if (imageUri.isEmpty) {
      return ImageTypeFromUri.nullPhoto;
    }
    if (imageUri == 'error') {
      return ImageTypeFromUri.error;
    } else if (imageUri.startsWith('https') || imageUri.startsWith('http')) {
      return ImageTypeFromUri.network;
    } else {
      return ImageTypeFromUri.local;
    }
  }

  LoadableImageModel get getImageType =>
      LoadableImageModel(uri: this, type: _imageType);
}

enum ImageTypeFromUri { local, network, nullPhoto, error }

class LoadableImageModel {
  final String? uri;
  final ImageTypeFromUri type;

  LoadableImageModel({this.uri, required this.type});
}

class CachedNetworkImageWidget extends StatefulWidget {
  final bool? isBoosted;
  final String url;
  final bool? isCircle;
  final bool? isBorder;
  final double? radius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? shadowColor;
  final bool? shadow;
  final BorderRadius? borderRadius;
  final bool secondTry;

  const CachedNetworkImageWidget({
    super.key,
    required this.url,
    this.placeholder,
    this.errorWidget,
    this.isCircle = false,
    this.radius,
    this.height,
    this.width,
    this.fit,
    this.shadowColor,
    this.shadow = false,
    this.secondTry = false,
    this.isBoosted = false,
    this.borderRadius,
    this.isBorder = false,
  });

  @override
  State<CachedNetworkImageWidget> createState() =>
      _CachedNetworkImageWidgetState();
}

class _CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  CachedNetworkImage _networkImage() {
    if (widget.isCircle != true) {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            boxShadow: widget.shadow == true
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 5,
                      offset: const Offset(20, 55),
                    ),
                  ]
                : null,
            borderRadius: widget.radius == null
                ? widget.borderRadius ?? BorderRadius.circular(12)
                : BorderRadius.circular(widget.radius ?? 12),
            image: DecorationImage(
              image: imageProvider,
              fit: widget.fit ?? BoxFit.cover,
            ),
          ),
        ),
        key: ValueKey(widget.url),
        httpHeaders: const {'Keep-Alive': 'timeout=1000'},
        imageUrl: widget.url,
        cacheKey: widget.url,
        cacheManager: CustomCacheManager.instance.cacheManager,
        fit: widget.fit ?? BoxFit.cover,
        height: widget.height,
        width: widget.width,
        placeholder: (context, url) => const SizedBox(),
        errorWidget: (context, url, error) =>
            widget.errorWidget ?? const Icon(Icons.error),
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
      );
    } else {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            boxShadow: widget.shadow == true
                ? [
                    BoxShadow(
                      color: widget.shadowColor ?? Colors.black,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 1,
                      offset: Offset.zero,
                    ),
                  ]
                : null,
            border: (widget.isBorder ?? false)
                ? Border.all(width: 4, color: Colors.black)
                : null,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              alignment: Alignment.center,
              fit: widget.fit ?? BoxFit.cover,
            ),
          ),
        ),
        key: ValueKey(widget.url),
        httpHeaders: const {'Keep-Alive': 'timeout=1000'},
        imageUrl: widget.url,
        cacheKey: widget.url,
        cacheManager: CustomCacheManager.instance.cacheManager,
        fit: BoxFit.cover,
        placeholder: (context, url) => widget.placeholder ?? const SizedBox(),
        errorWidget: (context, url, error) =>
            widget.errorWidget ?? const Icon(Icons.error),
        fadeInDuration: const Duration(milliseconds: 100),
        filterQuality: FilterQuality.high,
        height: widget.height ?? 42,
        width: widget.width ?? 42,
        alignment: Alignment.center,
        fadeOutDuration: const Duration(milliseconds: 100),
      );
    }
  }

  @override
  void didUpdateWidget(CachedNetworkImageWidget oldWidget) {
    if (oldWidget.url != widget.url) {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.url.getImageType.type) {
      case ImageTypeFromUri.error:
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              border: Border.all(
                width: .2,
                color: Colors.grey.shade900,
              ),
              borderRadius: widget.radius == null
                  ? widget.borderRadius ?? BorderRadius.circular(12)
                  : BorderRadius.circular(widget.radius ?? 12),
              color: Colors.black.withOpacity(.6)),
          child: Center(
            child: Icon(
              Icons.warning_amber_rounded,
              size: 26,
              color: Colors.red.shade800,
            ),
          ),
        );

      case ImageTypeFromUri.local:
        return ClipRRect(
          borderRadius: widget.radius == null
              ? widget.borderRadius ?? BorderRadius.circular(12)
              : BorderRadius.circular(widget.radius ?? 12),
          child: Image.file(
            File(widget.url.getImageType.uri ?? ''),
            height: widget.height,
            width: widget.width,
            fit: BoxFit.cover,
          ),
        );

      case ImageTypeFromUri.network:
        return _networkImage();

      default:
        return _networkImage();
    }
  }
}
