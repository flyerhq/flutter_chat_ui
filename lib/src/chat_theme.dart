import 'package:flutter/material.dart';

@immutable
abstract class ChatTheme {
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

  final Color backgroundColor;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;
  final Color captionColor;
  final Color errorColor;
  final Color inputBackgroundColor;
  final Color inputTextColor;
  final Color primaryColor;
  final Color primaryTextColor;
  final Color secondaryColor;
  final Color secondaryTextColor;
  final TextStyle subtitle1;
  final TextStyle subtitle2;
}

@immutable
class DefaultChatTheme extends ChatTheme {
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
