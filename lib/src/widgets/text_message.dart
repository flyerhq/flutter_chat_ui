import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, REGEX_LINK;
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
    this.onPreviewDataFetched,
  }) : super(key: key);

  final types.TextMessage message;
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

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
    final color = user.id == message.authorId
        ? InheritedChatTheme.of(context).theme.primaryTextColor
        : InheritedChatTheme.of(context).theme.secondaryTextColor;

    return LinkPreview(
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
    return Text(
      message.text,
      style: InheritedChatTheme.of(context).theme.body1.copyWith(
            color: user.id == message.authorId
                ? InheritedChatTheme.of(context).theme.primaryTextColor
                : InheritedChatTheme.of(context).theme.secondaryTextColor,
          ),
      textWidthBasis: TextWidthBasis.longestLine,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _width = MediaQuery.of(context).size.width;

    final urlRegexp = RegExp(REGEX_LINK);
    final matches = urlRegexp.allMatches(message.text.toLowerCase());

    if (matches.isNotEmpty) return _linkPreview(_user, _width, context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: _textWidget(_user, context),
    );
  }
}
