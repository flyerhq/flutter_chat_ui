import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Types;

class ImageMessage extends StatefulWidget {
  const ImageMessage({
    Key key,
    this.message,
    this.messageWidth,
  })  : assert(message != null),
        assert(messageWidth != null),
        super(key: key);

  final Types.ImageMessage message;
  final int messageWidth;

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  CachedNetworkImageProvider _imageProvider;
  ImageStreamListener _listener;
  ImageStream _stream;
  Size _size = Size(0, 0);

  @override
  void initState() {
    super.initState();
    _imageProvider = CachedNetworkImageProvider(widget.message.url);
    _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);

    if (_size.isEmpty) {
      _stream = _imageProvider.resolve(ImageConfiguration.empty);
      _listener = ImageStreamListener(_updateSize);
      _stream.addListener(_listener);
    }
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  void _updateSize(ImageInfo info, bool _) {
    if (info != null) {
      setState(() {
        _size = Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        );
      });
    }
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
          fit: BoxFit.cover,
          image: _imageProvider,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AspectRatio(
          aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
          child: Image(
            fit: BoxFit.contain,
            image: _imageProvider,
          ),
        ),
      ),
    );
  }
}
