import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_theme_constants.dart';
import 'text_message_theme_constants.dart';

part 'text_message_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class TextMessageTheme with _$TextMessageTheme {
  factory TextMessageTheme.light({
    String? fontFamily,
    Color? receivedBackgroundColor,
    TextStyle? receivedTextStyle,
    Color? sentBackgroundColor,
    TextStyle? sentTextStyle,
  }) {
    return TextMessageTheme(
      receivedBackgroundColor:
          receivedBackgroundColor ?? defaultTextReceivedBackgroundColor.light,
      receivedTextStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultTextReceivedColor.light,
      ).merge(receivedTextStyle),
      sentBackgroundColor:
          sentBackgroundColor ?? defaultTextSentBackgroundColor.light,
      sentTextStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultTextSentColor.light,
      ).merge(sentTextStyle),
    );
  }

  factory TextMessageTheme.dark({
    String? fontFamily,
    Color? receivedBackgroundColor,
    TextStyle? receivedTextStyle,
    Color? sentBackgroundColor,
    TextStyle? sentTextStyle,
  }) {
    return TextMessageTheme(
      receivedBackgroundColor:
          receivedBackgroundColor ?? defaultTextReceivedBackgroundColor.dark,
      receivedTextStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultTextReceivedColor.dark,
      ).merge(receivedTextStyle),
      sentBackgroundColor:
          sentBackgroundColor ?? defaultTextSentBackgroundColor.dark,
      sentTextStyle: TextStyle(
        fontFamily: fontFamily ?? defaultChatFontFamily,
        color: defaultTextSentColor.dark,
      ).merge(sentTextStyle),
    );
  }

  const factory TextMessageTheme({
    Color? receivedBackgroundColor,
    TextStyle? receivedTextStyle,
    Color? sentBackgroundColor,
    TextStyle? sentTextStyle,
  }) = _TextMessageTheme;

  const TextMessageTheme._();

  factory TextMessageTheme.fromThemeData(
    ThemeData themeData, {
    String? fontFamily,
  }) {
    final family = fontFamily ??
        themeData.textTheme.bodyMedium?.fontFamily ??
        defaultChatFontFamily;

    return TextMessageTheme(
      receivedBackgroundColor: themeData.colorScheme.surfaceContainerHigh,
      receivedTextStyle: themeData.textTheme.bodyMedium?.copyWith(
        fontFamily: family,
        color: themeData.colorScheme.onSurface,
      ),
      sentBackgroundColor: themeData.colorScheme.primary,
      sentTextStyle: themeData.textTheme.bodyMedium?.copyWith(
        fontFamily: family,
        color: themeData.colorScheme.onPrimary,
      ),
    );
  }

  TextMessageTheme copyWith({
    Color? receivedBackgroundColor,
    TextStyle? receivedTextStyle,
    Color? sentBackgroundColor,
    TextStyle? sentTextStyle,
  }) {
    return TextMessageTheme(
      receivedBackgroundColor:
          receivedBackgroundColor ?? this.receivedBackgroundColor,
      receivedTextStyle:
          this.receivedTextStyle?.merge(receivedTextStyle) ?? receivedTextStyle,
      sentBackgroundColor: sentBackgroundColor ?? this.sentBackgroundColor,
      sentTextStyle: this.sentTextStyle?.merge(sentTextStyle) ?? sentTextStyle,
    );
  }

  TextMessageTheme merge(TextMessageTheme? other) {
    if (other == null) return this;
    return copyWith(
      receivedBackgroundColor: other.receivedBackgroundColor,
      receivedTextStyle: other.receivedTextStyle,
      sentBackgroundColor: other.sentBackgroundColor,
      sentTextStyle: other.sentTextStyle,
    );
  }
}
