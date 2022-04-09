import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, regexEmail, regexLink;
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return LinkPreview(
      enableAnimation: true,
      textWidget: _textWidgetBuilder(user, context, false),
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
    final bodyTextStyle = user.id == message.author.id
        ? enlargeEmojis
            ? theme.sentEmojiMessageTextStyle
            : theme.sentMessageBodyTextStyle
        : enlargeEmojis
            ? theme.receivedEmojiMessageTextStyle
            : theme.receivedMessageBodyTextStyle;
    final boldTextStyle = user.id == message.author.id
        ? theme.sentMessageBodyBoldTextStyle
        : theme.receivedMessageBodyBoldTextStyle;
    final codeTextStyle = user.id == message.author.id
        ? theme.sentMessageBodyCodeTextStyle
        : theme.receivedMessageBodyCodeTextStyle;
    final bodyLinkTextStyle = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.sentMessageBodyLinkTextStyle
        : InheritedChatTheme.of(context).theme.receivedMessageBodyLinkTextStyle;

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
        ParsedText(
          text: message.text,
          selectable: true,
          style: bodyTextStyle,
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          parse: [
            MatchText(
              pattern: regexEmail,
              onTap: (mail) async {
                final url = 'mailto:$mail';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              style: bodyLinkTextStyle ??
                  bodyTextStyle.copyWith(decoration: TextDecoration.underline),
            ),
            MatchText(
              pattern: regexLink,
              onTap: (url) async {
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              style: bodyLinkTextStyle ??
                  bodyTextStyle.copyWith(decoration: TextDecoration.underline),
            ),
            MatchText(
              pattern: '(\\*\\*|\\*)(.*?)(\\*\\*|\\*)',
              onTap: (_) {},
              style: boldTextStyle ??
                  bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
              renderText: ({required String str, required String pattern}) {
                return {'display': str.replaceAll(RegExp('(\\*\\*|\\*)'), '')};
              },
            ),
            MatchText(
              pattern: '_(.*?)_',
              onTap: (_) {},
              style: bodyTextStyle.copyWith(fontStyle: FontStyle.italic),
              renderText: ({required String str, required String pattern}) {
                return {'display': str.replaceAll('_', '')};
              },
            ),
            MatchText(
              pattern: '~(.*?)~',
              onTap: (_) {},
              style: bodyTextStyle.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
              renderText: ({required String str, required String pattern}) {
                return {'display': str.replaceAll('~', '')};
              },
            ),
            MatchText(
              pattern: '`(.*?)`',
              onTap: (_) {},
              style: codeTextStyle ??
                  bodyTextStyle.copyWith(
                    fontFamily: Platform.isIOS ? 'Courier' : 'monospace',
                  ),
              renderText: ({required String str, required String pattern}) {
                return {'display': str.replaceAll('`', '')};
              },
            ),
          ],
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
