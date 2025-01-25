import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../utils/typedefs.dart';

class ChatMessage extends StatelessWidget {
  static const EdgeInsetsGeometry _sentinelPadding = EdgeInsets.zero;

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
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? verticalGroupedPadding;

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
    this.padding = _sentinelPadding,
    this.paddingChangeAnimationDuration = const Duration(milliseconds: 250),
    this.isRemoved,
    this.messageGroupingTimeoutInSeconds = 300,
    this.horizontalPadding = 8,
    this.verticalPadding = 12,
    this.verticalGroupedPadding = 2,
  });

  @override
  Widget build(BuildContext context) {
    final onMessageTap = context.read<OnMessageTapCallback?>();
    final isSentByMe = context.watch<String>() == message.authorId;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    final resolvedPadding =
        padding == _sentinelPadding ? _resolveDefaultPadding(context) : padding;

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

  EdgeInsetsGeometry _resolveDefaultPadding(BuildContext context) {
    if (message is TextMessage &&
        (message as TextMessage).isOnlyEmoji == true) {
      return EdgeInsets.zero;
    }

    if (index == 0) {
      return EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0);
    }

    try {
      final chatController = context.read<ChatController>();
      final previousMessage = chatController.messages[index - 1];

      final isGrouped = previousMessage.authorId == message.authorId &&
          message.createdAt.difference(previousMessage.createdAt).inSeconds <
              (messageGroupingTimeoutInSeconds ?? 0);

      return isGrouped || isRemoved == true
          ? EdgeInsets.fromLTRB(
              horizontalPadding ?? 0,
              verticalGroupedPadding ?? 0,
              horizontalPadding ?? 0,
              0,
            )
          : EdgeInsets.fromLTRB(
              horizontalPadding ?? 0,
              verticalPadding ?? 0,
              horizontalPadding ?? 0,
              0,
            );
    } catch (e) {
      return EdgeInsets.fromLTRB(
        horizontalPadding ?? 0,
        verticalPadding ?? 0,
        horizontalPadding ?? 0,
        0,
      );
    }
  }
}
