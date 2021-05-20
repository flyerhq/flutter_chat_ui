import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_l10n.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../chat_l10n.dart';
import '../chat_theme.dart';
import '../conditional/conditional.dart';
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';
import 'input.dart';
import 'message.dart';

/// Entry widget, represents the complete chat
class Chat extends StatefulWidget {
  /// Creates a chat widget
  const Chat({
    Key? key,
    this.dateLocale,
    this.disableImageGallery,
    this.isAttachmentUploading,
    this.l10n = const ChatL10nEn(),
    required this.messages,
    this.onAttachmentPressed,
    this.onMessageLongPress,
    this.onMessageTap,
    this.onPreviewDataFetched,
    required this.onSendPressed,
    this.theme = const DefaultChatTheme(),
    this.usePreviewData = true,
    required this.user,
  }) : super(key: key);

  /// See [Message.dateLocale]
  final String? dateLocale;

  /// Disable automatic image preview on tap.
  final bool? disableImageGallery;

  /// See [Input.isAttachmentUploading]
  final bool? isAttachmentUploading;

  /// Localized copy. Extend [ChatL10n] class to create your own copy or use
  /// existing one, like the default [ChatL10nEn]. You can customize only
  /// certain variables, see more here [ChatL10nEn].
  final ChatL10n l10n;

  /// List of [types.Message] to render in the chat widget
  final List<types.Message> messages;

  /// See [Input.onAttachmentPressed]
  final void Function()? onAttachmentPressed;

  /// See [Message.onMessageLongPress]
  final void Function(types.Message)? onMessageLongPress;

  /// See [Message.onMessageTap]
  final void Function(types.Message)? onMessageTap;

  /// See [Message.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// See [Input.onSendPressed]
  final void Function(types.PartialText) onSendPressed;

  /// Chat theme. Extend [ChatTheme] class to create your own theme or use
  /// existing one, like the [DefaultChatTheme]. You can customize only certain
  /// variables, see more here [DefaultChatTheme].
  final ChatTheme theme;

  /// See [Message.usePreviewData]
  final bool usePreviewData;

  /// See [InheritedUser.user]
  final types.User user;

  @override
  _ChatState createState() => _ChatState();
}

/// [Chat] widget state
class _ChatState extends State<Chat> {
  bool _isImageViewVisible = false;
  int _imageViewIndex = 0;

  Widget _imageGalleryLoadingBuilder(
    BuildContext context,
    ImageChunkEvent? event,
  ) {
    return Center(
      child: SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: event == null || event.expectedTotalBytes == null
              ? 0
              : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
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
    String uri,
    List<String> galleryItems,
  ) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setState(() {
      _isImageViewVisible = true;
      _imageViewIndex = galleryItems.indexOf(uri);
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
    widget.onPreviewDataFetched?.call(message, previewData);
  }

  Widget _renderImageGallery(List<String> galleryItems) {
    return Dismissible(
      key: const Key('photo_view_gallery'),
      direction: DismissDirection.down,
      onDismissed: (direction) => _onCloseGalleryPressed(),
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(
              imageProvider: Conditional().getProvider(galleryItems[index]),
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

  @override
  Widget build(BuildContext context) {
    final _messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    final galleryItems =
        widget.messages.fold<List<String>>([], (previousValue, element) {
      // Check if element is image message
      if (element is types.ImageMessage) {
        // For web add only remote uri, local files are not yet supported
        if (kIsWeb) {
          if (element.uri.startsWith('http')) {
            return [element.uri, ...previousValue];
          } else {
            return previousValue;
          }
          // For everything else add uri
        } else {
          return [element.uri, ...previousValue];
        }
      }

      return previousValue;
    });

    return InheritedUser(
      user: widget.user,
      child: InheritedChatTheme(
        theme: widget.theme,
        child: InheritedL10n(
          l10n: widget.l10n,
          child: Stack(
            children: [
              Container(
                color: widget.theme.backgroundColor,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Flexible(
                        child: widget.messages.isEmpty
                            ? SizedBox.expand(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Text(
                                    widget.l10n.emptyChatPlaceholder,
                                    style: widget.theme.body1.copyWith(
                                      color: widget.theme.captionColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => FocusManager.instance.primaryFocus
                                    ?.unfocus(),
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
                                    final nextMessage = isLast
                                        ? null
                                        : widget.messages[index + 1];
                                    final previousMessage = isFirst
                                        ? null
                                        : widget.messages[index - 1];

                                    var nextMessageDifferentDay = false;
                                    var nextMessageSameAuthor = false;
                                    var previousMessageSameAuthor = false;
                                    var shouldRenderTime =
                                        message.timestamp != null;

                                    if (nextMessage != null &&
                                        nextMessage.timestamp != null) {
                                      nextMessageDifferentDay = message
                                                  .timestamp !=
                                              null &&
                                          DateTime.fromMillisecondsSinceEpoch(
                                                message.timestamp! * 1000,
                                              ).day !=
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                nextMessage.timestamp! * 1000,
                                              ).day;
                                      nextMessageSameAuthor =
                                          nextMessage.authorId ==
                                              message.authorId;
                                    }

                                    if (previousMessage != null) {
                                      previousMessageSameAuthor =
                                          previousMessage.authorId ==
                                              message.authorId;
                                      shouldRenderTime = message.timestamp !=
                                              null &&
                                          previousMessage.timestamp != null &&
                                          (!previousMessageSameAuthor ||
                                              previousMessage.timestamp! -
                                                      message.timestamp! >=
                                                  60);
                                    }

                                    return Column(
                                      children: [
                                        if (nextMessageDifferentDay ||
                                            (isLast &&
                                                message.timestamp != null))
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: 32,
                                              top: nextMessageSameAuthor
                                                  ? 24
                                                  : 16,
                                            ),
                                            child: Text(
                                              getVerboseDateTimeRepresentation(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                  message.timestamp! * 1000,
                                                ),
                                                widget.dateLocale,
                                                widget.l10n.today,
                                                widget.l10n.yesterday,
                                              ),
                                              style: widget.theme.subtitle2
                                                  .copyWith(
                                                color:
                                                    widget.theme.subtitle2Color,
                                              ),
                                            ),
                                          ),
                                        Message(
                                          key: ValueKey(message),
                                          dateLocale: widget.dateLocale,
                                          message: message,
                                          messageWidth: _messageWidth,
                                          onMessageLongPress:
                                              widget.onMessageLongPress,
                                          onMessageTap: (tappedMessage) {
                                            if (tappedMessage
                                                    is types.ImageMessage &&
                                                widget.disableImageGallery !=
                                                    true) {
                                              _onImagePressed(
                                                tappedMessage.uri,
                                                galleryItems,
                                              );
                                            }

                                            widget.onMessageTap
                                                ?.call(tappedMessage);
                                          },
                                          onPreviewDataFetched:
                                              _onPreviewDataFetched,
                                          previousMessageSameAuthor:
                                              previousMessageSameAuthor,
                                          shouldRenderTime: shouldRenderTime,
                                          usePreviewData: widget.usePreviewData,
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
              ),
              if (_isImageViewVisible) _renderImageGallery(galleryItems),
            ],
          ),
        ),
      ),
    );
  }
}
