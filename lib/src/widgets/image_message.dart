import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/uploader/file_upload_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../conditional/conditional.dart';
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// A class that represents image message widget. Supports different
/// aspect ratios, renders blurred image as a background which is visible
/// if the image is narrow, renders image in form of a file if aspect
/// ratio is very small or very big.

typedef OnUploadSuccessCallback = void Function(types.Message message);

class ImageMessage extends StatefulWidget {
  /// Creates an image message widget based on [types.ImageMessage]
  const ImageMessage({
    Key? key,
    required this.message,
    required this.messageWidth, this.onUploadSuccessCallback,
  }) : super(key: key);

  /// [types.ImageMessage]
  final types.ImageMessage message;

  /// Maximum message width
  final int messageWidth;

  final OnUploadSuccessCallback? onUploadSuccessCallback;

  @override
  _ImageMessageState createState() => _ImageMessageState();
}

/// [ImageMessage] widget state
class _ImageMessageState extends State<ImageMessage> {
  ImageProvider? _image;
  ImageStream? _stream;
  Size _size = const Size(0, 0);
  double _percentage = 0.0;
  bool _isUploading = false;
  
  @override
  void initState() {
    super.initState();
    _image = Conditional().getProvider(widget.message.uri);
    _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);

    if (!widget.message.uri.contains('http')) {
     _uploadAttachment();
    }
  }

  Future<void> _uploadAttachment() async {
    if (mounted) {
      setState(() {
        _isUploading = true;
      });
    }

    final fileUrl = await FileService().fileUploadMultipart(filePath: widget.message.uri, onUploadProgress: (percentage){
      if (mounted) {
        setState(() {
          _percentage = percentage/100;
        });
      }
    });
    if (mounted) {
      setState(() {
        _isUploading = false;
      });
    }

    if (widget.onUploadSuccessCallback != null) {
      final message = widget.message.copyWith(uri: fileUrl);
      widget.onUploadSuccessCallback!(message);
    }
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

    if (_size.aspectRatio == 0) {
      return Container(
        color: InheritedChatTheme.of(context).theme.secondaryColor,
        height: _size.height,
        width: _size.width,
      );
    } else if (_size.aspectRatio < 0.1 || _size.aspectRatio > 10) {
      return Container(
        color: _user.id == widget.message.author.id
            ? InheritedChatTheme.of(context).theme.primaryColor
            : InheritedChatTheme.of(context).theme.secondaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              margin: const EdgeInsets.all(16),
              width: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: uploadProgress(
                  child: Image(
                    fit: BoxFit.cover,
                    image: _image!,
                  ),
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
                      widget.message.name,
                      style: _user.id == widget.message.author.id
                          ? InheritedChatTheme.of(context)
                              .theme
                              .sentMessageBodyTextStyle
                          : InheritedChatTheme.of(context)
                              .theme
                              .receivedMessageBodyTextStyle,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        formatBytes(widget.message.size),
                        style: _user.id == widget.message.author.id
                            ? InheritedChatTheme.of(context)
                                .theme
                                .sentMessageCaptionTextStyle
                            : InheritedChatTheme.of(context)
                                .theme
                                .receivedMessageCaptionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            child: uploadProgress(
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

  Widget uploadProgress({required Widget child}) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: _isUploading,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: _percentage,
                backgroundColor: Colors.transparent,
                progressColor: InheritedChatTheme.of(context).theme.primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
