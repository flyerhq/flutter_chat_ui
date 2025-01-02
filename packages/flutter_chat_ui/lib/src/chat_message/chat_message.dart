import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../utils/typedefs.dart';

class ChatMessage extends StatelessWidget {
  static const EdgeInsetsGeometry _sentinelValue = EdgeInsets.zero;

  final Message message;
  final int index;
  final Animation<double> animation;
  final Widget child;
  final Alignment sentMessageScaleAnimationAlignment;
  final Alignment receivedMessageScaleAnimationAlignment;
  final AlignmentGeometry sentMessageAlignment;
  final AlignmentGeometry receivedMessageAlignment;
  final Alignment? scaleAnimationAlignment;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Duration? paddingChangeAnimationDuration;
  final bool? isRemoved;
  final int? messageGroupingTimeoutInSeconds;

  const ChatMessage({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
    required this.child,
    this.sentMessageScaleAnimationAlignment = Alignment.centerRight,
    this.receivedMessageScaleAnimationAlignment = Alignment.centerLeft,
    this.sentMessageAlignment = AlignmentDirectional.centerEnd,
    this.receivedMessageAlignment = AlignmentDirectional.centerStart,
    this.scaleAnimationAlignment,
    this.alignment,
    this.padding = _sentinelValue,
    this.paddingChangeAnimationDuration = const Duration(milliseconds: 250),
    this.isRemoved,
    this.messageGroupingTimeoutInSeconds = 300,
  });

  @override
  Widget build(BuildContext context) {
    final onMessageTap = context.read<OnMessageTapCallback?>();
    final isSentByMe = context.watch<User>().id == message.author.id;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    final resolvedPadding =
        padding == _sentinelValue ? _calculateDefaultPadding(context) : padding;

    return GestureDetector(
      onTap: () => onMessageTap?.call(message),
      child: FadeTransition(
        opacity: curvedAnimation,
        child: SizeTransition(
          sizeFactor: curvedAnimation,
          child: ScaleTransition(
            scale: curvedAnimation,
            alignment: scaleAnimationAlignment ??
                (isSentByMe
                    ? sentMessageScaleAnimationAlignment
                    : receivedMessageScaleAnimationAlignment),
            child: Align(
              alignment: alignment ??
                  (isSentByMe
                      ? sentMessageAlignment
                      : receivedMessageAlignment),
              child: padding != null
                  ? paddingChangeAnimationDuration != null
                      ? AnimatedPadding(
                          padding: resolvedPadding!,
                          duration: paddingChangeAnimationDuration!,
                          curve: Curves.linearToEaseOut,
                          child: child,
                        )
                      : Padding(padding: resolvedPadding!, child: child)
                  : child,
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _calculateDefaultPadding(BuildContext context) {
    if (message is TextMessage &&
        (message as TextMessage).isOnlyEmoji == true) {
      return EdgeInsets.zero;
    }

    if (index == 0) {
      return const EdgeInsets.symmetric(horizontal: 8);
    }

    try {
      final chatController = context.read<ChatController>();
      final previousMessage = chatController.messages[index - 1];

      final isGrouped = previousMessage.author.id == message.author.id &&
          message.createdAt.difference(previousMessage.createdAt).inSeconds <
              (messageGroupingTimeoutInSeconds ?? 0);

      return isGrouped || isRemoved == true
          ? const EdgeInsets.fromLTRB(8, 2, 8, 0)
          : const EdgeInsets.fromLTRB(8, 12, 8, 0);
    } catch (e) {
      return const EdgeInsets.fromLTRB(8, 2, 8, 0);
    }
  }
}
