import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import './models/date_header.dart';
import './models/message_spacer.dart';
import './models/preview_image.dart';

/// Returns text representation of a provided bytes value (e.g. 1kB, 1GB)
String formatBytes(int size, [int fractionDigits = 2]) {
  if (size <= 0) return '0 B';
  final multiple = (log(size) / log(1024)).floor();
  return (size / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
      ' ' +
      ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
}

/// Returns user name as joined firstName and lastName
String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

/// Returns formatted date used as a divider between different days in the
/// chat history
String getVerboseDateTimeRepresentation(DateTime dateTime, String? locale) {
  final now = DateTime.now();
  final localDateTime = dateTime.toLocal();

  if (localDateTime.day == now.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return DateFormat.Hm(locale).format(dateTime);
  }

  return '${DateFormat.MMMd(locale).format(dateTime)}, ${DateFormat.Hm(locale).format(dateTime)}';
}

/// Parses provided messages to chat messages (with headers and spacers) and
/// returns them with a gallery
List<Object> calculateChatMessages(
  List<types.Message> messages,
  types.User user, {
  String? dateLocale,
  required bool showUserNames,
}) {
  final chatMessages = <Object>[];
  final gallery = <PreviewImage>[];

  var shouldShowName = false;

  for (var i = messages.length - 1; i >= 0; i--) {
    final isFirst = i == messages.length - 1;
    final isLast = i == 0;
    final message = messages[i];
    final messageHasTimestamp = message.timestamp != null;
    final nextMessage = isLast ? null : messages[i - 1];
    final nextMessageHasTimestamp = nextMessage?.timestamp != null;
    final nextMessageSameAuthor = message.author.id == nextMessage?.author.id;

    var nextMessageDateThreshold = false;
    var nextMessageDifferentDay = false;
    var nextMessageInGroup = false;
    var showName = false;

    if (showUserNames) {
      final previousMessage = isFirst ? null : messages[i + 1];

      final isFirstInGroup = (message.author.id != user.id) &&
          ((message.author.id != previousMessage?.author.id) ||
              (message.timestamp != null &&
                  previousMessage?.timestamp != null &&
                  message.timestamp! - previousMessage!.timestamp! > 60000));

      if (isFirstInGroup) {
        shouldShowName = false;
        if (message.type == types.MessageType.text) {
          showName = true;
        } else {
          shouldShowName = true;
        }
      }

      if (message.type == types.MessageType.text && shouldShowName) {
        showName = true;
        shouldShowName = false;
      }
    }

    if (messageHasTimestamp && nextMessageHasTimestamp) {
      nextMessageDateThreshold =
          nextMessage!.timestamp! - message.timestamp! >= 900000;

      nextMessageDifferentDay =
          DateTime.fromMillisecondsSinceEpoch(message.timestamp!).day !=
              DateTime.fromMillisecondsSinceEpoch(nextMessage.timestamp!).day;

      nextMessageInGroup = nextMessageSameAuthor &&
          nextMessage.timestamp! - message.timestamp! <= 60000;
    }

    if (isFirst && messageHasTimestamp) {
      chatMessages.insert(
        0,
        DateHeader(
          text: getVerboseDateTimeRepresentation(
            DateTime.fromMillisecondsSinceEpoch(message.timestamp!),
            dateLocale,
          ),
        ),
      );
    }

    chatMessages.insert(0, {
      'message': message,
      'nextMessageInGroup': nextMessageInGroup,
      'showName': message.author.id != user.id &&
          showUserNames &&
          showName &&
          getUserName(message.author).isNotEmpty,
    });

    if (!nextMessageInGroup) {
      chatMessages.insert(
        0,
        MessageSpacer(
          height: 12,
          id: message.id,
        ),
      );
    }

    if (nextMessageDifferentDay || nextMessageDateThreshold) {
      chatMessages.insert(
        0,
        DateHeader(
          text: getVerboseDateTimeRepresentation(
            DateTime.fromMillisecondsSinceEpoch(nextMessage!.timestamp!),
            dateLocale,
          ),
        ),
      );
    }

    if (message is types.ImageMessage) {
      if (kIsWeb) {
        if (message.uri.startsWith('http')) {
          gallery.add(PreviewImage(id: message.id, uri: message.uri));
        }
      } else {
        gallery.add(PreviewImage(id: message.id, uri: message.uri));
      }
    }
  }

  return [chatMessages, gallery];
}
