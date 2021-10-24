import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, regexLink;
import '../models/emoji_enlargement_behavior.dart';
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// A class that represents text message widget with optional link preview
class TextMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.TextMessage] class
  const TextMessage({
    Key? key,
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.message,
    this.onPreviewDataFetched,
    required this.usePreviewData,
    required this.showName,
  }) : super(key: key);

  /// See [Message.emojiEnlargementBehavior]
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// See [Message.hideBackgroundOnEmojiMessages]
  final bool hideBackgroundOnEmojiMessages;

  /// [types.TextMessage]
  final types.TextMessage message;

  /// See [LinkPreview.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Enables link (URL) preview
  final bool usePreviewData;

  void _onPreviewDataFetched(types.PreviewData previewData) {
    if (message.previewData == null) {
      onPreviewDataFetched?.call(message, previewData);
    }
  }

  Widget _linkPreview(
    types.User user,
    double width,
    BuildContext context,
  ) {
    final bodyTextStyle = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.sentMessageBodyTextStyle
        : InheritedChatTheme.of(context).theme.receivedMessageBodyTextStyle;
    final linkDescriptionTextStyle = user.id == message.author.id
        ? InheritedChatTheme.of(context)
            .theme
            .sentMessageLinkDescriptionTextStyle
        : InheritedChatTheme.of(context)
            .theme
            .receivedMessageLinkDescriptionTextStyle;
    final linkTitleTextStyle = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.sentMessageLinkTitleTextStyle
        : InheritedChatTheme.of(context)
            .theme
            .receivedMessageLinkTitleTextStyle;

    final color = getUserAvatarNameColor(message.author,
        InheritedChatTheme.of(context).theme.userAvatarNameColors);
    final name = getUserName(message.author);

    return LinkPreview(
      enableAnimation: true,
      header: showName ? name : null,
      headerStyle: InheritedChatTheme.of(context)
          .theme
          .userNameTextStyle
          .copyWith(color: color),
      linkStyle: bodyTextStyle,
      metadataTextStyle: linkDescriptionTextStyle,
      metadataTitleStyle: linkTitleTextStyle,
      onPreviewDataFetched: _onPreviewDataFetched,
      padding: EdgeInsets.symmetric(
        horizontal:
            InheritedChatTheme.of(context).theme.messageInsetsHorizontal,
        vertical: InheritedChatTheme.of(context).theme.messageInsetsVertical,
      ),
      previewData: message.previewData,
      text: message.text,
      textStyle: bodyTextStyle,
      width: width,
    );
  }

  Widget _textWidgetBuilder(
    types.User user,
    BuildContext context,
    bool enlargeEmojis,
  ) {
    final theme = InheritedChatTheme.of(context).theme;
    final color =
        getUserAvatarNameColor(message.author, theme.userAvatarNameColors);
    final name = getUserName(message.author);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.userNameTextStyle.copyWith(color: color),
            ),
          ),
        SelectableText(
          message.text,
          style: user.id == message.author.id
              ? enlargeEmojis
                  ? theme.sentEmojiMessageTextStyle
                  : theme.sentMessageBodyTextStyle
              : enlargeEmojis
                  ? theme.receivedEmojiMessageTextStyle
                  : theme.receivedMessageBodyTextStyle,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            isConsistsOfEmojis(emojiEnlargementBehavior, message);
    final _theme = InheritedChatTheme.of(context).theme;
    final _user = InheritedUser.of(context).user;
    final _width = MediaQuery.of(context).size.width;

    if (usePreviewData && onPreviewDataFetched != null) {
      final urlRegexp = RegExp(regexLink, caseSensitive: false);
      final matches = urlRegexp.allMatches(message.text);

      if (matches.isNotEmpty) {
        return _linkPreview(_user, _width, context);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _enlargeEmojis && hideBackgroundOnEmojiMessages
            ? 0.0
            : _theme.messageInsetsHorizontal,
        vertical: _theme.messageInsetsVertical,
      ),
      child: _textWidgetBuilder(_user, context, _enlargeEmojis),
    );
  }
}
