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
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Alignment sentMessageScaleAnimationAlignment;
  final Alignment receivedMessageScaleAnimationAlignment;
  final AlignmentGeometry sentMessageAlignment;
  final AlignmentGeometry receivedMessageAlignment;
  final Alignment? scaleAnimationAlignment;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Duration? paddingChangeAnimationDuration;
  final bool? isRemoved;
  final MessageGroupStatus? groupStatus;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? verticalGroupedPadding;

  const ChatMessage({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
    required this.child,
    this.leadingWidget,
    this.trailingWidget,
    this.sentMessageScaleAnimationAlignment = Alignment.centerRight,
    this.receivedMessageScaleAnimationAlignment = Alignment.centerLeft,
    this.sentMessageAlignment = AlignmentDirectional.centerEnd,
    this.receivedMessageAlignment = AlignmentDirectional.centerStart,
    this.scaleAnimationAlignment,
    this.alignment,
    this.padding = _sentinelPadding,
    this.paddingChangeAnimationDuration = const Duration(milliseconds: 250),
    this.isRemoved,
    this.groupStatus,
    this.horizontalPadding = 8,
    this.verticalPadding = 12,
    this.verticalGroupedPadding = 2,
  });

  Widget get messageRow => Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (leadingWidget != null) leadingWidget!,
      Flexible(child: child),
      if (trailingWidget != null) trailingWidget!,
    ],
  );

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
      onTap: () => onMessageTap?.call(message, index: index),
      child: FadeTransition(
        opacity: curvedAnimation,
        child: SizeTransition(
          sizeFactor: curvedAnimation,
          child: ScaleTransition(
            scale: curvedAnimation,
            alignment:
                scaleAnimationAlignment ??
                (isSentByMe
                    ? sentMessageScaleAnimationAlignment
                    : receivedMessageScaleAnimationAlignment),
            child: Align(
              alignment:
                  alignment ??
                  (isSentByMe
                      ? sentMessageAlignment
                      : receivedMessageAlignment),
              child:
                  padding != null
                      ? paddingChangeAnimationDuration != null
                          ? AnimatedPadding(
                            padding: resolvedPadding!,
                            duration: paddingChangeAnimationDuration!,
                            curve: Curves.linearToEaseOut,
                            child: messageRow,
                          )
                          : Padding(
                            padding: resolvedPadding!,
                            child: messageRow,
                          )
                      : messageRow,
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

    return groupStatus?.isFirst == false || isRemoved == true
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
  }
}
