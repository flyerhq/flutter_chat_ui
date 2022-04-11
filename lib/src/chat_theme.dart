import 'package:flutter/material.dart';

// For internal usage only. Use values from theme itself.

/// See [ChatTheme.userAvatarNameColors]
const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

/// Dark
const dark = Color(0xff1f1c38);

/// Error
const error = Color(0xffff6767);

/// N0
const neutral0 = Color(0xff1d1c21);

/// N2
const neutral2 = Color(0xff9e9cab);

/// N7
const neutral7 = Color(0xffffffff);

/// N7 with opacity
const neutral7WithOpacity = Color(0x80ffffff);

/// Primary
const primary = Color(0xff6f61e8);

/// Secondary
const secondary = Color(0xfff5f5f7);

/// Secondary dark
const secondaryDark = Color(0xff2b2250);

/// Base chat theme containing all required properties to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class ChatTheme {
  /// Creates a new chat theme based on provided colors and text styles.
  const ChatTheme({
    required this.attachmentButtonIcon,
    required this.attachmentButtonMargin,
    required this.backgroundColor,
    required this.dateDividerMargin,
    required this.dateDividerTextStyle,
    required this.deliveredIcon,
    required this.documentIcon,
    required this.emptyChatPlaceholderTextStyle,
    required this.errorColor,
    required this.errorIcon,
    required this.inputBackgroundColor,
    required this.inputBorderRadius,
    this.inputContainerDecoration,
    required this.inputMargin,
    required this.inputPadding,
    required this.inputTextColor,
    this.inputTextCursorColor,
    required this.inputTextDecoration,
    required this.inputTextStyle,
    required this.messageBorderRadius,
    required this.messageInsetsHorizontal,
    required this.messageInsetsVertical,
    required this.primaryColor,
    required this.receivedEmojiMessageTextStyle,
    this.receivedMessageBodyBoldTextStyle,
    this.receivedMessageBodyCodeTextStyle,
    this.receivedMessageBodyLinkTextStyle,
    required this.receivedMessageBodyTextStyle,
    required this.receivedMessageCaptionTextStyle,
    required this.receivedMessageDocumentIconColor,
    required this.receivedMessageLinkDescriptionTextStyle,
    required this.receivedMessageLinkTitleTextStyle,
    required this.secondaryColor,
    required this.seenIcon,
    required this.sendButtonIcon,
    required this.sendButtonMargin,
    required this.sendingIcon,
    required this.sentEmojiMessageTextStyle,
    this.sentMessageBodyBoldTextStyle,
    this.sentMessageBodyCodeTextStyle,
    this.sentMessageBodyLinkTextStyle,
    required this.sentMessageBodyTextStyle,
    required this.sentMessageCaptionTextStyle,
    required this.sentMessageDocumentIconColor,
    required this.sentMessageLinkDescriptionTextStyle,
    required this.sentMessageLinkTitleTextStyle,
    required this.statusIconPadding,
    required this.userAvatarImageBackgroundColor,
    required this.userAvatarNameColors,
    required this.userAvatarTextStyle,
    required this.userNameTextStyle,
  });

  /// Icon for select attachment button
  final Widget? attachmentButtonIcon;

  /// Margin of attachment button
  final EdgeInsets? attachmentButtonMargin;

  /// Used as a background color of a chat widget
  final Color backgroundColor;

  /// Margin around date dividers
  final EdgeInsets dateDividerMargin;

  /// Text style of the date dividers
  final TextStyle dateDividerTextStyle;

  /// Icon for message's `delivered` status. For the best look use size of 16.
  final Widget? deliveredIcon;

  /// Icon inside file message
  final Widget? documentIcon;

  /// Text style of the empty chat placeholder
  final TextStyle emptyChatPlaceholderTextStyle;

  /// Color to indicate something bad happened (usually - shades of red)
  final Color errorColor;

  /// Icon for message's `error` status. For the best look use size of 16.
  final Widget? errorIcon;

  /// Color of the bottom bar where text field is
  final Color inputBackgroundColor;

  /// Top border radius of the bottom bar where text field is
  final BorderRadius inputBorderRadius;

  /// Decoration of the container wrapping the text field
  final Decoration? inputContainerDecoration;

  /// Outer insets of the bottom bar where text field is
  final EdgeInsets inputMargin;

  /// Inner insets of the bottom bar where text field is
  final EdgeInsets inputPadding;

  /// Color of the text field's text and attachment/send buttons
  final Color inputTextColor;

  /// Color of the text field's cursor
  final Color? inputTextCursorColor;

  /// Decoration of the input text field
  final InputDecoration inputTextDecoration;

  /// Text style of the message input. To change the color use [inputTextColor].
  final TextStyle inputTextStyle;

  /// Border radius of message container
  final double messageBorderRadius;

  /// Horizontal message bubble insets
  final double messageInsetsHorizontal;

  /// Vertical message bubble insets
  final double messageInsetsVertical;

  /// Primary color of the chat used as a background of sent messages
  /// and statuses
  final Color primaryColor;

  /// Text style used for displaying emojis on text messages
  final TextStyle receivedEmojiMessageTextStyle;

  /// Body text style used for displaying bold text on received text messages.
  /// Default to a bold version of [receivedMessageBodyTextStyle].
  final TextStyle? receivedMessageBodyBoldTextStyle;

  /// Body text style used for displaying code text on received text messages.
  /// Defaults to a mono version of [receivedMessageBodyTextStyle].
  final TextStyle? receivedMessageBodyCodeTextStyle;

  /// Text style used for displaying link text on received text messages.
  /// Defaults to [receivedMessageBodyTextStyle]
  final TextStyle? receivedMessageBodyLinkTextStyle;

  /// Body text style used for displaying text on different types
  /// of received messages
  final TextStyle receivedMessageBodyTextStyle;

  /// Caption text style used for displaying secondary info (e.g. file size)
  /// on different types of received messages
  final TextStyle receivedMessageCaptionTextStyle;

  /// Color of the document icon on received messages. Has no effect when
  /// [documentIcon] is used.
  final Color receivedMessageDocumentIconColor;

  /// Text style used for displaying link description on received messages
  final TextStyle receivedMessageLinkDescriptionTextStyle;

  /// Text style used for displaying link title on received messages
  final TextStyle receivedMessageLinkTitleTextStyle;

  /// Secondary color, used as a background of received messages
  final Color secondaryColor;

  /// Icon for message's `seen` status. For the best look use size of 16.
  final Widget? seenIcon;

  /// Icon for send button
  final Widget? sendButtonIcon;

  /// Margin of send button
  final EdgeInsets? sendButtonMargin;

  /// Icon for message's `sending` status. For the best look use size of 10.
  final Widget? sendingIcon;

  /// Text style used for displaying emojis on text messages
  final TextStyle sentEmojiMessageTextStyle;

  /// Body text style used for displaying bold text on sent text messages.
  /// Defaults to a bold version of [sentMessageBodyTextStyle].
  final TextStyle? sentMessageBodyBoldTextStyle;

  /// Body text style used for displaying code text on sent text messages.
  /// Defaults to a mono version of [sentMessageBodyTextStyle].
  final TextStyle? sentMessageBodyCodeTextStyle;

  /// Text style used for displaying link text on sent text messages.
  /// Defaults to [sentMessageBodyTextStyle]
  final TextStyle? sentMessageBodyLinkTextStyle;

  /// Body text style used for displaying text on different types
  /// of sent messages
  final TextStyle sentMessageBodyTextStyle;

  /// Caption text style used for displaying secondary info (e.g. file size)
  /// on different types of sent messages
  final TextStyle sentMessageCaptionTextStyle;

  /// Color of the document icon on sent messages. Has no effect when
  /// [documentIcon] is used.
  final Color sentMessageDocumentIconColor;

  /// Text style used for displaying link description on sent messages
  final TextStyle sentMessageLinkDescriptionTextStyle;

  /// Text style used for displaying link title on sent messages
  final TextStyle sentMessageLinkTitleTextStyle;

  /// Padding around status icons
  final EdgeInsets statusIconPadding;

  /// Color used as a background for user avatar if an image is provided.
  /// Visible if the image has some transparent parts.
  final Color userAvatarImageBackgroundColor;

  /// Colors used as backgrounds for user avatars with no image and so,
  /// corresponding user names.
  /// Calculated based on a user ID, so unique across the whole app.
  final List<Color> userAvatarNameColors;

  /// Text style used for displaying initials on user avatar if no
  /// image is provided
  final TextStyle userAvatarTextStyle;

  /// User names text style. Color will be overwritten with [userAvatarNameColors].
  final TextStyle userNameTextStyle;
}

