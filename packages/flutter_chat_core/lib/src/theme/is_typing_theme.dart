import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'is_typing_theme_constants.dart';

part 'is_typing_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class IsTypingTheme with _$IsTypingTheme {
  factory IsTypingTheme.light({
    Color? color,
  }) {
    return IsTypingTheme(
      color: color ?? defaultIsTypingColor.light,
    );
  }

  factory IsTypingTheme.dark({
    Color? color,
  }) {
    return IsTypingTheme(
      color: color ?? defaultIsTypingColor.dark,
    );
  }

  const factory IsTypingTheme({
    Color? color,
  }) = _IsTypingTheme;

  const IsTypingTheme._();

  factory IsTypingTheme.fromThemeData(ThemeData themeData) {
    return IsTypingTheme(
      color: themeData.colorScheme.primary,
    );
  }

  IsTypingTheme copyWith({
    Color? color,
  }) {
    return IsTypingTheme(
      color: color ?? this.color,
    );
  }

  IsTypingTheme merge(IsTypingTheme? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
    );
  }
}
