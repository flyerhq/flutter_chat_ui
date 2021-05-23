import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/util.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, REGEX_LINK;
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// A class that represents text message widget with optional link preview
class TextMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.TextMessage] class
  const TextMessage({
    Key? key,
    required this.message,
    this.onPreviewDataFetched,
    required this.usePreviewData,
    this.showName = false,
  }) : super(key: key);

  /// [types.TextMessage]
  final types.TextMessage message;

  /// See [LinkPreview.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Whether message author should be shown
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
    final color = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.primaryTextColor
        : InheritedChatTheme.of(context).theme.secondaryTextColor;

    final userName = getUserName(message.author);

    return LinkPreview(
      enableAnimation: true,
      header: showName && userName != '' ? userName : null,
      headerStyle: InheritedChatTheme.of(context).theme.body1.copyWith(
            color: color,
          ),
      linkStyle: InheritedChatTheme.of(context).theme.body1.copyWith(
            color: color,
          ),
      metadataTextStyle: InheritedChatTheme.of(context).theme.body2.copyWith(
            color: color,
          ),
      metadataTitleStyle:
          InheritedChatTheme.of(context).theme.subtitle1.copyWith(
                color: color,
              ),
      onPreviewDataFetched: _onPreviewDataFetched,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      previewData: message.previewData,
      text: message.text,
      textStyle: InheritedChatTheme.of(context).theme.body1.copyWith(
            color: color,
          ),
      width: width,
    );
  }

  Widget _textWidget(types.User user, BuildContext context) {
    final userName = getUserName(message.author);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName && userName != '')
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              userName,
              style: InheritedChatTheme.of(context).theme.body1.copyWith(
                    color: user.id == message.author.id
                        ? InheritedChatTheme.of(context).theme.primaryTextColor
                        : InheritedChatTheme.of(context)
                            .theme
                            .secondaryTextColor,
                  ),
            ),
          ),
        Text(
          message.text,
          style: InheritedChatTheme.of(context).theme.body1.copyWith(
                color: user.id == message.author.id
                    ? InheritedChatTheme.of(context).theme.primaryTextColor
                    : InheritedChatTheme.of(context).theme.secondaryTextColor,
              ),
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _width = MediaQuery.of(context).size.width;

    final urlRegexp = RegExp(REGEX_LINK);
    final matches = urlRegexp.allMatches(message.text.toLowerCase());

    if (matches.isNotEmpty && usePreviewData) {
      return _linkPreview(_user, _width, context);
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: _textWidget(_user, context),
    );
  }
}
