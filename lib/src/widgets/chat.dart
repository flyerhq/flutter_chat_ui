import 'dart:math';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_l10n.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../chat_l10n.dart';
import '../chat_theme.dart';
import '../conditional/conditional.dart';
import '../models/date_header.dart';
import '../models/message_spacer.dart';
import '../models/preview_image.dart';
import '../util.dart';
import 'chat_list.dart';
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
  List<Object> _chatMessages = [];
  List<PreviewImage> _gallery = [];
  int _imageViewIndex = 0;
  bool _isImageViewVisible = false;

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.messages.isNotEmpty) {
      compute(calculateChatMessages, {
        'dateLocale': widget.dateLocale,
        'messages': widget.messages,
      }).then((value) {
        setState(() {
          _chatMessages = value[0] as List<Object>;
          _gallery = value[1] as List<PreviewImage>;
        });
      });
    }
  }

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
  }

  void _onImagePressed(types.ImageMessage message) {
    setState(() {
      _imageViewIndex = _gallery.indexWhere(
        (element) => element.id == message.id && element.uri == message.uri,
      );
      _isImageViewVisible = true;
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

  Widget _renderImageGallery() {
    return Dismissible(
      key: const Key('photo_view_gallery'),
      direction: DismissDirection.down,
      onDismissed: (direction) => _onCloseGalleryPressed(),
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(
              imageProvider: Conditional().getProvider(_gallery[index].uri),
            ),
            itemCount: _gallery.length,
            loadingBuilder: (context, event) =>
                _imageGalleryLoadingBuilder(context, event),
            onPageChanged: _onPageChanged,
            pageController: PageController(initialPage: _imageViewIndex),
            scrollPhysics: const ClampingScrollPhysics(),
          ),
          Positioned(
            right: 16,
            top: 56,
            child: CloseButton(
              color: Colors.white,
              onPressed: _onCloseGalleryPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Object object) {
    final _messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    if (object is DateHeader) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 32,
          top: 16,
        ),
        child: Text(
          object.text,
          style: widget.theme.subtitle2.copyWith(
            color: widget.theme.subtitle2Color,
          ),
        ),
      );
    } else if (object is MessageSpacer) {
      return SizedBox(
        height: object.height,
      );
    } else {
      final map = object as Map<String, Object>;
      final message = map['message']! as types.Message;

      return Message(
        key: ValueKey(message.id),
        dateLocale: widget.dateLocale,
        message: message,
        messageWidth: _messageWidth,
        onMessageLongPress: widget.onMessageLongPress,
        onMessageTap: (tappedMessage) {
          if (tappedMessage is types.ImageMessage &&
              widget.disableImageGallery != true) {
            _onImagePressed(tappedMessage);
          }

          widget.onMessageTap?.call(tappedMessage);
        },
        onPreviewDataFetched: _onPreviewDataFetched,
        roundBorder: map['roundBorder'] == true,
        shouldRenderTime: false,
        usePreviewData: widget.usePreviewData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                child: ChatList(
                                  itemBuilder: (item, index) =>
                                      _buildMessage(item),
                                  items: _chatMessages,
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
              if (_isImageViewVisible) _renderImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
