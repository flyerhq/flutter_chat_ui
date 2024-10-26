// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scroll_to_bottom_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScrollToBottomTheme {
  Color? get backgroundColor => throw _privateConstructorUsedError;
  Color? get foregroundColor => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ScrollToBottomThemeImpl extends _ScrollToBottomTheme {
  const _$ScrollToBottomThemeImpl({this.backgroundColor, this.foregroundColor})
      : super._();

  @override
  final Color? backgroundColor;
  @override
  final Color? foregroundColor;

  @override
  String toString() {
    return 'ScrollToBottomTheme(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrollToBottomThemeImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.foregroundColor, foregroundColor) ||
                other.foregroundColor == foregroundColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, backgroundColor, foregroundColor);
}

abstract class _ScrollToBottomTheme extends ScrollToBottomTheme {
  const factory _ScrollToBottomTheme(
      {final Color? backgroundColor,
      final Color? foregroundColor}) = _$ScrollToBottomThemeImpl;
  const _ScrollToBottomTheme._() : super._();

  @override
  Color? get backgroundColor;
  @override
  Color? get foregroundColor;
}
