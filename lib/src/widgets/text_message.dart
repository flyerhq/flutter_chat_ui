import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/src/models/message.dart';

class TextMessage extends StatelessWidget {
  TextMessage({
    Key key,
    this.message,
  })  : assert(message != null),
        super(key: key);

  final TextMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
        ),
        textWidthBasis: TextWidthBasis.longestLine,
      ),
    );
  }
}
