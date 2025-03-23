import 'package:flutter/widgets.dart';

import '../models/message.dart';
import '../models/user.dart';

export 'package:intl/intl.dart' show DateFormat;

enum MessageStatus { delivered, error, seen, sending, sent }

enum TimeAndStatusPosition { start, end, inline }

typedef ResolveUserCallback = Future<User?> Function(String id);

typedef ChatItem =
    Widget Function(
      BuildContext context,
      Message message,
      int index,
      Animation<double> animation, {
      int? messageGroupingTimeoutInSeconds,
      bool? isRemoved,
    });
