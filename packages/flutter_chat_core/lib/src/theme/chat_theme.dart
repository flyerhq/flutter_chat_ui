import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_theme_constants.dart';
import 'input_theme.dart';
import 'scroll_to_bottom_theme.dart';
import 'text_message_theme.dart';

part 'chat_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class ChatTheme with _$ChatTheme {
  factory ChatTheme.light({
    Color? backgroundColor,
    String? fontFamily,
    Color? imagePlaceholderColor,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? defaultChatBackgroundColor.light,
      fontFamily: fontFamily ?? defaultChatFontFamily,
      imagePlaceholderColor:
          imagePlaceholderColor ?? defaultImagePlaceholderColor.light,
      inputTheme:
          InputTheme.light(fontFamily: fontFamily ?? defaultChatFontFamily)
              .merge(inputTheme),
      scrollToBottomTheme:
          ScrollToBottomTheme.light().merge(scrollToBottomTheme),
      textMessageTheme: TextMessageTheme.light(
        fontFamily: fontFamily ?? defaultChatFontFamily,
      ).merge(textMessageTheme),
    );
  }

  factory ChatTheme.dark({
    Color? backgroundColor,
    String? fontFamily,
    Color? imagePlaceholderColor,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? defaultChatBackgroundColor.dark,
      fontFamily: fontFamily ?? defaultChatFontFamily,
      imagePlaceholderColor:
          imagePlaceholderColor ?? defaultImagePlaceholderColor.dark,
      inputTheme:
          InputTheme.dark(fontFamily: fontFamily ?? defaultChatFontFamily)
              .merge(inputTheme),
      scrollToBottomTheme:
          ScrollToBottomTheme.dark().merge(scrollToBottomTheme),
      textMessageTheme: TextMessageTheme.dark(
        fontFamily: fontFamily ?? defaultChatFontFamily,
      ).merge(textMessageTheme),
    );
  }

  factory ChatTheme.fromThemeData(ThemeData themeData, {String? fontFamily}) {
    final family = fontFamily ??
        themeData.textTheme.bodyMedium?.fontFamily ??
        defaultChatFontFamily;

    return ChatTheme(
      backgroundColor: themeData.colorScheme.surface,
      fontFamily: family,
      imagePlaceholderColor: themeData.colorScheme.surfaceContainerLow,
      inputTheme: InputTheme.fromThemeData(themeData, fontFamily: family),
      scrollToBottomTheme: ScrollToBottomTheme.fromThemeData(themeData),
      textMessageTheme: TextMessageTheme.fromThemeData(
        themeData,
        fontFamily: family,
      ),
    );
  }

  const factory ChatTheme({
    required Color backgroundColor,
    required String fontFamily,
    required Color imagePlaceholderColor,
    required InputTheme inputTheme,
    required ScrollToBottomTheme scrollToBottomTheme,
    required TextMessageTheme textMessageTheme,
  }) = _ChatTheme;

  const ChatTheme._();

  ChatTheme copyWith({
    Color? backgroundColor,
    String? fontFamily,
    Color? imagePlaceholderColor,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      imagePlaceholderColor:
          imagePlaceholderColor ?? this.imagePlaceholderColor,
      inputTheme: this.inputTheme.merge(inputTheme),
      scrollToBottomTheme: this.scrollToBottomTheme.merge(scrollToBottomTheme),
      textMessageTheme: this.textMessageTheme.merge(textMessageTheme),
    );
  }

  ChatTheme merge(ChatTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      fontFamily: other.fontFamily,
      imagePlaceholderColor: other.imagePlaceholderColor,
      inputTheme: other.inputTheme,
      scrollToBottomTheme: other.scrollToBottomTheme,
      textMessageTheme: other.textMessageTheme,
    );
  }
}
