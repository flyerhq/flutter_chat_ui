import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../simple_text_message.dart';
import 'chat_message.dart';

class ChatMessageInternal extends StatefulWidget {
  final Message message;
  final int index;
  final Animation<double> animation;
  final int? messageGroupingTimeoutInSeconds;
  final bool? isRemoved;

  const ChatMessageInternal({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
    this.messageGroupingTimeoutInSeconds,
    this.isRemoved,
  });

  @override
  State<ChatMessageInternal> createState() => ChatMessageInternalState();
}

class ChatMessageInternalState extends State<ChatMessageInternal> {
  late StreamSubscription<ChatOperation>? _operationsSubscription;
  late Message _updatedMessage;

  @override
  void initState() {
    super.initState();

    _updatedMessage = widget.message;

    if (widget.isRemoved == true) {
      _operationsSubscription = null;
    } else {
      final chatController = context.read<ChatController>();
      _operationsSubscription = chatController.operationsStream.listen((event) {
        switch (event.type) {
          case ChatOperationType.update:
            assert(
              event.oldMessage != null,
              'Old message must be provided when updating a message.',
            );
            assert(
              event.message != null,
              'Message must be provided when updating a message.',
            );
            if (_updatedMessage.id == event.oldMessage!.id) {
              setState(() {
                _updatedMessage = event.message!;
              });
            }
          default:
            break;
        }
      });
    }
  }

  @override
  void dispose() {
    _operationsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final builders = context.watch<Builders>();
    final child = _buildMessage(
      context,
      builders,
      _updatedMessage,
      widget.index,
    );

    final groupStatus = _resolveGroupStatus(context);

    return builders.chatMessageBuilder?.call(
          context,
          _updatedMessage,
          widget.index,
          widget.animation,
          child,
          isRemoved: widget.isRemoved,
          groupStatus: groupStatus,
        ) ??
        ChatMessage(
          message: _updatedMessage,
          index: widget.index,
          animation: widget.animation,
          isRemoved: widget.isRemoved,
          groupStatus: groupStatus,
          child: child,
        );
  }

  MessageGroupStatus? _resolveGroupStatus(BuildContext context) {
    try {
      final chatController = context.read<ChatController>();
      final messages = chatController.messages;
      final index = widget.index;
      final currentMessage = _updatedMessage;
      final timeoutInSeconds = widget.messageGroupingTimeoutInSeconds ?? 300;

      // Get adjacent messages if they exist
      final nextMessage =
          index < messages.length - 1 ? messages[index + 1] : null;
      final previousMessage = index > 0 ? messages[index - 1] : null;

      // Check if message is part of a group with next message
      final isGroupedWithNext =
          nextMessage != null &&
          nextMessage.authorId == currentMessage.authorId &&
          nextMessage.createdAt.difference(currentMessage.createdAt).inSeconds <
              timeoutInSeconds;

      // Check if message is part of a group with previous message
      final isGroupedWithPrevious =
          previousMessage != null &&
          previousMessage.authorId == currentMessage.authorId &&
          currentMessage.createdAt
                  .difference(previousMessage.createdAt)
                  .inSeconds <
              timeoutInSeconds;

      // If not grouped with either message, return null
      if (!isGroupedWithNext && !isGroupedWithPrevious) {
        return null;
      }

      return MessageGroupStatus(
        isFirst: !isGroupedWithPrevious,
        isLast: !isGroupedWithNext,
        isMiddle: isGroupedWithNext && isGroupedWithPrevious,
      );
    } catch (e) {
      return null;
    }
  }

  Widget _buildMessage(
    BuildContext context,
    Builders builders,
    Message message,
    int index,
  ) {
    switch (message) {
      case TextMessage():
        return builders.textMessageBuilder?.call(context, message, index) ??
            SimpleTextMessage(message: message, index: index);
      case ImageMessage():
        final result =
            builders.imageMessageBuilder?.call(context, message, index) ??
            const SizedBox.shrink();
        assert(
          !(result is SizedBox && result.width == 0 && result.height == 0),
          'You are trying to display an image message but you have not provided an imageMessageBuilder. '
          'Use builders parameter of Chat widget to provide an image message widget. '
          'If you want to use default image message widget, install flyer_chat_image_message package and use FlyerChatImageMessage widget.',
        );
        return result;
      case CustomMessage():
        return builders.customMessageBuilder?.call(context, message, index) ??
            const SizedBox.shrink();
      case UnsupportedMessage():
        return builders.unsupportedMessageBuilder?.call(
              context,
              message,
              index,
            ) ??
            const Text(
              'This message is not supported. Please update your app.',
            );
    }
  }
}
