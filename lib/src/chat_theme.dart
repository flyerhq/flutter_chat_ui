import 'package:flutter/material.dart';

/// Base chat theme containing all required variables to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class ChatTheme {
  /// Creates a new chat theme based on provided colors and text styles.
  const ChatTheme({
    required this.backgroundColor,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.captionColor,
    required this.errorColor,
    required this.inputBackgroundColor,
    required this.inputTextColor,
    required this.primaryColor,
    required this.primaryTextColor,
    required this.secondaryColor,
    required this.secondaryTextColor,
    required this.subtitle1,
    required this.subtitle2,
  });

  /// Used as a background color of a chat widget
  final Color backgroundColor;

  /// Used as a primary text style in messages
  final TextStyle body1;

  /// Slightly smaller [body1]
  final TextStyle body2;

  /// Smallest text style, used for displaying message's time
  final TextStyle caption;

  /// Color usually goes with a [caption] text style
  final Color captionColor;

  /// Color to indicate something bad happended (usually shades of red)
  final Color errorColor;

  /// Color of the bottom bar where text field is
  final Color inputBackgroundColor;

  /// Color of the text field's text and attachment/send buttons
  final Color inputTextColor;

  /// Primary color of the chat, used as a background of your messages
  final Color primaryColor;

  /// Color of the text on a [primaryColor]
  final Color primaryTextColor;

  /// Secondary color, used as a backgroud of received messages
  final Color secondaryColor;

  /// Color of the text on a [secondaryColor]
  final Color secondaryTextColor;

  /// Largest text style, used for displaying title of a link preview
  final TextStyle subtitle1;

  /// Subtitle, used for date dividers in the chat
  final TextStyle subtitle2;
}

/// Default chat theme which extends [ChatTheme]
@immutable
class DefaultChatTheme extends ChatTheme {
  /// Creates a default chat theme. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatTheme]
  const DefaultChatTheme({
    Color backgroundColor = const Color(0xffffffff),
    TextStyle body1 = const TextStyle(
      fontFamily: 'Avenir',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.375,
    ),
    TextStyle body2 = const TextStyle(
      fontFamily: 'Avenir',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle caption = const TextStyle(
      fontFamily: 'Avenir',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color captionColor = const Color(0xff9e9cab),
    Color errorColor = const Color(0xffff6767),
    Color inputBackgroundColor = const Color(0xff1d1d21),
    Color inputTextColor = const Color(0xffffffff),
    Color primaryColor = const Color(0xff6f61e8),
    Color primaryTextColor = const Color(0xffffffff),
    Color secondaryColor = const Color(0xfff7f7f8),
    Color secondaryTextColor = const Color(0xff1d1d21),
    TextStyle subtitle1 = const TextStyle(
      fontFamily: 'Avenir',
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    TextStyle subtitle2 = const TextStyle(
      fontFamily: 'Avenir',
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  }) : super(
          backgroundColor: backgroundColor,
          body1: body1,
          body2: body2,
          caption: caption,
          captionColor: captionColor,
          errorColor: errorColor,
          inputBackgroundColor: inputBackgroundColor,
          inputTextColor: inputTextColor,
          primaryColor: primaryColor,
          primaryTextColor: primaryTextColor,
          secondaryColor: secondaryColor,
          secondaryTextColor: secondaryTextColor,
          subtitle1: subtitle1,
          subtitle2: subtitle2,
        );
}
