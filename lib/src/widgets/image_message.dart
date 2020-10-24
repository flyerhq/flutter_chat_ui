import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return CachedNetworkImage(imageUrl: message.url);
  }
}
