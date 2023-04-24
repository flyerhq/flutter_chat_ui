import 'package:flutter/material.dart';

import 'widgets/message/system_message.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/unread_header.dart';

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

/// Dark.
const dark = Color(0xff1f1c38);

/// Error.
const error = Color(0xffff6767);

/// N0.
const neutral0 = Color(0xff1d1c21);

/// N1.
const neutral1 = Color(0xff615e6e);

/// N2.
const neutral2 = Color(0xff9e9cab);

/// N7.
const neutral7 = Color(0xffffffff);

/// N7 with opacity.
const neutral7WithOpacity = Color(0x80ffffff);

/// Primary.
const primary = Color(0xff6f61e8);

/// Secondary.
const secondary = Color(0xfff5f5f7);

/// Secondary dark.
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
    required this.systemMessageTheme,
    required this.typingIndicatorTheme,
    required this.unreadHeaderTheme,
    required this.userAvatarImageBackgroundColor,
    required this.userAvatarNameColors,
    required this.userAvatarTextStyle,
    required this.userNameTextStyle,
  });

  /// Icon for select attachment button.
  final Widget? attachmentButtonIcon;

  /// Margin of attachment button.
  final EdgeInsets? attachmentButtonMargin;

  /// Used as a background color of a chat widget.
  final Color backgroundColor;

  /// Margin around date dividers.
  final EdgeInsets dateDividerMargin;

  /// Text style of the date dividers.
  final TextStyle dateDividerTextStyle;

  /// Icon for message's `delivered` status. For the best look use size of 16.
  final Widget? deliveredIcon;

  /// Icon inside file message.
  final Widget? documentIcon;

  /// Text style of the empty chat placeholder.
  final TextStyle emptyChatPlaceholderTextStyle;

  /// Color to indicate something bad happened (usually - shades of red).
  final Color errorColor;

  /// Icon for message's `error` status. For the best look use size of 16.
  final Widget? errorIcon;

  /// Color of the bottom bar where text field is.
  final Color inputBackgroundColor;

  /// Top border radius of the bottom bar where text field is.
  final BorderRadius inputBorderRadius;

  /// Decoration of the container wrapping the text field.
  final Decoration? inputContainerDecoration;

  /// Outer insets of the bottom bar where text field is.
  final EdgeInsets inputMargin;

  /// Inner insets of the bottom bar where text field is.
  final EdgeInsets inputPadding;

  /// Color of the text field's text and attachment/send buttons.
  final Color inputTextColor;

  /// Color of the text field's cursor.
  final Color? inputTextCursorColor;

  /// Decoration of the input text field.
  final InputDecoration inputTextDecoration;

  /// Text style of the message input. To change the color use [inputTextColor].
  final TextStyle inputTextStyle;

  /// Border radius of message container.
  final double messageBorderRadius;

  /// Horizontal message bubble insets.
  final double messageInsetsHorizontal;

  /// Vertical message bubble insets.
  final double messageInsetsVertical;

  /// Primary color of the chat used as a background of sent messages
  /// and statuses
  final Color primaryColor;

  /// Text style used for displaying emojis on text messages.
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

  /// Text style used for displaying link description on received messages.
  final TextStyle receivedMessageLinkDescriptionTextStyle;

  /// Text style used for displaying link title on received messages.
  final TextStyle receivedMessageLinkTitleTextStyle;

  /// Secondary color, used as a background of received messages.
  final Color secondaryColor;

  /// Icon for message's `seen` status. For the best look use size of 16.
  final Widget? seenIcon;

  /// Icon for send button.
  final Widget? sendButtonIcon;

  /// Margin of send button.
  final EdgeInsets? sendButtonMargin;

  /// Icon for message's `sending` status. For the best look use size of 10.
  final Widget? sendingIcon;

  /// Text style used for displaying emojis on text messages.
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

  /// Text style used for displaying link description on sent messages.
  final TextStyle sentMessageLinkDescriptionTextStyle;

  /// Text style used for displaying link title on sent messages.
  final TextStyle sentMessageLinkTitleTextStyle;

  /// Padding around status icons.
  final EdgeInsets statusIconPadding;

  /// Theme for the system message. Will not have an effect if a custom builder
  /// is provided.
  final SystemMessageTheme systemMessageTheme;

  /// Theme for typing indicator. See [TypingIndicator].
  final TypingIndicatorTheme typingIndicatorTheme;

  /// Theme for the unread header.
  final UnreadHeaderTheme unreadHeaderTheme;

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

