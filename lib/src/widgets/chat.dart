import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/util.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/input.dart';
import 'package:flutter_chat_ui/src/widgets/message.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key key,
    this.isAttachmentUploading,
    @required this.messages,
    this.onAttachmentPressed,
    this.onFilePressed,
    this.onPreviewDataFetched,
    @required this.onSendPressed,
    @required this.user,
  })  : assert(messages != null),
        assert(onSendPressed != null),
        assert(user != null),
        super(key: key);

  final bool isAttachmentUploading;
  final List<types.Message> messages;
  final void Function() onAttachmentPressed;
  final void Function(types.FileMessage) onFilePressed;
  final void Function(types.TextMessage, types.PreviewData)
      onPreviewDataFetched;
  final void Function(types.PartialText) onSendPressed;
  final types.User user;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool _isImageViewVisible = false;
  int _imageViewIndex = 0;

  Widget _imageGalleryLoadingBuilder(
    BuildContext context,
    ImageChunkEvent event,
  ) {
    return Center(
      child: Container(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: event == null
              ? 0
              : event.cumulativeBytesLoaded / event.expectedTotalBytes,
        ),
      ),
    );
  }

  void _onCloseGalleryPressed() {
    setState(() {
      _isImageViewVisible = false;
    });
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _onImagePressed(
    String url,
    List<String> galleryItems,
  ) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setState(() {
      _isImageViewVisible = true;
      _imageViewIndex = galleryItems.indexOf(url);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _imageViewIndex = index;
    });
  }

  void _onPreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    if (widget.onPreviewDataFetched != null) {
      widget.onPreviewDataFetched(message, previewData);
    }
  }

  Widget _renderImageGallery(List<String> galleryItems) {
    return Dismissible(
      key: Key('gallery'),
      direction: DismissDirection.down,
      onDismissed: (direction) => _onCloseGalleryPressed(),
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(
              imageProvider: _renderImageProvider(galleryItems[index]),
            ),
            itemCount: galleryItems.length,
            loadingBuilder: (context, event) =>
                _imageGalleryLoadingBuilder(context, event),
            onPageChanged: _onPageChanged,
            pageController: PageController(initialPage: _imageViewIndex),
            scrollPhysics: const ClampingScrollPhysics(),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: CloseButton(
              color: Colors.white,
              onPressed: _onCloseGalleryPressed,
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _renderImageProvider(String url) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    }
    return FileImage(File(url));
  }

  @override
  Widget build(BuildContext context) {
    final _messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    List<String> galleryItems = widget.messages.fold(
      [],
      (previousValue, element) => element is types.ImageMessage
          ? List.from(
              [
                element.uri,
                ...previousValue,
              ],
            )
          : previousValue,
    );

    return InheritedUser(
      user: widget.user,
      child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Flexible(
                  child: widget.messages.length == 0
                      ? SizedBox.expand(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'No messages here yet',
                              style: const TextStyle(
                                color: Color(0xff9e9cab),
                                fontFamily: 'Avenir',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.375,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () =>
                              FocusManager.instance.primaryFocus.unfocus(),
                          child: ListView.builder(
                            itemCount: widget.messages.length + 1,
                            padding: EdgeInsets.zero,
                            reverse: true,
                            itemBuilder: (context, index) {
                              if (index == widget.messages.length) {
                                return Container(height: 16);
                              }

                              final message = widget.messages[index];
                              final isFirst = index == 0;
                              final isLast =
                                  index == widget.messages.length - 1;
                              final nextMessage =
                                  isLast ? null : widget.messages[index + 1];
                              final previousMessage =
                                  isFirst ? null : widget.messages[index - 1];

                              var nextMessageDifferentDay = false;
                              var nextMessageSameAuthor = false;
                              var previousMessageSameAuthor = false;
                              var shouldRenderTime = message.timestamp != null;

                              if (nextMessage != null) {
                                nextMessageDifferentDay =
                                    message.timestamp != null &&
                                        DateTime.fromMillisecondsSinceEpoch(
                                              message.timestamp * 1000,
                                            ).day !=
                                            DateTime.fromMillisecondsSinceEpoch(
                                              nextMessage.timestamp * 1000,
                                            ).day;
                                nextMessageSameAuthor =
                                    nextMessage.authorId == message.authorId;
                              }

                              if (previousMessage != null) {
                                previousMessageSameAuthor =
                                    previousMessage.authorId ==
                                        message.authorId;
                                shouldRenderTime = message.timestamp != null &&
                                    previousMessage.timestamp != null &&
                                    (!previousMessageSameAuthor ||
                                        previousMessage.timestamp -
                                                message.timestamp >=
                                            60);
                              }

                              return Column(
                                children: [
                                  if (nextMessageDifferentDay ||
                                      (isLast && message.timestamp != null))
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 32,
                                        top: nextMessageSameAuthor ? 24 : 16,
                                      ),
                                      child: Text(
                                        getVerboseDateTimeRepresentation(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            message.timestamp * 1000,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: const Color(0xff1d1d21),
                                          fontFamily: 'Avenir',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          height: 1.375,
                                        ),
                                      ),
                                    ),
                                  Message(
                                    key: ValueKey(message),
                                    onImagePressed: (url) {
                                      _onImagePressed(url, galleryItems);
                                    },
                                    message: message,
                                    messageWidth: _messageWidth,
                                    onFilePressed: widget.onFilePressed,
                                    onPreviewDataFetched: _onPreviewDataFetched,
                                    previousMessageSameAuthor:
                                        previousMessageSameAuthor,
                                    shouldRenderTime: shouldRenderTime,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),
                Input(
                  isAttachmentUploading: widget.isAttachmentUploading,
                  onAttachmentPressed: widget.onAttachmentPressed,
                  onSendPressed: widget.onSendPressed,
                ),
              ],
            ),
          ),
          if (_isImageViewVisible) _renderImageGallery(galleryItems),
        ],
      ),
    );
  }
}
