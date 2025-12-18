import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../simple_text_message.dart';
import 'chat_message.dart';

/// Internal widget responsible for building and updating a single chat message item.
///
/// It listens to the [ChatController.operationsStream] for updates to the specific
/// message it represents and rebuilds accordingly.
/// It also resolves the appropriate message builder based on the message type
/// and determines the message's grouping status.
class ChatMessageInternal extends StatefulWidget {
  /// The message data to display.
  final Message message;

  /// The index of the message in the overall list.
  final int index;

  /// Animation provided by the parent [SliverAnimatedList].
  final Animation<double> animation;

  /// The mode to use for grouping messages.
  final MessagesGroupingMode? messagesGroupingMode;

  /// Timeout in seconds for grouping messages from the same author.
  /// Only used when [messagesGroupingMode] is [MessagesGroupingMode.timeDifference].
  final int? messageGroupingTimeoutInSeconds;

  /// Flag indicating if this item is being animated out (removed).
  final bool? isRemoved;

  /// Creates an internal chat message widget.
  const ChatMessageInternal({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
    this.messagesGroupingMode = MessagesGroupingMode.timeDifference,
    this.messageGroupingTimeoutInSeconds,
    this.isRemoved,
  });

  @override
  State<ChatMessageInternal> createState() => _ChatMessageInternalState();
}

/// State for [ChatMessageInternal].
class _ChatMessageInternalState extends State<ChatMessageInternal> {
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
    final builders = context.read<Builders>();
    final isSentByMe = context.read<UserID>() == _updatedMessage.authorId;

    final groupStatus = _resolveGroupStatus(context);

    final child = _buildMessage(
      context,
      builders,
      _updatedMessage,
      widget.index,
      isSentByMe: isSentByMe,
      groupStatus: groupStatus,
    );

    return builders.chatMessageBuilder?.call(
          context,
          _updatedMessage,
          widget.index,
          widget.animation,
          child,
          isRemoved: widget.isRemoved,
          isSentByMe: isSentByMe,
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

      // Get adjacent messages if they exist
      final nextMessage = index < messages.length - 1
          ? messages[index + 1]
          : null;
      final previousMessage = index > 0 ? messages[index - 1] : null;

      // Get dates
      final now = DateTime.now();
      final currentMessageDate = currentMessage.resolvedTime ?? now;
      final nextMessageDate = nextMessage?.resolvedTime ?? now;
      final previousMessageDate = previousMessage?.resolvedTime ?? now;

      // Check if message is part of a group with next message
      final isGroupedWithNext =
          nextMessage != null &&
          nextMessage.authorId == currentMessage.authorId &&
          _shouldGroupMessages(
            currentMessageDate,
            nextMessageDate,
            widget.messagesGroupingMode ?? MessagesGroupingMode.timeDifference,
            widget.messageGroupingTimeoutInSeconds ?? 300,
          );

      // Check if message is part of a group with previous message
      final isGroupedWithPrevious =
          previousMessage != null &&
          previousMessage.authorId == currentMessage.authorId &&
          _shouldGroupMessages(
            previousMessageDate,
            currentMessageDate,
            widget.messagesGroupingMode ?? MessagesGroupingMode.timeDifference,
            widget.messageGroupingTimeoutInSeconds ?? 300,
          );

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
}

/// Determines if two messages should be grouped together based on the grouping mode.
///
/// [earlierDate] should be the timestamp of the earlier message.
/// [laterDate] should be the timestamp of the later message.
bool _shouldGroupMessages(
  DateTime earlierDate,
  DateTime laterDate,
  MessagesGroupingMode groupingMode,
  int timeoutInSeconds,
) {
  switch (groupingMode) {
    case MessagesGroupingMode.timeDifference:
      return _isWithinTimeThreshold(earlierDate, laterDate, timeoutInSeconds);
    case MessagesGroupingMode.sameMinute:
      return _isSameMinute(earlierDate, laterDate);
    case MessagesGroupingMode.sameHour:
      return _isSameHour(earlierDate, laterDate);
    case MessagesGroupingMode.sameDay:
      return _isSameDay(earlierDate, laterDate);
  }
}

/// Checks if two timestamps are within the specified time threshold.
bool _isWithinTimeThreshold(
  DateTime earlierDate,
  DateTime laterDate,
  int timeoutInSeconds,
) {
  return laterDate.difference(earlierDate).inSeconds < timeoutInSeconds;
}

/// Checks if two timestamps are in the same minute.
bool _isSameMinute(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day &&
      date1.hour == date2.hour &&
      date1.minute == date2.minute;
}

/// Checks if two timestamps are in the same hour.
bool _isSameHour(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day &&
      date1.hour == date2.hour;
}

/// Checks if two timestamps are on the same day.
bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
