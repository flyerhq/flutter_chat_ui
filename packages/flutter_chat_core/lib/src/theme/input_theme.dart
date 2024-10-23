import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_theme_constants.dart';
import 'input_theme_constants.dart';

part 'input_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class InputTheme with _$InputTheme {
  factory InputTheme.light({
    Color? backgroundColor,
    String? fontFamily,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? defaultInputBackgroundColor.light,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        fontWeight: FontWeight.w400,
        color: defaultChatBackgroundColor.dark.withOpacity(0.6),
      ).merge(hintStyle),
      textStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultChatBackgroundColor.dark,
      ).merge(textStyle),
    );
  }

  factory InputTheme.dark({
    Color? backgroundColor,
    String? fontFamily,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? defaultInputBackgroundColor.dark,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        fontWeight: FontWeight.w400,
        color: defaultChatBackgroundColor.light.withOpacity(0.6),
      ).merge(hintStyle),
      textStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultChatBackgroundColor.light,
      ).merge(textStyle),
    );
  }

  factory InputTheme.fromThemeData(ThemeData themeData, {String? fontFamily}) {
    final family = fontFamily ??
        themeData.textTheme.bodyMedium?.fontFamily ??
        defaultChatFontFamily;

    return InputTheme(
      backgroundColor: themeData.colorScheme.surfaceContainerHigh,
      hintStyle: themeData.textTheme.bodyMedium?.copyWith(
        fontFamily: family,
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
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) = _InputTheme;

  const InputTheme._();

  InputTheme copyWith({
    Color? backgroundColor,
    TextStyle? hintStyle,
    TextStyle? textStyle,
  }) {
    return InputTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hintStyle: this.hintStyle?.merge(hintStyle) ?? hintStyle,
      textStyle: this.textStyle?.merge(textStyle) ?? textStyle,
    );
  }

  InputTheme merge(InputTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      hintStyle: other.hintStyle,
      textStyle: other.textStyle,
    );
  }
}