/// Default chat theme which extends [ChatTheme].
@immutable
class DefaultChatTheme extends ChatTheme {
  /// Creates a default chat theme. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatTheme]
  const DefaultChatTheme({
    super.attachmentButtonIcon,
    super.attachmentButtonMargin,
    super.backgroundColor = neutral7,
    super.dateDividerMargin = const EdgeInsets.only(
      bottom: 32,
      top: 16,
    ),
    super.dateDividerTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    super.deliveredIcon,
    super.documentIcon,
    super.emptyChatPlaceholderTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.errorColor = error,
    super.errorIcon,
    super.inputBackgroundColor = neutral0,
    super.inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    super.inputContainerDecoration,
    super.inputMargin = EdgeInsets.zero,
    super.inputPadding = const EdgeInsets.fromLTRB(24, 20, 24, 20),
    super.inputTextColor = neutral7,
    super.inputTextCursorColor,
    super.inputTextDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    super.inputTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.messageBorderRadius = 20,
    super.messageInsetsHorizontal = 20,
    super.messageInsetsVertical = 16,
    super.primaryColor = primary,
    super.receivedEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    super.receivedMessageBodyBoldTextStyle,
    super.receivedMessageBodyCodeTextStyle,
    super.receivedMessageBodyLinkTextStyle,
    super.receivedMessageBodyTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.receivedMessageCaptionTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    super.receivedMessageDocumentIconColor = primary,
    super.receivedMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    super.receivedMessageLinkTitleTextStyle = const TextStyle(
      color: neutral0,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    super.secondaryColor = secondary,
    super.seenIcon,
    super.sendButtonIcon,
    super.sendButtonMargin,
    super.sendingIcon,
    super.sentEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    super.sentMessageBodyBoldTextStyle,
    super.sentMessageBodyCodeTextStyle,
    super.sentMessageBodyLinkTextStyle,
    super.sentMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.sentMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    super.sentMessageDocumentIconColor = neutral7,
    super.sentMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    super.sentMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    super.statusIconPadding = const EdgeInsets.symmetric(horizontal: 4),
    super.systemMessageTheme = const SystemMessageTheme(
      margin: EdgeInsets.only(
        bottom: 24,
        top: 8,
        left: 8,
        right: 8,
      ),
      textStyle: TextStyle(
        color: neutral2,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        height: 1.333,
      ),
    ),
    super.typingIndicatorTheme = const TypingIndicatorTheme(
      animatedCirclesColor: neutral1,
      animatedCircleSize: 5.0,
      bubbleBorder: BorderRadius.all(Radius.circular(27.0)),
      bubbleColor: neutral7,
      countAvatarColor: primary,
      countTextColor: secondary,
      multipleUserTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: neutral2,
      ),
    ),
    super.unreadHeaderTheme = const UnreadHeaderTheme(
      color: secondary,
      textStyle: TextStyle(
        color: neutral2,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.333,
      ),
    ),
    super.userAvatarImageBackgroundColor = Colors.transparent,
    super.userAvatarNameColors = colors,
    super.userAvatarTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    super.userNameTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  });
}

/// Dark chat theme which extends [ChatTheme].
@immutable
class DarkChatTheme extends ChatTheme {
  /// Creates a dark chat theme. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatTheme]
  const DarkChatTheme({
    super.attachmentButtonIcon,
    super.attachmentButtonMargin,
    super.backgroundColor = dark,
    super.dateDividerMargin = const EdgeInsets.only(
      bottom: 32,
      top: 16,
    ),
    super.dateDividerTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    super.deliveredIcon,
    super.documentIcon,
    super.emptyChatPlaceholderTextStyle = const TextStyle(
      color: neutral2,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.errorColor = error,
    super.errorIcon,
    super.inputBackgroundColor = secondaryDark,
    super.inputBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    super.inputContainerDecoration,
    super.inputMargin = EdgeInsets.zero,
    super.inputPadding = const EdgeInsets.fromLTRB(24, 20, 24, 20),
    super.inputTextColor = neutral7,
    super.inputTextCursorColor,
    super.inputTextDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    super.inputTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.messageBorderRadius = 20,
    super.messageInsetsHorizontal = 20,
    super.messageInsetsVertical = 16,
    super.primaryColor = primary,
    super.receivedEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    super.receivedMessageBodyBoldTextStyle,
    super.receivedMessageBodyCodeTextStyle,
    super.receivedMessageBodyLinkTextStyle,
    super.receivedMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.receivedMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    super.receivedMessageDocumentIconColor = primary,
    super.receivedMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    super.receivedMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    super.secondaryColor = secondaryDark,
    super.seenIcon,
    super.sendButtonIcon,
    super.sendButtonMargin,
    super.sendingIcon,
    super.sentEmojiMessageTextStyle = const TextStyle(fontSize: 40),
    super.sentMessageBodyBoldTextStyle,
    super.sentMessageBodyCodeTextStyle,
    super.sentMessageBodyLinkTextStyle,
    super.sentMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    super.sentMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    super.sentMessageDocumentIconColor = neutral7,
    super.sentMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    super.sentMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    super.statusIconPadding = const EdgeInsets.symmetric(horizontal: 4),
    super.systemMessageTheme = const SystemMessageTheme(
      margin: EdgeInsets.only(
        bottom: 24,
        top: 8,
        left: 8,
        right: 8,
      ),
      textStyle: TextStyle(
        color: neutral7,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        height: 1.333,
      ),
    ),
    super.typingIndicatorTheme = const TypingIndicatorTheme(
      animatedCirclesColor: neutral7,
      animatedCircleSize: 5.0,
      bubbleBorder: BorderRadius.all(Radius.circular(27.0)),
      bubbleColor: dark,
      countAvatarColor: primary,
      countTextColor: secondary,
      multipleUserTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: neutral2,
      ),
    ),
    super.unreadHeaderTheme = const UnreadHeaderTheme(
      color: secondaryDark,
      textStyle: TextStyle(
        color: neutral7WithOpacity,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.333,
      ),
    ),
    super.userAvatarImageBackgroundColor = Colors.transparent,
    super.userAvatarNameColors = colors,
    super.userAvatarTextStyle = const TextStyle(
      color: neutral7,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    super.userNameTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  });
}
