import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, regexEmail, regexLink;
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/emoji_enlargement_behavior.dart';
import '../models/preview_tap_options.dart';
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';
import 'user_name.dart';

/// A class that represents text message widget with optional link preview
class TextMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.TextMessage] class
  const TextMessage({
    super.key,
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.isTextMessageTextSelectable,
    required this.message,
    this.nameBuilder,
    this.onPreviewDataFetched,
    required this.previewTapOptions,
    required this.showName,
    required this.usePreviewData,
    this.userAgent,
  });

  /// See [Message.emojiEnlargementBehavior]
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// See [Message.hideBackgroundOnEmojiMessages]
  final bool hideBackgroundOnEmojiMessages;

  /// Whether user can tap and hold to select a text content
  final bool isTextMessageTextSelectable;

  /// [types.TextMessage]
  final types.TextMessage message;

  /// This is to allow custom user name builder
  /// By using this we can fetch newest user info based on id
  final Widget Function(String userId)? nameBuilder;

  /// See [LinkPreview.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// See [LinkPreview.openOnPreviewImageTap] and [LinkPreview.openOnPreviewTitleTap]
  final PreviewTapOptions previewTapOptions;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Enables link (URL) preview
  final bool usePreviewData;

  /// User agent to fetch preview data with
  final String? userAgent;

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
      metadataTextStyle: linkDescriptionTextStyle,
      metadataTitleStyle: linkTitleTextStyle,
      onPreviewDataFetched: _onPreviewDataFetched,
      openOnPreviewImageTap: previewTapOptions.openOnImageTap,
      openOnPreviewTitleTap: previewTapOptions.openOnTitleTap,
      padding: EdgeInsets.symmetric(
        horizontal:
            InheritedChatTheme.of(context).theme.messageInsetsHorizontal,
        vertical: InheritedChatTheme.of(context).theme.messageInsetsVertical,
      ),
      previewData: message.previewData,
      text: message.text,
      textWidget: _textWidgetBuilder(user, context, false),
      userAgent: userAgent,
      width: width,
    );
  }

  Widget _textWidgetBuilder(
    types.User user,
    BuildContext context,
    bool enlargeEmojis,
  ) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final theme = InheritedChatTheme.of(context).theme;
    final bodyLinkTextStyle = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.sentMessageBodyLinkTextStyle
        : InheritedChatTheme.of(context).theme.receivedMessageBodyLinkTextStyle;
    final bodyTextStyle = user.id == message.author.id
        ? theme.sentMessageBodyTextStyle
        : theme.receivedMessageBodyTextStyle;
    final boldTextStyle = user.id == message.author.id
        ? theme.sentMessageBodyBoldTextStyle
        : theme.receivedMessageBodyBoldTextStyle;
    final codeTextStyle = user.id == message.author.id
        ? theme.sentMessageBodyCodeTextStyle
        : theme.receivedMessageBodyCodeTextStyle;
    final emojiTextStyle = user.id == message.author.id
        ? theme.sentEmojiMessageTextStyle
        : theme.receivedEmojiMessageTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          nameBuilder?.call(message.author.id) ??
              UserName(author: message.author),
        if (enlargeEmojis)
          if (isTextMessageTextSelectable)
            SelectableText(message.text, style: emojiTextStyle)
          else
            Text(message.text, style: emojiTextStyle)
        else
          ParsedText(
            parse: [
              MatchText(
                onTap: (mail) async {
                  final url = Uri(scheme: 'mailto', path: mail);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                pattern: regexEmail,
                style: bodyLinkTextStyle ??
                    bodyTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
              MatchText(
                onTap: (urlText) async {
                  final protocolIdentifierRegex = RegExp(
                    r'^((http|ftp|https):\/\/)',
                    caseSensitive: false,
                  );
                  if (!urlText.startsWith(protocolIdentifierRegex)) {
                    urlText = "https://$urlText";
                  }
                  final url = Uri.tryParse(urlText);
                  if (url != null && await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                pattern: regexLink,
                style: bodyLinkTextStyle ??
                    bodyTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
              MatchText(
                pattern: '(\\*\\*|\\*)(.*?)(\\*\\*|\\*)',
                style: boldTextStyle ??
                    bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                renderText: ({required String str, required String pattern}) {
                  return {
                    'display': str.replaceAll(RegExp('(\\*\\*|\\*)'), '')
                  };
                },
              ),
              MatchText(
                pattern: '_(.*?)_',
                style: bodyTextStyle.copyWith(fontStyle: FontStyle.italic),
                renderText: ({required String str, required String pattern}) {
                  return {'display': str.replaceAll('_', '')};
                },
              ),
              MatchText(
                pattern: '~(.*?)~',
                style: bodyTextStyle.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
                renderText: ({required String str, required String pattern}) {
                  return {'display': str.replaceAll('~', '')};
                },
              ),
              MatchText(
                pattern: '`(.*?)`',
                style: codeTextStyle ??
                    bodyTextStyle.copyWith(
                      fontFamily: isIOS ? 'Courier' : 'monospace',
                    ),
                renderText: ({required String str, required String pattern}) {
                  return {'display': str.replaceAll('`', '')};
                },
              ),
            ],
            regexOptions: const RegexOptions(multiLine: true, dotAll: true),
            selectable: isTextMessageTextSelectable,
            style: bodyTextStyle,
            text: message.text,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            isConsistsOfEmojis(emojiEnlargementBehavior, message);
    final theme = InheritedChatTheme.of(context).theme;
    final user = InheritedUser.of(context).user;
    final width = MediaQuery.of(context).size.width;

    if (usePreviewData && onPreviewDataFetched != null) {
      final urlRegexp = RegExp(regexLink, caseSensitive: false);
      final matches = urlRegexp.allMatches(message.text);

      if (matches.isNotEmpty) {
        return _linkPreview(user, width, context);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.messageInsetsHorizontal,
        vertical: theme.messageInsetsVertical,
      ),
      child: _textWidgetBuilder(user, context, enlargeEmojis),
    );
  }
}
