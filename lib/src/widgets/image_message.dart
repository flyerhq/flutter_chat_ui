import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
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

typedef OnUploadSuccessCallback = void Function(types.ImageMessage message);

class ImageMessage extends StatefulWidget {
  /// Creates an image message widget based on [types.ImageMessage]
  const ImageMessage({
    Key? key,
    required this.message,
    required this.messageWidth,
    this.onUploadSuccessCallback,
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
  // ImageProvider? _image;
  // ImageStream? _stream;
  Size _size = const Size(0, 0);
  double _percentage = 0.0;
  bool _isUploading = false;
  bool _isNetworkImage = true;
  bool _isUploadFailed = false;
  late types.ImageMessage _message;
  String? _localUrl;

  @override
  void initState() {
    super.initState();
    _message = widget.message;
    _size = Size(_message.width ?? 0, _message.height ?? 0);

    if (!_message.uri.contains('http')) {
      _isNetworkImage = false;
      _uploadAttachment();
    } else {
      _isNetworkImage = true;
    }
  }

  bool isValidForFullScreen() {
    if (_isNetworkImage) {
      return true;
    } else if (_isUploading || _isUploadFailed) {
      return false;
    } else {
      return false;
    }
  }

  Future<void> _uploadAttachment() async {
    print("Upload started");
    if (mounted) {
      setState(() {
        _isUploading = true;
        _isUploadFailed = false;
        _percentage = 0.0;
      });
    }
    try {
      final fileUrl = await FileService().fileUploadMultipart(
          filePath: _message.uri,
          onUploadProgress: (percentage) {
            log("Uploading: $percentage");
            if (mounted) {
              setState(() {
                _percentage = percentage / 100;
              });
            }
          });
      if (widget.onUploadSuccessCallback != null) {
        _localUrl = _message.uri;
        _message = _message.copyWith(uri: fileUrl) as types.ImageMessage;
        widget.onUploadSuccessCallback!(_message);
      }
      if (mounted) {
        setState(() {
          _isUploading = false;
          _isNetworkImage = true;
        });
      }
    } catch (e) {
      if (mounted) {
        _isUploading = false;
        _isUploadFailed = true;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (_size.isEmpty) {
    //   _getImage();
    // }
  }
  /*
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
   */
  @override
  void dispose() {
    //_stream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser
        .of(context)
        .user;

      return Container(
        constraints: BoxConstraints(
          maxHeight: widget.messageWidth.toDouble(),
          minWidth: 170,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: AspectRatio(
            aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
            child: uploadProgress(),
          ),
        ),
      );
  }

  Widget uploadProgress() {
    return Stack(
      children: [
        _isNetworkImage
            ? Center(
          child: CachedNetworkImage(
            imageUrl: _message.uri,
            placeholder: (context, url) {
              return _localUrl != null
                  ? _getLocalImage(_localUrl!)
                  : CircularProgressIndicator();
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
          ),
        )
            : _getLocalImage(_message.uri),
        //child,
        Visibility(
          visible: _isUploading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: _percentage,
                backgroundColor: Colors.transparent,
                animation: true,
                animationDuration: 500,
                animateFromLastPercent: true,
                progressColor:
                InheritedChatTheme
                    .of(context)
                    .theme
                    .primaryColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isUploadFailed,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: InkWell(
              onTap: () {
                _uploadAttachment();
              },
              child: Center(
                child: Container(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.white,),
                    Text('Upload failed. Tap to retry.', style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,)
                  ],
                )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getLocalImage(String url) {
    return Center(
      child: Image(
        fit: BoxFit.cover,
        image: Conditional().getProvider(url),
      ),
    );
  }
}
