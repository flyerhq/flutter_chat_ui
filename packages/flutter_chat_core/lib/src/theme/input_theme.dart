import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_theme_constants.dart';
import 'input_theme_constants.dart';

part 'input_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class InputTheme with _$InputTheme {
  factory InputTheme.light({
    Color? backgroundColor,
    Color? textFieldColor,
    String? fontFamily,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? defaultInputBackgroundColor.light,
      textFieldColor: textFieldColor ?? defaultInputTextFieldColor.light,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        fontWeight: FontWeight.w400,
        color: defaultInputHintColor.light,
      ).merge(hintStyle),
      textStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultInputTextColor.light,
      ).merge(textStyle),
    );
  }

  factory InputTheme.dark({
    Color? backgroundColor,
    Color? textFieldColor,
    String? fontFamily,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? defaultInputBackgroundColor.dark,
      textFieldColor: textFieldColor ?? defaultInputTextFieldColor.dark,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        fontWeight: FontWeight.w400,
        color: defaultInputHintColor.dark,
      ).merge(hintStyle),
      textStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultInputTextColor.dark,
      ).merge(textStyle),
    );
  }

  factory InputTheme.fromThemeData(ThemeData themeData, {String? fontFamily}) {
    final family = fontFamily ??
        themeData.textTheme.bodyMedium?.fontFamily ??
        defaultChatFontFamily;

    return InputTheme(
      // This API is deprecated in Dart ^3.6 and we support Dart ^3.3
      // ignore: deprecated_member_use
      backgroundColor: themeData.colorScheme.surface.withOpacity(0.8),
      textFieldColor: themeData.colorScheme.surfaceContainerHigh,
      hintStyle: themeData.textTheme.bodyMedium?.copyWith(
        fontFamily: family,
        // This API is deprecated in Dart ^3.6 and we support Dart ^3.3
        // ignore: deprecated_member_use
        color: themeData.textTheme.bodyMedium?.color?.withOpacity(0.6),
      ),
      textStyle: themeData.textTheme.bodyMedium?.copyWith(
        fontFamily: family,
        color: themeData.colorScheme.onSurface,
      ),
    );
  }

  const factory InputTheme({
    Color? backgroundColor,
    Color? textFieldColor,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) = _InputTheme;

  const InputTheme._();

  InputTheme copyWith({
    Color? backgroundColor,
    Color? textFieldColor,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textFieldColor: textFieldColor ?? this.textFieldColor,
      hintStyle: this.hintStyle?.merge(hintStyle) ?? hintStyle,
      textStyle: this.textStyle?.merge(textStyle) ?? textStyle,
    );
  }

  InputTheme merge(InputTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      textFieldColor: other.textFieldColor,
      hintStyle: other.hintStyle,
      textStyle: other.textStyle,
    );
  }
}
