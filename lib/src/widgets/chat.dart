import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_l10n.dart';
import 'package:intl/intl.dart';
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
    this.buildCustomMessage,
    this.customDateHeaderText,
    this.dateFormat,
    this.dateLocale,
    this.disableImageGallery,
    this.emptyState,
    this.isAttachmentUploading,
    this.isLastPage,
    this.l10n = const ChatL10nEn(),
    required this.messages,
    this.onAttachmentPressed,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.onMessageLongPress,
    this.onMessageTap,
    this.onPreviewDataFetched,
    required this.onSendPressed,
    this.onTextChanged,
    this.showUserAvatars = false,
    this.showUserNames = false,
    this.theme = const DefaultChatTheme(),
    this.timeFormat,
    this.usePreviewData = true,
    required this.user,
  }) : super(key: key);

  /// See [Message.buildCustomMessage]
  final Widget Function(types.Message)? buildCustomMessage;

  /// If [dateFormat], [dateLocale] and/or [timeFormat] is not enough to
  /// customize date headers in your case, use this to return an arbitrary
  /// string based on a [DateTime] of a particular message. Can be helpful to
  /// return "Today" if [DateTime] is today. IMPORTANT: this will replace
  /// all default date headers, so you must handle all cases yourself, like
  /// for example today, yesterday and before. Or you can just return the same
  /// date header for any message.
  final String Function(DateTime)? customDateHeaderText;

  /// Allows you to customize the date format. IMPORTANT: only for the date,
  /// do not return time here. See [timeFormat] to customize the time format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized date
  /// make sure you initialize your [DateFormat] with a locale. See [customDateHeaderText]
  /// for more customization.
  final DateFormat? dateFormat;

  /// Locale will be passed to the `Intl` package. Make sure you initialized
  /// date formatting in your app before passing any locale here, otherwise
  /// an error will be thrown. Also see [customDateHeaderText], [dateFormat], [timeFormat].
  final String? dateLocale;

  /// Disable automatic image preview on tap.
  final bool? disableImageGallery;

  /// Allows you to change what the user sees when there are no messages.
  /// `emptyChatPlaceholder` and `emptyChatPlaceholderTextStyle` are ignored
  /// in this case.
  final Widget? emptyState;

  /// See [Input.isAttachmentUploading]
  final bool? isAttachmentUploading;

  /// See [ChatList.isLastPage]
  final bool? isLastPage;

  /// Localized copy. Extend [ChatL10n] class to create your own copy or use
  /// existing one, like the default [ChatL10nEn]. You can customize only
  /// certain variables, see more here [ChatL10nEn].
  final ChatL10n l10n;

  /// List of [types.Message] to render in the chat widget
  final List<types.Message> messages;

  /// See [Input.onAttachmentPressed]
  final void Function()? onAttachmentPressed;

  /// See [ChatList.onEndReached]
  final Future<void> Function()? onEndReached;

  /// See [ChatList.onEndReachedThreshold]
  final double? onEndReachedThreshold;

  /// See [Message.onMessageLongPress]
  final void Function(types.Message)? onMessageLongPress;

  /// See [Message.onMessageTap]
  final void Function(types.Message)? onMessageTap;

  /// See [Message.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// See [Input.onSendPressed]
  final void Function(types.PartialText) onSendPressed;

  /// See [Input.onTextChanged]
  final void Function(String)? onTextChanged;

  /// See [Message.showUserAvatars]
  final bool showUserAvatars;

  /// Show user names for received messages. Useful for a group chat. Will be
  /// shown only on text messages.
  final bool showUserNames;

  /// Chat theme. Extend [ChatTheme] class to create your own theme or use
  /// existing one, like the [DefaultChatTheme]. You can customize only certain
  /// variables, see more here [DefaultChatTheme].
  final ChatTheme theme;

  /// Allows you to customize the time format. IMPORTANT: only for the time,
  /// do not return date here. See [dateFormat] to customize the date format.
  /// [dateLocale] will be ignored if you use this, so if you want a localized time
  /// make sure you initialize your [DateFormat] with a locale. See [customDateHeaderText]
  /// for more customization.
  final DateFormat? timeFormat;

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
      final result = calculateChatMessages(
        widget.messages,
        widget.user,
        customDateHeaderText: widget.customDateHeaderText,
        dateFormat: widget.dateFormat,
        dateLocale: widget.dateLocale,
        showUserNames: widget.showUserNames,
        timeFormat: widget.timeFormat,
      );

      _chatMessages = result[0] as List<Object>;
      _gallery = result[1] as List<PreviewImage>;
    }
  }

  Widget _buildEmptyState() {
    return widget.emptyState ??
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Text(
            widget.l10n.emptyChatPlaceholder,
            style: widget.theme.emptyChatPlaceholderTextStyle,
            textAlign: TextAlign.center,
          ),
        );
  }

  Widget _buildImageGallery() {
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
    if (object is DateHeader) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 32,
          top: 16,
        ),
        child: Text(
          object.text,
          style: widget.theme.dateDividerTextStyle,
        ),
      );
    } else if (object is MessageSpacer) {
      return SizedBox(
        height: object.height,
      );
    } else {
      final map = object as Map<String, Object>;
      final message = map['message']! as types.Message;
      final _messageWidth =
          widget.showUserAvatars && message.author.id != widget.user.id
              ? min(MediaQuery.of(context).size.width * 0.72, 440).floor()
              : min(MediaQuery.of(context).size.width * 0.78, 440).floor();

      return Message(
        key: ValueKey(message.id),
        buildCustomMessage: widget.buildCustomMessage,
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
        roundBorder: map['nextMessageInGroup'] == true,
        showAvatar:
            widget.showUserAvatars && map['nextMessageInGroup'] == false,
        showName: map['showName'] == true,
        showStatus: map['showStatus'] == true,
        showUserAvatars: widget.showUserAvatars,
        usePreviewData: widget.usePreviewData,
      );
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
                                child: _buildEmptyState(),
                              )
                            : GestureDetector(
                                onTap: () => FocusManager.instance.primaryFocus
                                    ?.unfocus(),
                                child: ChatList(
                                  isLastPage: widget.isLastPage,
                                  itemBuilder: (item, index) =>
                                      _buildMessage(item),
                                  items: _chatMessages,
                                  onEndReached: widget.onEndReached,
                                  onEndReachedThreshold:
                                      widget.onEndReachedThreshold,
                                ),
                              ),
                      ),
                      Input(
                        isAttachmentUploading: widget.isAttachmentUploading,
                        onAttachmentPressed: widget.onAttachmentPressed,
                        onSendPressed: widget.onSendPressed,
                        onTextChanged: widget.onTextChanged,
                      ),
                    ],
                  ),
                ),
              ),
              if (_isImageViewVisible) _buildImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
