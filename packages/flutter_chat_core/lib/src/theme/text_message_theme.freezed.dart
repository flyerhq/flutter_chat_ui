// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_message_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextMessageTheme {
  Color? get receivedBackgroundColor => throw _privateConstructorUsedError;
  TextStyle? get receivedTextStyle => throw _privateConstructorUsedError;
  Color? get sentBackgroundColor => throw _privateConstructorUsedError;
  TextStyle? get sentTextStyle => throw _privateConstructorUsedError;
}

/// @nodoc

class _$TextMessageThemeImpl extends _TextMessageTheme {
  const _$TextMessageThemeImpl(
      {this.receivedBackgroundColor,
      this.receivedTextStyle,
      this.sentBackgroundColor,
      this.sentTextStyle})
      : super._();

  @override
  final Color? receivedBackgroundColor;
  @override
  final TextStyle? receivedTextStyle;
  @override
  final Color? sentBackgroundColor;
  @override
  final TextStyle? sentTextStyle;

  @override
  String toString() {
    return 'TextMessageTheme(receivedBackgroundColor: $receivedBackgroundColor, receivedTextStyle: $receivedTextStyle, sentBackgroundColor: $sentBackgroundColor, sentTextStyle: $sentTextStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextMessageThemeImpl &&
            (identical(
                    other.receivedBackgroundColor, receivedBackgroundColor) ||
                other.receivedBackgroundColor == receivedBackgroundColor) &&
            (identical(other.receivedTextStyle, receivedTextStyle) ||
                other.receivedTextStyle == receivedTextStyle) &&
            (identical(other.sentBackgroundColor, sentBackgroundColor) ||
                other.sentBackgroundColor == sentBackgroundColor) &&
            (identical(other.sentTextStyle, sentTextStyle) ||
                other.sentTextStyle == sentTextStyle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receivedBackgroundColor,
      receivedTextStyle, sentBackgroundColor, sentTextStyle);
}

abstract class _TextMessageTheme extends TextMessageTheme {
  const factory _TextMessageTheme(
      {final Color? receivedBackgroundColor,
      final TextStyle? receivedTextStyle,
      final Color? sentBackgroundColor,
      final TextStyle? sentTextStyle}) = _$TextMessageThemeImpl;
  const _TextMessageTheme._() : super._();

  @override
  Color? get receivedBackgroundColor;
  @override
  TextStyle? get receivedTextStyle;
  @override
  Color? get sentBackgroundColor;
  @override
  TextStyle? get sentTextStyle;
}
