// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_message_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageMessageTheme {
  Color? get placeholderColor => throw _privateConstructorUsedError;
  Color? get downloadProgressIndicatorColor =>
      throw _privateConstructorUsedError;
  Color? get uploadProgressIndicatorColor => throw _privateConstructorUsedError;
  Color? get uploadOverlayColor => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ImageMessageThemeImpl extends _ImageMessageTheme {
  const _$ImageMessageThemeImpl(
      {this.placeholderColor,
      this.downloadProgressIndicatorColor,
      this.uploadProgressIndicatorColor,
      this.uploadOverlayColor})
      : super._();

  @override
  final Color? placeholderColor;
  @override
  final Color? downloadProgressIndicatorColor;
  @override
  final Color? uploadProgressIndicatorColor;
  @override
  final Color? uploadOverlayColor;

  @override
  String toString() {
    return 'ImageMessageTheme(placeholderColor: $placeholderColor, downloadProgressIndicatorColor: $downloadProgressIndicatorColor, uploadProgressIndicatorColor: $uploadProgressIndicatorColor, uploadOverlayColor: $uploadOverlayColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageMessageThemeImpl &&
            (identical(other.placeholderColor, placeholderColor) ||
                other.placeholderColor == placeholderColor) &&
            (identical(other.downloadProgressIndicatorColor,
                    downloadProgressIndicatorColor) ||
                other.downloadProgressIndicatorColor ==
                    downloadProgressIndicatorColor) &&
            (identical(other.uploadProgressIndicatorColor,
                    uploadProgressIndicatorColor) ||
                other.uploadProgressIndicatorColor ==
                    uploadProgressIndicatorColor) &&
            (identical(other.uploadOverlayColor, uploadOverlayColor) ||
                other.uploadOverlayColor == uploadOverlayColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      placeholderColor,
      downloadProgressIndicatorColor,
      uploadProgressIndicatorColor,
      uploadOverlayColor);
}

abstract class _ImageMessageTheme extends ImageMessageTheme {
  const factory _ImageMessageTheme(
      {final Color? placeholderColor,
      final Color? downloadProgressIndicatorColor,
      final Color? uploadProgressIndicatorColor,
      final Color? uploadOverlayColor}) = _$ImageMessageThemeImpl;
  const _ImageMessageTheme._() : super._();

  @override
  Color? get placeholderColor;
  @override
  Color? get downloadProgressIndicatorColor;
  @override
  Color? get uploadProgressIndicatorColor;
  @override
  Color? get uploadOverlayColor;
}
