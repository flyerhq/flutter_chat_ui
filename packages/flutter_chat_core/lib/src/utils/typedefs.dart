import 'package:flutter/widgets.dart';

import '../models/message.dart';
import '../models/user.dart';

/// Re-export of [DateFormat] from the `intl` package for convenience.
export 'package:intl/intl.dart' show DateFormat;

/// Alias for a message ID (String).
typedef MessageID = String;

/// Alias for a user ID (String).
typedef UserID = String;

/// Represents the delivery status of a message.
enum MessageStatus { delivered, error, seen, sending, sent }

/// Defines the position of the timestamp and status indicator relative to the message content.
enum TimeAndStatusPosition { start, end, inline }

/// Defines the mode for grouping messages. Default is [timeDifference].
enum MessagesGroupingMode { timeDifference, sameMinute, sameHour, sameDay }

/// Signature for a callback function that resolves a [User] object from a [UserID].
typedef ResolveUserCallback = Future<User?> Function(UserID id);

/// Signature for a function that builds a single chat list item widget.
/// Used by [ChatAnimatedList] and [ChatAnimatedListReversed].
typedef ChatItem =
    Widget Function(
      BuildContext context,
      Message message,
      int index,
      Animation<double> animation, {
      MessagesGroupingMode? messagesGroupingMode,
      int? messageGroupingTimeoutInSeconds,
      bool? isRemoved,
    });
