import 'package:flutter/widgets.dart';

import '../models/message.dart';
import '../models/user.dart';

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
