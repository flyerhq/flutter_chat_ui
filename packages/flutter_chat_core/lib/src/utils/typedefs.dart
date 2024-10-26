import 'package:flutter/widgets.dart';

import '../models/message.dart';

typedef ChatItem = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Message message, {
  bool? isRemoved,
});
