import 'package:flutter/widgets.dart';

import '../models/message.dart';
import '../models/user.dart';

export 'package:intl/intl.dart' show DateFormat;

typedef MessageID = String;
typedef UserID = String;

enum MessageStatus { delivered, error, seen, sending, sent }

enum TimeAndStatusPosition { start, end, inline }

typedef ResolveUserCallback = Future<User?> Function(UserID id);

typedef ChatItem =
    Widget Function(
      BuildContext context,
      Message message,
      int index,
      Animation<double> animation, {
      int? messageGroupingTimeoutInSeconds,
      bool? isRemoved,
    });
