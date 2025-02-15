import 'package:flutter/widgets.dart';

import '../models/message.dart';

typedef ChatItem = Widget Function(
  BuildContext context,
  Message message,
  int index,
  Animation<double> animation, {
  int? messageGroupingTimeoutInSeconds,
  bool? isRemoved,
});
