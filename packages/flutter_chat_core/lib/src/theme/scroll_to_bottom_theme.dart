import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'scroll_to_bottom_theme_constants.dart';

part 'scroll_to_bottom_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class ScrollToBottomTheme with _$ScrollToBottomTheme {
  factory ScrollToBottomTheme.light({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ScrollToBottomTheme(
      backgroundColor:
          backgroundColor ?? defaultScrollToBottomBackgroundColor.light,
      foregroundColor:
          foregroundColor ?? defaultScrollToBottomForegroundColor.light,
    );
  }

  factory ScrollToBottomTheme.dark({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ScrollToBottomTheme(
      backgroundColor:
          backgroundColor ?? defaultScrollToBottomBackgroundColor.dark,
      foregroundColor:
          foregroundColor ?? defaultScrollToBottomForegroundColor.dark,
    );
  }

  const factory ScrollToBottomTheme({
    Color? backgroundColor,
    Color? foregroundColor,
  }) = _ScrollToBottomTheme;

  const ScrollToBottomTheme._();

  factory ScrollToBottomTheme.fromThemeData(ThemeData themeData) {
    return ScrollToBottomTheme(
      backgroundColor: themeData.colorScheme.surfaceContainerHigh,
      foregroundColor: themeData.colorScheme.primary,
    );
  }

  ScrollToBottomTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ScrollToBottomTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  ScrollToBottomTheme merge(ScrollToBottomTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
    );
  }
}
