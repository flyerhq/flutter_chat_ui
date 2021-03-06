import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../util.dart';
import 'inherited_user.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({
    Key? key,
    required this.message,
    required this.messageWidth,
    required this.onPressed,
  }) : super(key: key);

  final types.ImageMessage message;
  final int messageWidth;
  final void Function(String uri) onPressed;

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  ImageProvider? _image;
  ImageStream? _stream;
  Size _size = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    if (widget.message.uri.startsWith('http')) {
      _image = NetworkImage(widget.message.uri);
    } else {
      _image = FileImage(File(widget.message.uri));
    }

    _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_size.isEmpty) {
      _getImage();
    }
  }

  void _getImage() {
    final oldImageStream = _stream;
    _stream = _image?.resolve(createLocalImageConfiguration(context));
    if (_stream?.key == oldImageStream?.key) {
      return;
    }
    final listener = ImageStreamListener(_updateImage);
    oldImageStream?.removeListener(listener);
    _stream?.addListener(listener);
  }

  void _updateImage(ImageInfo info, bool _) {
    setState(() {
      _size = Size(
        info.image.width.toDouble(),
        info.image.height.toDouble(),
      );
    });
  }

  @override
  void dispose() {
    _stream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;

    if (_size.aspectRatio == null || _size.aspectRatio == 0) {
      return Container(
        color: const Color(0xfff7f7f8),
        height: _size.height,
        width: _size.width,
      );
    } else if (_size.aspectRatio < 0.1 || _size.aspectRatio > 10) {
      return GestureDetector(
        onTap: () => widget.onPressed(widget.message.uri),
        child: Container(
          color: _user.id == widget.message.authorId
              ? const Color(0xff6f61e8)
              : const Color(0xfff7f7f8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 64,
                margin: const EdgeInsets.all(16),
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    fit: BoxFit.cover,
                    image: _image!,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.imageName,
                        style: TextStyle(
                          color: _user.id == widget.message.authorId
                              ? const Color(0xffffffff)
                              : const Color(0xff1d1d21),
                          fontFamily: 'Avenir',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.375,
                        ),
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 4,
                        ),
                        child: Text(
                          formatBytes(widget.message.size),
                          style: TextStyle(
                            color: _user.id == widget.message.authorId
                                ? const Color(0x80ffffff)
                                : const Color(0xff9e9cab),
                            fontFamily: 'Avenir',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.375,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
          maxHeight: widget.messageWidth.toDouble(),
          minWidth: 170,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _image!,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: AspectRatio(
            aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
            child: GestureDetector(
              onTap: () => widget.onPressed(widget.message.uri),
              child: Image(
                fit: BoxFit.contain,
                image: _image!,
              ),
            ),
          ),
        ),
      );
    }
  }
}
