import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({
    Key key,
    this.message,
    this.messageWidth,
  })  : assert(message != null),
        assert(messageWidth != null),
        super(key: key);

  final ImageMessageModel message;
  final int messageWidth;

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  Size _size = Size(0, 0);

  @override
  void initState() {
    super.initState();
    setState(() {
      _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);
    });
  }

  Widget _buildImage(ImageProvider<Object> imageProvider) {
    final widget = Image(
      fit: BoxFit.contain,
      image: imageProvider,
    );

    if (_size.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.image
            .resolve(ImageConfiguration.empty)
            .addListener(ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _size = Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            );
          });
        }));
      });
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.messageWidth.toDouble(),
        minWidth: 170,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.message.url),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AspectRatio(
          aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) =>
                _buildImage(imageProvider),
            imageUrl: widget.message.url,
          ),
        ),
      ),
    );
  }
}
