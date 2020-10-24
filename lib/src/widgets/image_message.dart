import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/src/models/message.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key key,
    this.message,
  })  : assert(message != null),
        super(key: key);

  final ImageMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Image.network(message.url);
  }
}
