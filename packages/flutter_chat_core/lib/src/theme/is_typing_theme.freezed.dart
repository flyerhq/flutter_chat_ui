// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'is_typing_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IsTypingTheme {
  Color? get color => throw _privateConstructorUsedError;
}

/// @nodoc

class _$IsTypingThemeImpl extends _IsTypingTheme {
  const _$IsTypingThemeImpl({this.color}) : super._();

  @override
  final Color? color;

  @override
  String toString() {
    return 'IsTypingTheme(color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsTypingThemeImpl &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, color);
}

abstract class _IsTypingTheme extends IsTypingTheme {
  const factory _IsTypingTheme({final Color? color}) = _$IsTypingThemeImpl;
  const _IsTypingTheme._() : super._();

  @override
  Color? get color;
}
