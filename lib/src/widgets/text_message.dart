import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, REGEX_LINK;
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
    this.onPreviewDataFetched,
  })  : assert(message != null),
        super(key: key);

  final types.TextMessage message;
  final void Function(types.TextMessage, types.PreviewData)
      onPreviewDataFetched;

  void _onPreviewDataFetched(types.PreviewData previewData) {
    if (message.previewData == null && onPreviewDataFetched != null) {
      onPreviewDataFetched(message, previewData);
    }
  }

  Widget _linkPreview(
    types.User user,
    double width,
  ) {
    final style = TextStyle(
      color: user.id == message.authorId
          ? const Color(0xffffffff)
          : const Color(0xff1d1d21),
      fontFamily: 'Avenir',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.375,
    );

    return LinkPreview(
      linkStyle: style,
      metadataTextStyle: style.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      metadataTitleStyle: style.copyWith(
        fontWeight: FontWeight.w800,
      ),
      onPreviewDataFetched: _onPreviewDataFetched,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      previewData: message.previewData,
      text: message.text,
      textStyle: style,
      width: width,
    );
  }

  Widget _textWidget(types.User user) {
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

    final urlRegexp = RegExp(REGEX_LINK);
    final matches = urlRegexp.allMatches(message.text.toLowerCase());

    if (matches.isNotEmpty) return _linkPreview(_user, _width);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: _textWidget(_user),
    );
  }
}
