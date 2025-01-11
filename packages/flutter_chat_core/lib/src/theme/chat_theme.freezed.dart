// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatTheme {
  Color get backgroundColor => throw _privateConstructorUsedError;
  String get fontFamily => throw _privateConstructorUsedError;
  ImageMessageTheme get imageMessageTheme => throw _privateConstructorUsedError;
  InputTheme get inputTheme => throw _privateConstructorUsedError;
  IsTypingTheme get isTypingTheme => throw _privateConstructorUsedError;
  ScrollToBottomTheme get scrollToBottomTheme =>
      throw _privateConstructorUsedError;
  TextMessageTheme get textMessageTheme => throw _privateConstructorUsedError;
}

/// @nodoc

class _$ChatThemeImpl extends _ChatTheme {
  const _$ChatThemeImpl(
      {required this.backgroundColor,
      required this.fontFamily,
      required this.imageMessageTheme,
      required this.inputTheme,
      required this.isTypingTheme,
      required this.scrollToBottomTheme,
      required this.textMessageTheme})
      : super._();

  @override
  final Color backgroundColor;
  @override
  final String fontFamily;
  @override
  final ImageMessageTheme imageMessageTheme;
  @override
  final InputTheme inputTheme;
  @override
  final IsTypingTheme isTypingTheme;
  @override
  final ScrollToBottomTheme scrollToBottomTheme;
  @override
  final TextMessageTheme textMessageTheme;

  @override
  String toString() {
    return 'ChatTheme(backgroundColor: $backgroundColor, fontFamily: $fontFamily, imageMessageTheme: $imageMessageTheme, inputTheme: $inputTheme, isTypingTheme: $isTypingTheme, scrollToBottomTheme: $scrollToBottomTheme, textMessageTheme: $textMessageTheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThemeImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.imageMessageTheme, imageMessageTheme) ||
                other.imageMessageTheme == imageMessageTheme) &&
            (identical(other.inputTheme, inputTheme) ||
                other.inputTheme == inputTheme) &&
            (identical(other.isTypingTheme, isTypingTheme) ||
                other.isTypingTheme == isTypingTheme) &&
            (identical(other.scrollToBottomTheme, scrollToBottomTheme) ||
                other.scrollToBottomTheme == scrollToBottomTheme) &&
            (identical(other.textMessageTheme, textMessageTheme) ||
                other.textMessageTheme == textMessageTheme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      fontFamily,
      imageMessageTheme,
      inputTheme,
      isTypingTheme,
      scrollToBottomTheme,
      textMessageTheme);
}

abstract class _ChatTheme extends ChatTheme {
  const factory _ChatTheme(
      {required final Color backgroundColor,
      required final String fontFamily,
      required final ImageMessageTheme imageMessageTheme,
      required final InputTheme inputTheme,
      required final IsTypingTheme isTypingTheme,
      required final ScrollToBottomTheme scrollToBottomTheme,
      required final TextMessageTheme textMessageTheme}) = _$ChatThemeImpl;
  const _ChatTheme._() : super._();

  @override
  Color get backgroundColor;
  @override
  String get fontFamily;
  @override
  ImageMessageTheme get imageMessageTheme;
  @override
  InputTheme get inputTheme;
  @override
  IsTypingTheme get isTypingTheme;
  @override
  ScrollToBottomTheme get scrollToBottomTheme;
  @override
  TextMessageTheme get textMessageTheme;
}
