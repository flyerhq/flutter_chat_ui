import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_theme_constants.dart';
import 'image_message_theme.dart';
import 'input_theme.dart';
import 'scroll_to_bottom_theme.dart';
import 'text_message_theme.dart';

part 'chat_theme.freezed.dart';

@Freezed(fromJson: false, toJson: false, copyWith: false)
class ChatTheme with _$ChatTheme {
  factory ChatTheme.light({
    Color? backgroundColor,
    String? fontFamily,
    ImageMessageTheme? imageMessageTheme,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? defaultChatBackgroundColor.light,
      fontFamily: fontFamily ?? defaultChatFontFamily,
      imageMessageTheme: ImageMessageTheme.light().merge(imageMessageTheme),
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
    ImageMessageTheme? imageMessageTheme,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? defaultChatBackgroundColor.dark,
      fontFamily: fontFamily ?? defaultChatFontFamily,
      imageMessageTheme: ImageMessageTheme.dark().merge(imageMessageTheme),
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
      imageMessageTheme: ImageMessageTheme.fromThemeData(themeData),
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
    required ImageMessageTheme imageMessageTheme,
    required InputTheme inputTheme,
    required ScrollToBottomTheme scrollToBottomTheme,
    required TextMessageTheme textMessageTheme,
  }) = _ChatTheme;

  const ChatTheme._();

  ChatTheme copyWith({
    Color? backgroundColor,
    String? fontFamily,
    ImageMessageTheme? imageMessageTheme,
    InputTheme? inputTheme,
    ScrollToBottomTheme? scrollToBottomTheme,
    TextMessageTheme? textMessageTheme,
  }) {
    return ChatTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      imageMessageTheme: this.imageMessageTheme.merge(imageMessageTheme),
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
      imageMessageTheme: other.imageMessageTheme,
      inputTheme: other.inputTheme,
      scrollToBottomTheme: other.scrollToBottomTheme,
      textMessageTheme: other.textMessageTheme,
    );
  }
}
