import 'dart:ui';

import 'package:flutter_chat_core/flutter_chat_core.dart';

typedef ResolveUserCallback = Future<User?> Function(String id);
typedef OnMessageTapCallback = void Function(Message message);
typedef OnMessageSendCallback = void Function(String text);
typedef OnAttachmentTapCallback = VoidCallback;
