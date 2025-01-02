import 'package:flutter/widgets.dart';

import '../models/message.dart';

typedef ChatItem = Widget Function(
  BuildContext context,
  Message message,
  int index,
  Animation<double> animation, {
  bool? isRemoved,
});
