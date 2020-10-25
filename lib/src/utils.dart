import 'dart:math';
import 'package:flutter_chat_ui/src/models/message.dart';

String formatBytes(int size, [int fractionDigits = 2]) {
  if (size <= 0) return '0 B';
  int multiple = (log(size) / log(1024)).floor();
  return (size / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
      ' ' +
      ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
}

Status getStatusFromString(String stringStatus) {
  for (Status status in Status.values) {
    if (status.toString() == 'Status.$stringStatus') {
      return status;
    }
  }

  return null;
}
