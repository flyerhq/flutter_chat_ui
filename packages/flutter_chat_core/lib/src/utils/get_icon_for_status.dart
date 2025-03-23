import 'package:flutter/material.dart';

import '../utils/typedefs.dart' show MessageStatus;

IconData getIconForStatus(MessageStatus status) {
  switch (status) {
    case MessageStatus.delivered:
      return Icons.check;
    case MessageStatus.error:
      return Icons.error_outline;
    case MessageStatus.seen:
      return Icons.done_all;
    case MessageStatus.sending:
      return Icons.cloud_upload_outlined;
    case MessageStatus.sent:
      return Icons.check;
  }
}
