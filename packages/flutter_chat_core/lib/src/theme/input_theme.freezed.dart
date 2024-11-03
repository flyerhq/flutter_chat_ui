// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InputTheme {
  Color? get backgroundColor => throw _privateConstructorUsedError;
  Color? get textFieldColor => throw _privateConstructorUsedError;
  TextStyle? get hintStyle => throw _privateConstructorUsedError;
  TextStyle? get textStyle => throw _privateConstructorUsedError;
}

/// @nodoc

class _$InputThemeImpl extends _InputTheme {
  const _$InputThemeImpl(
      {this.backgroundColor,
      this.textFieldColor,
      this.hintStyle,
      this.textStyle})
      : super._();

  @override
  final Color? backgroundColor;
  @override
  final Color? textFieldColor;
  @override
  final TextStyle? hintStyle;
  @override
  final TextStyle? textStyle;

  @override
  String toString() {
    return 'InputTheme(backgroundColor: $backgroundColor, textFieldColor: $textFieldColor, hintStyle: $hintStyle, textStyle: $textStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputThemeImpl &&
            const DeepCollectionEquality()
                .equals(other.backgroundColor, backgroundColor) &&
            const DeepCollectionEquality()
                .equals(other.textFieldColor, textFieldColor) &&
            (identical(other.hintStyle, hintStyle) ||
                other.hintStyle == hintStyle) &&
            (identical(other.textStyle, textStyle) ||
                other.textStyle == textStyle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(textFieldColor),
      hintStyle,
      textStyle);
}

abstract class _InputTheme extends InputTheme {
  const factory _InputTheme(
      {final Color? backgroundColor,
      final Color? textFieldColor,
      final TextStyle? hintStyle,
      final TextStyle? textStyle}) = _$InputThemeImpl;
  const _InputTheme._() : super._();

  @override
  Color? get backgroundColor;
  @override
  Color? get textFieldColor;
  @override
  TextStyle? get hintStyle;
  @override
  TextStyle? get textStyle;
}