/// Default chat theme which extends [ChatTheme]
@immutable
class DefaultChatTheme extends ChatTheme {
  /// Creates a default chat theme. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatTheme]
  const DefaultChatTheme({
    Widget? attachmentButtonIcon,
    EdgeInsets? attachmentButtonMargin,
    Color backgroundColor = neutral7,
    EdgeInsets dateDividerMargin = const EdgeInsets.only(
      bottom: 32,
      top: 16,
    ),
    TextStyle dateDividerTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    Widget? deliveredIcon,
    Widget? documentIcon,
    TextStyle emptyChatPlaceholderTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    Color errorColor = error,
    Widget? errorIcon,
    Color inputBackgroundColor = neutral0,
    BorderRadius inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    Decoration? inputContainerDecoration,
    EdgeInsets inputMargin = EdgeInsets.zero,
    EdgeInsets inputPadding = const EdgeInsets.fromLTRB(24, 20, 24, 20),
    Color inputTextColor = neutral7,
    Color? inputTextCursorColor,
    InputDecoration inputTextDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    TextStyle inputTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    double messageBorderRadius = 20,
    double messageInsetsHorizontal = 20,
    double messageInsetsVertical = 16,
    Color primaryColor = primary,
    TextStyle receivedEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    TextStyle? receivedMessageBodyBoldTextStyle,
    TextStyle? receivedMessageBodyCodeTextStyle,
    TextStyle? receivedMessageBodyLinkTextStyle,
    TextStyle receivedMessageBodyTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle receivedMessageCaptionTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color receivedMessageDocumentIconColor = primary,
    TextStyle receivedMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle receivedMessageLinkTitleTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    Color secondaryColor = secondary,
    Widget? seenIcon,
    Widget? sendButtonIcon,
    EdgeInsets? sendButtonMargin,
    Widget? sendingIcon,
    TextStyle sentEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    TextStyle? sentMessageBodyBoldTextStyle,
    TextStyle? sentMessageBodyCodeTextStyle,
    TextStyle? sentMessageBodyLinkTextStyle,
    TextStyle sentMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle sentMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color sentMessageDocumentIconColor = neutral7,
    TextStyle sentMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle sentMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    EdgeInsets statusIconPadding = const EdgeInsets.symmetric(horizontal: 4),
    Color userAvatarImageBackgroundColor = Colors.transparent,
    List<Color> userAvatarNameColors = colors,
    TextStyle userAvatarTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    TextStyle userNameTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  }) : super(
          attachmentButtonIcon: attachmentButtonIcon,
          attachmentButtonMargin: attachmentButtonMargin,
          backgroundColor: backgroundColor,
          dateDividerMargin: dateDividerMargin,
          dateDividerTextStyle: dateDividerTextStyle,
          deliveredIcon: deliveredIcon,
          documentIcon: documentIcon,
          emptyChatPlaceholderTextStyle: emptyChatPlaceholderTextStyle,
          errorColor: errorColor,
          errorIcon: errorIcon,
          inputBackgroundColor: inputBackgroundColor,
          inputBorderRadius: inputBorderRadius,
          inputContainerDecoration: inputContainerDecoration,
          inputMargin: inputMargin,
          inputPadding: inputPadding,
          inputTextColor: inputTextColor,
          inputTextCursorColor: inputTextCursorColor,
          inputTextDecoration: inputTextDecoration,
          inputTextStyle: inputTextStyle,
          messageBorderRadius: messageBorderRadius,
          messageInsetsHorizontal: messageInsetsHorizontal,
          messageInsetsVertical: messageInsetsVertical,
          primaryColor: primaryColor,
          receivedEmojiMessageTextStyle: receivedEmojiMessageTextStyle,
          receivedMessageBodyBoldTextStyle: receivedMessageBodyBoldTextStyle,
          receivedMessageBodyCodeTextStyle: receivedMessageBodyCodeTextStyle,
          receivedMessageBodyLinkTextStyle: receivedMessageBodyLinkTextStyle,
          receivedMessageBodyTextStyle: receivedMessageBodyTextStyle,
          receivedMessageCaptionTextStyle: receivedMessageCaptionTextStyle,
          receivedMessageDocumentIconColor: receivedMessageDocumentIconColor,
          receivedMessageLinkDescriptionTextStyle:
              receivedMessageLinkDescriptionTextStyle,
          receivedMessageLinkTitleTextStyle: receivedMessageLinkTitleTextStyle,
          secondaryColor: secondaryColor,
          seenIcon: seenIcon,
          sendButtonIcon: sendButtonIcon,
          sendButtonMargin: sendButtonMargin,
          sendingIcon: sendingIcon,
          sentEmojiMessageTextStyle: sentEmojiMessageTextStyle,
          sentMessageBodyBoldTextStyle: sentMessageBodyBoldTextStyle,
          sentMessageBodyCodeTextStyle: sentMessageBodyCodeTextStyle,
          sentMessageBodyLinkTextStyle: sentMessageBodyLinkTextStyle,
          sentMessageBodyTextStyle: sentMessageBodyTextStyle,
          sentMessageCaptionTextStyle: sentMessageCaptionTextStyle,
          sentMessageDocumentIconColor: sentMessageDocumentIconColor,
          sentMessageLinkDescriptionTextStyle:
              sentMessageLinkDescriptionTextStyle,
          sentMessageLinkTitleTextStyle: sentMessageLinkTitleTextStyle,
          statusIconPadding: statusIconPadding,
          userAvatarImageBackgroundColor: userAvatarImageBackgroundColor,
          userAvatarNameColors: userAvatarNameColors,
          userAvatarTextStyle: userAvatarTextStyle,
          userNameTextStyle: userNameTextStyle,
        );
}

