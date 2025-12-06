import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flyer_chat_file_message/flyer_chat_file_message.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_system_message/flyer_chat_system_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:uuid/uuid.dart';

import 'create_message.dart';
import 'widgets/composer_action_bar.dart';

class Local extends StatefulWidget {
  final Dio dio;

  const Local({super.key, required this.dio});

  @override
  LocalState createState() => LocalState();
}

class LocalState extends State<Local> {
  final _chatController = InMemoryChatController();
  final _uuid = const Uuid();

  final _currentUser = const User(
    id: 'me',
    imageSource: 'https://picsum.photos/id/65/200/200',
    name: 'Jane Doe',
  );
  final _recipient = const User(
    id: 'recipient',
    imageSource: 'https://picsum.photos/id/265/200/200',
    name: 'John Doe',
  );
  final _systemUser = const User(id: 'system');

  bool _isTyping = false;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Local')),
      body: Chat(
        backgroundColor: Colors.transparent,
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedList(
              itemBuilder: itemBuilder,
              insertAnimationDurationResolver: (message) {
                if (message is SystemMessage) return Duration.zero;
                return null;
              },
            );
          },
          customMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? ChatColors.dark().surfaceContainer
                      : ChatColors.light().surfaceContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: IsTypingIndicator(),
              ),
          imageMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatImageMessage(message: message, index: index),
          systemMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatSystemMessage(message: message, index: index),
          composerBuilder: (context) => Composer(
            topWidget: ComposerActionBar(
              buttons: [
                ComposerActionButton(
                  icon: Icons.type_specimen,
                  title: 'Toggle typing',
                  onPressed: () => _toggleTyping(),
                ),
                ComposerActionButton(
                  icon: Icons.shuffle,
                  title: 'Send random',
                  onPressed: () => _addItem(null),
                ),
                ComposerActionButton(
                  icon: Icons.delete_sweep,
                  title: 'Clear all',
                  onPressed: () => _chatController.setMessages([]),
                  destructive: true,
                ),
              ],
            ),
          ),
          linkPreviewBuilder: (context, message, isSentByMe) {
            // It's up to you to (optionally) implement the logic to avoid every
            // message to refetch the preview data
            //
            // For example, you can use a metadata to indicate if the preview
            // was already fetched (or null).
            //
            // Additionally, you can cache the data to avoid re-fetching across app restarts.
            return LinkPreview(
              text: message.text,
              linkPreviewData: message.linkPreviewData,
              onLinkPreviewDataFetched: (linkPreviewData) {
                _chatController.updateMessage(
                  message,
                  message.copyWith(linkPreviewData: linkPreviewData),
                );
              },
            );
          },
          textMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatTextMessage(message: message, index: index),
          fileMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatFileMessage(message: message, index: index),
          chatMessageBuilder:
              (
                context,
                message,
                index,
                animation,
                child, {
                bool? isRemoved,
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) {
                final isSystemMessage = message.authorId == 'system';
                final isFirstInGroup = groupStatus?.isFirst ?? true;
                final isLastInGroup = groupStatus?.isLast ?? true;
                final shouldShowAvatar =
                    !isSystemMessage && isLastInGroup && isRemoved != true;
                final isCurrentUser = message.authorId == _currentUser.id;
                final shouldShowUsername =
                    !isSystemMessage && isFirstInGroup && isRemoved != true;

                Widget? avatar;
                if (shouldShowAvatar) {
                  avatar = Padding(
                    padding: EdgeInsets.only(
                      left: isCurrentUser ? 8 : 0,
                      right: isCurrentUser ? 0 : 8,
                    ),
                    child: Avatar(userId: message.authorId),
                  );
                } else if (!isSystemMessage) {
                  avatar = const SizedBox(width: 40);
                }

                return ChatMessage(
                  message: message,
                  index: index,
                  animation: animation,
                  isRemoved: isRemoved,
                  groupStatus: groupStatus,
                  topWidget: shouldShowUsername
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: 4,
                            left: isCurrentUser ? 0 : 48,
                            right: isCurrentUser ? 48 : 0,
                          ),
                          child: Username(userId: message.authorId),
                        )
                      : null,
                  leadingWidget: !isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
                  trailingWidget: isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
                  receivedMessageScaleAnimationAlignment:
                      (message is SystemMessage)
                      ? Alignment.center
                      : Alignment.centerLeft,
                  receivedMessageAlignment: (message is SystemMessage)
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerStart,
                  horizontalPadding: (message is SystemMessage) ? 0 : 8,
                  child: child,
                );
              },
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? ChatColors.dark().surface
              : ChatColors.light().surface,
          image: DecorationImage(
            image: AssetImage('assets/pattern.png'),
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              theme.brightness == Brightness.dark
                  ? ChatColors.dark().surfaceContainerLow
                  : ChatColors.light().surfaceContainerLow,
              BlendMode.srcIn,
            ),
          ),
        ),
        onAttachmentTap: _handleAttachmentTap,
        onMessageLongPress: _handleMessageLongPress,
        onMessageSend: _addItem,
        resolveUser: (id) => Future.value(switch (id) {
          'me' => _currentUser,
          'recipient' => _recipient,
          'system' => _systemUser,
          _ => null,
        }),
        theme: theme.brightness == Brightness.dark
            ? ChatTheme.dark()
            : ChatTheme.light(),
      ),
    );
  }

  void _handleMessageLongPress(
    BuildContext context,
    Message message, {
    required int index,
    required LongPressStartDetails details,
  }) async {
    // Skip showing menu for system messages
    if (message.authorId == 'system') return;

    // Calculate position for the menu
    final position = details.globalPosition;

    // Create a Rect for the menu position (small area around tap point)
    final menuRect = Rect.fromCenter(
      center: position,
      width: 0, // Width and height of 0 means show exactly at the point
      height: 0,
    );

    final items = [
      if (message is TextMessage)
        PullDownMenuItem(
          title: 'Copy',
          icon: CupertinoIcons.doc_on_doc,
          onTap: () {
            _copyMessage(message);
          },
        ),
      PullDownMenuItem(
        title: 'Delete',
        icon: CupertinoIcons.delete,
        isDestructive: true,
        onTap: () {
          _removeItem(message);
        },
      ),
    ];

    await showPullDownMenu(context: context, position: menuRect, items: items);
  }

  void _copyMessage(TextMessage message) async {
    await Clipboard.setData(ClipboardData(text: message.text));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied: ${message.text}')));
  }

  void _addItem(String? text) async {
    final randomUser = Random().nextInt(2) == 0 ? _currentUser : _recipient;

    final message = await createMessage(
      randomUser.id,
      widget.dio,
      localOnly: true,
      text: text,
    );

    if (mounted) {
      if (_isTyping) {
        await _toggleTyping();
        await Future.delayed(const Duration(milliseconds: 250));
      }
      if (_chatController.messages.isEmpty) {
        final now = DateTime.now().toUtc();
        final formattedDate = DateFormat(
          'd MMMM yyyy, HH:mm',
        ).format(now.toLocal());
        await _chatController.insertMessage(
          SystemMessage(
            id: _uuid.v4(),
            authorId: _systemUser.id,
            text: formattedDate,
            createdAt: DateTime.now().toUtc().subtract(
              const Duration(seconds: 1),
            ),
          ),
        );
      }
      await _chatController.insertMessage(message);
    }
  }

  Future<void> _toggleTyping() async {
    if (!_isTyping) {
      await _chatController.insertMessage(
        CustomMessage(
          id: _uuid.v4(),
          authorId: _systemUser.id,
          metadata: {'type': 'typing'},
          createdAt: DateTime.now().toUtc(),
        ),
      );
      _isTyping = true;
    } else {
      try {
        final typingMessage = _chatController.messages.firstWhere(
          (message) => message.metadata?['type'] == 'typing',
        );

        await _chatController.removeMessage(typingMessage);
        _isTyping = false;
      } catch (e) {
        _isTyping = false;
        await _toggleTyping();
      }
    }
  }

  void _removeItem(Message item) async {
    await _chatController.removeMessage(item);
    if (_chatController.messages.length == 1) {
      await _chatController.removeMessage(_chatController.messages[0]);
    }
  }

  void _handleAttachmentTap() async {
    await showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Image'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) {
                    final imageMessage = ImageMessage(
                      id: _uuid.v4(),
                      authorId: _currentUser.id,
                      createdAt: DateTime.now().toUtc(),
                      sentAt: DateTime.now().toUtc(),
                      source: image.path,
                    );

                    await _chatController.insertMessage(imageMessage);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_present),
                title: const Text('File'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await FilePicker.platform.pickFiles(
                    withData: false,
                    withReadStream: false,
                  );

                  if (result != null && result.files.isNotEmpty) {
                    final file = result.files.first;
                    final filePath = file.path!;
                    final fileName = file.name;
                    final fileSize = file.size;

                    // Create a proper file message
                    final fileMessage = FileMessage(
                      id: _uuid.v4(),
                      authorId: _currentUser.id,
                      createdAt: DateTime.now().toUtc(),
                      sentAt: DateTime.now().toUtc(),
                      source: filePath,
                      name: fileName,
                      size: fileSize,
                      mimeType: file.extension != null
                          ? 'application/${file.extension}'
                          : null,
                    );

                    await _chatController.insertMessage(fileMessage);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
