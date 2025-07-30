import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

import '../simple_text_message.dart';

Widget buildMessageContent(
    BuildContext context,
    Builders builders,
    Message message,
    int index, {
    required bool isSentByMe,
    MessageGroupStatus? groupStatus,
  }) {
    switch (message) {
      case TextMessage():
        return builders.textMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            SimpleTextMessage(message: message, index: index);
      case TextStreamMessage():
        return builders.textStreamMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case ImageMessage():
        final result =
            builders.imageMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
        assert(
          !(result is SizedBox && result.width == 0 && result.height == 0),
          'You are trying to display an image message but you have not provided an imageMessageBuilder. '
          'Use builders parameter of Chat widget to provide an image message widget. '
          'If you want to use default image message widget, install flyer_chat_image_message package and use FlyerChatImageMessage widget.',
        );
        return result;
      case FileMessage():
        return builders.fileMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case VideoMessage():
        return builders.videoMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case AudioMessage():
        return builders.audioMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case SystemMessage():
        return builders.systemMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case CustomMessage():
        return builders.customMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const SizedBox.shrink();
      case UnsupportedMessage():
        return builders.unsupportedMessageBuilder?.call(
              context,
              message,
              index,
              isSentByMe: isSentByMe,
              groupStatus: groupStatus,
            ) ??
            const Text(
              'This message is not supported. Please update your app.',
            );
    }
  }