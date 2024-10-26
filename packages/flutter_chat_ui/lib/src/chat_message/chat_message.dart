import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../utils/typedefs.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final Animation<double> animation;
  final Widget child;
  final Alignment sentMessageScaleAnimationAlignment;
  final Alignment receivedMessageScaleAnimationAlignment;
  final AlignmentGeometry sentMessageAlignment;
  final AlignmentGeometry receivedMessageAlignment;
  final EdgeInsetsGeometry padding;

  const ChatMessage({
    super.key,
    required this.message,
    required this.animation,
    required this.child,
    this.sentMessageScaleAnimationAlignment = Alignment.centerRight,
    this.receivedMessageScaleAnimationAlignment = Alignment.centerLeft,
    this.sentMessageAlignment = AlignmentDirectional.centerEnd,
    this.receivedMessageAlignment = AlignmentDirectional.centerStart,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
  });

  @override
  Widget build(BuildContext context) {
    final onMessageTap = context.read<OnMessageTapCallback?>();
    final isSentByMe = context.watch<User>().id == message.author.id;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    return GestureDetector(
      onTap: () => onMessageTap?.call(message),
      child: FadeTransition(
        opacity: curvedAnimation,
        child: SizeTransition(
          sizeFactor: curvedAnimation,
          child: ScaleTransition(
            scale: curvedAnimation,
            alignment: isSentByMe
                ? sentMessageScaleAnimationAlignment
                : receivedMessageScaleAnimationAlignment,
            child: Align(
              alignment:
                  isSentByMe ? sentMessageAlignment : receivedMessageAlignment,
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
