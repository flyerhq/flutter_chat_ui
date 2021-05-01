import 'package:flutter/material.dart';

/// Base chat theme containing all required variables to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class ChatTheme {
  /// Creates a new chat theme based on provided colors and text styles.
  const ChatTheme({
    required this.attachmentButtonIcon,
    required this.backgroundColor,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.captionColor,
    required this.deliveredIcon,
    required this.documentIcon,
    required this.errorColor,
    required this.inputBackgroundColor,
    required this.inputBorderRadius,
    required this.inputTextColor,
    required this.messageBorderRadius,
    required this.primaryColor,
    required this.primaryTextColor,
    required this.readIcon,
    required this.secondaryColor,
    required this.secondaryTextColor,
    required this.sendButtonIcon,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle2Color,
  });

  /// Icon for select attachment button
  final String? attachmentButtonIcon;

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

  /// Icon for message's `delivered` status
  final String? deliveredIcon;

  /// Icon inside file message
  final String? documentIcon;

  /// Color to indicate something bad happened (usually - shades of red)
  final Color errorColor;

  /// Color of the bottom bar where text field is
  final Color inputBackgroundColor;

  /// Top border radius of the bottom bar where text field is
  final BorderRadius inputBorderRadius;

  /// Color of the text field's text and attachment/send buttons
  final Color inputTextColor;

  /// Border radius of message container
  final double messageBorderRadius;

  /// Primary color of the chat used as a background of sent messages
  final Color primaryColor;

  /// Color of the text on a [primaryColor]
  final Color primaryTextColor;

  /// Icon for message's `read` status
  final String? readIcon;

  /// Secondary color, used as a background of received messages
  final Color secondaryColor;

  /// Color of the text on a [secondaryColor]
  final Color secondaryTextColor;

  /// Icon for send button
  final String? sendButtonIcon;

  /// Largest text style, used for displaying title of a link preview
  final TextStyle subtitle1;

  /// Subtitle, used for date dividers in the chat
  final TextStyle subtitle2;

  /// Color of subtitle, used for date dividers in the chat
  final Color subtitle2Color;
}

/// Default chat theme which extends [ChatTheme]
@immutable
class DefaultChatTheme extends ChatTheme {
  /// Creates a default chat theme. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatTheme]
  const DefaultChatTheme({
    String? attachmentButtonIcon,
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
    String? deliveredIcon,
    String? documentIcon,
    Color errorColor = const Color(0xffff6767),
    Color inputBackgroundColor = const Color(0xff1d1d21),
    BorderRadius inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    Color inputTextColor = const Color(0xffffffff),
    double messageBorderRadius = 20.0,
    Color primaryColor = const Color(0xff6f61e8),
    Color primaryTextColor = const Color(0xffffffff),
    String? readIcon,
    Color secondaryColor = const Color(0xfff7f7f8),
    Color secondaryTextColor = const Color(0xff1d1d21),
    String? sendButtonIcon,
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
    Color subtitle2Color = const Color(0xff1d1d21),
  }) : super(
          attachmentButtonIcon: attachmentButtonIcon,
          backgroundColor: backgroundColor,
          body1: body1,
          body2: body2,
          caption: caption,
          captionColor: captionColor,
          deliveredIcon: deliveredIcon,
          documentIcon: documentIcon,
          errorColor: errorColor,
          inputBackgroundColor: inputBackgroundColor,
          inputBorderRadius: inputBorderRadius,
          inputTextColor: inputTextColor,
          messageBorderRadius: messageBorderRadius,
          primaryColor: primaryColor,
          primaryTextColor: primaryTextColor,
          readIcon: readIcon,
          secondaryColor: secondaryColor,
          secondaryTextColor: secondaryTextColor,
          sendButtonIcon: sendButtonIcon,
          subtitle1: subtitle1,
          subtitle2: subtitle2,
          subtitle2Color: subtitle2Color,
        );
}

/// Dark chat theme which extends [ChatTheme]
@immutable
class DarkChatTheme extends ChatTheme {
  /// Creates a dark chat theme. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatTheme]
  const DarkChatTheme({
    String? attachmentButtonIcon,
    Color backgroundColor = const Color(0xff1f1c38),
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
    String? deliveredIcon,
    String? documentIcon,
    Color errorColor = const Color(0xffff6767),
    Color inputBackgroundColor = const Color(0xff2b2250),
    BorderRadius inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    Color inputTextColor = const Color(0xffffffff),
    double messageBorderRadius = 20.0,
    Color primaryColor = const Color(0xff6f61e8),
    Color primaryTextColor = const Color(0xffffffff),
    String? readIcon,
    Color secondaryColor = const Color(0xff2b2250),
    Color secondaryTextColor = const Color(0xffffffff),
    String? sendButtonIcon,
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
    Color subtitle2Color = const Color(0xffffffff),
  }) : super(
          attachmentButtonIcon: attachmentButtonIcon,
          backgroundColor: backgroundColor,
          body1: body1,
          body2: body2,
          caption: caption,
          captionColor: captionColor,
          deliveredIcon: deliveredIcon,
          documentIcon: documentIcon,
          errorColor: errorColor,
          inputBackgroundColor: inputBackgroundColor,
          inputBorderRadius: inputBorderRadius,
          inputTextColor: inputTextColor,
          messageBorderRadius: messageBorderRadius,
          primaryColor: primaryColor,
          primaryTextColor: primaryTextColor,
          readIcon: readIcon,
          secondaryColor: secondaryColor,
          secondaryTextColor: secondaryTextColor,
          sendButtonIcon: sendButtonIcon,
          subtitle1: subtitle1,
          subtitle2: subtitle2,
          subtitle2Color: subtitle2Color,
        );
}
