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
  final bool? isRemoved;

  const ChatMessageInternal({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
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
      final chatController =
          Provider.of<ChatController>(context, listen: false);
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

    return builders.chatMessageBuilder?.call(
          context,
          _updatedMessage,
          widget.index,
          widget.animation,
          child,
        ) ??
        ChatMessage(
          message: _updatedMessage,
          index: widget.index,
          animation: widget.animation,
          isRemoved: widget.isRemoved,
          child: child,
        );
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
        return builders.unsupportedMessageBuilder
                ?.call(context, message, index) ??
            const Text(
              'This message is not supported. Please update your app.',
            );
    }
  }
}