/// Dark chat theme which extends [ChatTheme]
@immutable
class DarkChatTheme extends ChatTheme {
  /// Creates a dark chat theme. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatTheme]
  const DarkChatTheme({
    Widget? attachmentButtonIcon,
    EdgeInsets? attachmentButtonMargin,
    Color backgroundColor = dark,
    EdgeInsets dateDividerMargin = const EdgeInsets.only(
      bottom: 32,
      top: 16,
    ),
    TextStyle dateDividerTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    Widget? deliveredIcon,
    Widget? documentIcon,
    TextStyle emptyChatPlaceholderTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    Color errorColor = error,
    Widget? errorIcon,
    Color inputBackgroundColor = secondaryDark,
    BorderRadius inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    Decoration? inputContainerDecoration,
    EdgeInsets inputMargin = EdgeInsets.zero,
    EdgeInsets inputPadding = const EdgeInsets.fromLTRB(24, 20, 24, 20),
    Color inputTextColor = neutral7,
    Color? inputTextCursorColor,
    InputDecoration inputTextDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    TextStyle inputTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    double messageBorderRadius = 20,
    double messageInsetsHorizontal = 20,
    double messageInsetsVertical = 16,
    Color primaryColor = primary,
    TextStyle receivedEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    TextStyle? receivedMessageBodyBoldTextStyle,
    TextStyle? receivedMessageBodyCodeTextStyle,
    TextStyle? receivedMessageBodyLinkTextStyle,
    TextStyle receivedMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle receivedMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color receivedMessageDocumentIconColor = primary,
    TextStyle receivedMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle receivedMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    Color secondaryColor = secondaryDark,
    Widget? seenIcon,
    Widget? sendButtonIcon,
    EdgeInsets? sendButtonMargin,
    Widget? sendingIcon,
    TextStyle sentEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    TextStyle? sentMessageBodyBoldTextStyle,
    TextStyle? sentMessageBodyCodeTextStyle,
    TextStyle? sentMessageBodyLinkTextStyle,
    TextStyle sentMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle sentMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color sentMessageDocumentIconColor = neutral7,
    TextStyle sentMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle sentMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    EdgeInsets statusIconPadding = const EdgeInsets.symmetric(horizontal: 4),
    Color userAvatarImageBackgroundColor = Colors.transparent,
    List<Color> userAvatarNameColors = colors,
    TextStyle userAvatarTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    TextStyle userNameTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  }) : super(
          attachmentButtonIcon: attachmentButtonIcon,
          attachmentButtonMargin: attachmentButtonMargin,
          backgroundColor: backgroundColor,
          dateDividerMargin: dateDividerMargin,
          dateDividerTextStyle: dateDividerTextStyle,
          deliveredIcon: deliveredIcon,
          documentIcon: documentIcon,
          emptyChatPlaceholderTextStyle: emptyChatPlaceholderTextStyle,
          errorColor: errorColor,
          errorIcon: errorIcon,
          inputBackgroundColor: inputBackgroundColor,
          inputBorderRadius: inputBorderRadius,
          inputContainerDecoration: inputContainerDecoration,
          inputMargin: inputMargin,
          inputPadding: inputPadding,
          inputTextColor: inputTextColor,
          inputTextCursorColor: inputTextCursorColor,
          inputTextDecoration: inputTextDecoration,
          inputTextStyle: inputTextStyle,
          messageBorderRadius: messageBorderRadius,
          messageInsetsHorizontal: messageInsetsHorizontal,
          messageInsetsVertical: messageInsetsVertical,
          primaryColor: primaryColor,
          receivedEmojiMessageTextStyle: receivedEmojiMessageTextStyle,
          receivedMessageBodyBoldTextStyle: receivedMessageBodyBoldTextStyle,
          receivedMessageBodyCodeTextStyle: receivedMessageBodyCodeTextStyle,
          receivedMessageBodyLinkTextStyle: receivedMessageBodyLinkTextStyle,
          receivedMessageBodyTextStyle: receivedMessageBodyTextStyle,
          receivedMessageCaptionTextStyle: receivedMessageCaptionTextStyle,
          receivedMessageDocumentIconColor: receivedMessageDocumentIconColor,
          receivedMessageLinkDescriptionTextStyle:
              receivedMessageLinkDescriptionTextStyle,
          receivedMessageLinkTitleTextStyle: receivedMessageLinkTitleTextStyle,
          secondaryColor: secondaryColor,
          seenIcon: seenIcon,
          sendButtonIcon: sendButtonIcon,
          sendButtonMargin: sendButtonMargin,
          sendingIcon: sendingIcon,
          sentEmojiMessageTextStyle: sentEmojiMessageTextStyle,
          sentMessageBodyBoldTextStyle: sentMessageBodyBoldTextStyle,
          sentMessageBodyCodeTextStyle: sentMessageBodyCodeTextStyle,
          sentMessageBodyLinkTextStyle: sentMessageBodyLinkTextStyle,
          sentMessageBodyTextStyle: sentMessageBodyTextStyle,
          sentMessageCaptionTextStyle: sentMessageCaptionTextStyle,
          sentMessageDocumentIconColor: sentMessageDocumentIconColor,
          sentMessageLinkDescriptionTextStyle:
              sentMessageLinkDescriptionTextStyle,
          sentMessageLinkTitleTextStyle: sentMessageLinkTitleTextStyle,
          statusIconPadding: statusIconPadding,
          userAvatarImageBackgroundColor: userAvatarImageBackgroundColor,
          userAvatarNameColors: userAvatarNameColors,
          userAvatarTextStyle: userAvatarTextStyle,
          userNameTextStyle: userNameTextStyle,
        );
}
