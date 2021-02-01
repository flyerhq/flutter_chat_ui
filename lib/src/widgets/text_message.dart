import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, PreviewData;
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
    this.onPreviewDataFetched,
  })  : assert(message != null),
        super(key: key);

  final types.TextMessage message;
  final void Function(types.TextMessage, PreviewData) onPreviewDataFetched;

  void _onPreviewDataFetched(PreviewData previewData) {
    if (onPreviewDataFetched != null)
      onPreviewDataFetched(message, previewData);
  }

  Widget _linkPreview(String text, double width) {
    return LinkPreview(
      onPreviewDataFetched: _onPreviewDataFetched,
      text: text,
      width: width,
    );
  }

  Widget _textWidget(String text, types.User user) {
    return Text(
      message.text,
      style: TextStyle(
        color: user.id == message.authorId
            ? const Color(0xffffffff)
            : const Color(0xff1d1d21),
        fontFamily: 'Avenir',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.375,
      ),
      textWidthBasis: TextWidthBasis.longestLine,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _width = MediaQuery.of(context).size.width;

    final urlRegexp = new RegExp(REGEX_LINK);
    final matches = urlRegexp.allMatches(message.text.toLowerCase());
    // if (matches.isEmpty) return previewData;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: matches.isEmpty
          ? _textWidget(message.text, _user)
          : _linkPreview(message.text, _width),
    );
  }
}

const REGEX_LINK = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
