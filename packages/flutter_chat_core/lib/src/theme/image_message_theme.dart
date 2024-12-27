import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_message_theme_constants.dart';

part 'image_message_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class ImageMessageTheme with _$ImageMessageTheme {
  factory ImageMessageTheme.light({
    Color? placeholderColor,
    Color? downloadProgressIndicatorColor,
    Color? uploadProgressIndicatorColor,
    Color? uploadOverlayColor,
  }) {
    return ImageMessageTheme(
      placeholderColor: placeholderColor ?? defaultImagePlaceholderColor.light,
      downloadProgressIndicatorColor: downloadProgressIndicatorColor ??
          defaultImageDownloadProgressIndicatorColor.light,
      uploadProgressIndicatorColor: uploadProgressIndicatorColor ??
          defaultImageUploadProgressIndicatorColor.light,
      uploadOverlayColor:
          uploadOverlayColor ?? defaultImageUploadOverlayColor.light,
    );
  }

  factory ImageMessageTheme.dark({
    Color? placeholderColor,
    Color? downloadProgressIndicatorColor,
    Color? uploadProgressIndicatorColor,
    Color? uploadOverlayColor,
  }) {
    return ImageMessageTheme(
      placeholderColor: placeholderColor ?? defaultImagePlaceholderColor.dark,
      downloadProgressIndicatorColor: downloadProgressIndicatorColor ??
          defaultImageDownloadProgressIndicatorColor.dark,
      uploadProgressIndicatorColor: uploadProgressIndicatorColor ??
          defaultImageUploadProgressIndicatorColor.dark,
      uploadOverlayColor:
          uploadOverlayColor ?? defaultImageUploadOverlayColor.dark,
    );
  }

  const factory ImageMessageTheme({
    Color? placeholderColor,
    Color? downloadProgressIndicatorColor,
    Color? uploadProgressIndicatorColor,
    Color? uploadOverlayColor,
  }) = _ImageMessageTheme;

  const ImageMessageTheme._();

  factory ImageMessageTheme.fromThemeData(ThemeData themeData) {
    return ImageMessageTheme(
      placeholderColor: themeData.colorScheme.surfaceContainerLow,
      downloadProgressIndicatorColor: themeData.colorScheme.primary,
      uploadProgressIndicatorColor: themeData.colorScheme.primary,
      uploadOverlayColor:
          themeData.colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
    );
  }

  ImageMessageTheme copyWith({
    Color? placeholderColor,
    Color? downloadProgressIndicatorColor,
    Color? uploadProgressIndicatorColor,
    Color? uploadOverlayColor,
  }) {
    return ImageMessageTheme(
      placeholderColor: placeholderColor ?? this.placeholderColor,
      downloadProgressIndicatorColor:
          downloadProgressIndicatorColor ?? this.downloadProgressIndicatorColor,
      uploadProgressIndicatorColor:
          uploadProgressIndicatorColor ?? this.uploadProgressIndicatorColor,
      uploadOverlayColor: uploadOverlayColor ?? this.uploadOverlayColor,
    );
  }

  ImageMessageTheme merge(ImageMessageTheme? other) {
    if (other == null) return this;
    return copyWith(
      placeholderColor: other.placeholderColor,
      downloadProgressIndicatorColor: other.downloadProgressIndicatorColor,
      uploadProgressIndicatorColor: other.uploadProgressIndicatorColor,
      uploadOverlayColor: other.uploadOverlayColor,
    );
  }
}
