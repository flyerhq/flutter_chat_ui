import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../utils/typedefs.dart';

/// Default wrapper widget for a single chat message item.
///
/// Handles layout (alignment based on sender), animation (fade, scale, size),
/// padding (adjusting for grouped messages), and tap/long-press gestures.
/// It arranges the core message [child] with optional surrounding widgets
/// ([leadingWidget], [trailingWidget], [topWidget], [bottomWidget], [headerWidget]).
class ChatMessage extends StatelessWidget {
  /// The message data being displayed.
  final Message message;

  /// The index of the message in the list.
  final int index;

  /// Animation provided by the parent [SliverAnimatedList].
  final Animation<double> animation;

  /// The core widget representing the message content (e.g., text bubble, image).
  final Widget child;

  /// Widget to display to the left/start of the message content.
  final Widget? leadingWidget;

  /// Widget to display to the right/end of the message content.
  final Widget? trailingWidget;

  /// Widget to display above the main message row.
  final Widget? topWidget;

  /// Widget to display below the main message row.
  final Widget? bottomWidget;

  /// Widget to display above the entire message structure (including potential topWidget).
  final Widget? headerWidget;

  /// Alignment for the scale animation origin for sent messages.
  final Alignment sentMessageScaleAnimationAlignment;

  /// Alignment for the scale animation origin for received messages.
  final Alignment receivedMessageScaleAnimationAlignment;

  /// Alignment for the message container for sent messages.
  final AlignmentGeometry sentMessageAlignment;

  /// Alignment for the message container for received messages.
  final AlignmentGeometry receivedMessageAlignment;

  /// Cross-axis alignment for the main column for sent messages.
  final CrossAxisAlignment sentMessageColumnAlignment;

  /// Cross-axis alignment for the main column for received messages.
  final CrossAxisAlignment receivedMessageColumnAlignment;

  /// Cross-axis alignment for the content row for sent messages.
  final CrossAxisAlignment sentMessageRowAlignment;

  /// Cross-axis alignment for the content row for received messages.
  final CrossAxisAlignment receivedMessageRowAlignment;

  /// Overrides the sender-based scale animation alignment if provided.
  final Alignment? scaleAnimationAlignment;

  /// Overrides the sender-based message container alignment if provided.
  final AlignmentGeometry? alignment;

  /// Overrides the default padding calculation if provided.
  final EdgeInsetsGeometry? padding;

  /// Duration for the animated padding change (e.g., when grouping status changes).
  final Duration? paddingChangeAnimationDuration;

  /// Flag indicating if this item is being animated out (removed).
  final bool? isRemoved;

  /// Status indicating if this message is part of a group (first, middle, last).
  final MessageGroupStatus? groupStatus;

  /// Default horizontal padding for message items.
  final double? horizontalPadding;

  /// Default vertical padding between non-grouped messages.
  final double? verticalPadding;

  /// Vertical padding between grouped messages.
  final double? verticalGroupedPadding;

  /// Creates a default chat message wrapper widget.
  const ChatMessage({
    super.key,
    required this.message,
    required this.index,
    required this.animation,
    required this.child,
    this.leadingWidget,
    this.trailingWidget,
    this.topWidget,
    this.bottomWidget,
    this.headerWidget,
    this.sentMessageScaleAnimationAlignment = Alignment.centerRight,
    this.receivedMessageScaleAnimationAlignment = Alignment.centerLeft,
    this.sentMessageAlignment = AlignmentDirectional.centerEnd,
    this.receivedMessageAlignment = AlignmentDirectional.centerStart,
    this.sentMessageColumnAlignment = CrossAxisAlignment.end,
    this.receivedMessageColumnAlignment = CrossAxisAlignment.start,
    this.sentMessageRowAlignment = CrossAxisAlignment.end,
    this.receivedMessageRowAlignment = CrossAxisAlignment.end,
    this.scaleAnimationAlignment,
    this.alignment,
    this.padding,
    this.paddingChangeAnimationDuration = const Duration(milliseconds: 250),
    this.isRemoved,
    this.groupStatus,
    this.horizontalPadding = 8,
    this.verticalPadding = 12,
    this.verticalGroupedPadding = 2,
  });

  @override
  Widget build(BuildContext context) {
    final onMessageTap = context.read<OnMessageTapCallback?>();
    final onMessageDoubleTap = context.read<OnMessageDoubleTapCallback?>();
    final onMessageLongPress = context.read<OnMessageLongPressCallback?>();
    final onMessageSecondaryTap = context
        .read<OnMessageSecondaryTapCallback?>();
    final isSentByMe = context.read<UserID>() == message.authorId;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    final resolvedPadding = padding ?? _resolveDefaultPadding(context);

    Widget messageContent = GestureDetector(
      onTapUp: onMessageTap != null
          ? (details) => onMessageTap.call(
              context,
              message,
              index: index,
              details: details,
            )
          : null,
      onDoubleTap: onMessageDoubleTap != null
          ? () => onMessageDoubleTap.call(context, message, index: index)
          : null,
      onLongPressStart: onMessageLongPress != null
          ? (details) => onMessageLongPress.call(
              context,
              message,
              index: index,
              details: details,
            )
          : null,
      onSecondaryTapUp: onMessageSecondaryTap != null
          ? (details) => onMessageSecondaryTap.call(
              context,
              message,
              index: index,
              details: details,
            )
          : null,
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
              child: _buildMessage(isSentByMe: isSentByMe),
            ),
          ),
        ),
      ),
    );

    // If no headerWidget, apply full padding to message content directly
    if (headerWidget == null) {
      if (resolvedPadding != EdgeInsetsGeometry.zero) {
        return paddingChangeAnimationDuration != null
            ? AnimatedPadding(
                padding: resolvedPadding,
                duration: paddingChangeAnimationDuration!,
                curve: Curves.linearToEaseOut,
                child: messageContent,
              )
            : Padding(padding: resolvedPadding, child: messageContent);
      }
      return messageContent;
    }

    // With headerWidget: split padding so header spans full width
    // (not affected by horizontal padding) but respects vertical spacing.
    final resolved = resolvedPadding.resolve(Directionality.of(context));
    final verticalPadding = EdgeInsets.only(
      top: resolved.top,
      bottom: resolved.bottom,
    );
    final horizontalPadding = EdgeInsets.only(
      left: resolved.left,
      right: resolved.right,
    );

    // Apply horizontal padding only to message content
    if (horizontalPadding != EdgeInsetsGeometry.zero) {
      messageContent = Padding(
        padding: horizontalPadding,
        child: messageContent,
      );
    }

    final Widget messageWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: curvedAnimation,
          child: SizeTransition(
            axisAlignment: 0,
            sizeFactor: curvedAnimation,
            child: headerWidget!,
          ),
        ),
        messageContent,
      ],
    );

    // Apply vertical padding to the entire widget for spacing
    if (verticalPadding != EdgeInsetsGeometry.zero) {
      return paddingChangeAnimationDuration != null
          ? AnimatedPadding(
              padding: verticalPadding,
              duration: paddingChangeAnimationDuration!,
              curve: Curves.linearToEaseOut,
              child: messageWidget,
            )
          : Padding(padding: verticalPadding, child: messageWidget);
    }

    return messageWidget;
  }

  Widget _buildMessage({required bool isSentByMe}) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: isSentByMe
        ? sentMessageColumnAlignment
        : receivedMessageColumnAlignment,
    children: [
      if (topWidget != null) topWidget!,
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isSentByMe
            ? sentMessageRowAlignment
            : receivedMessageRowAlignment,
        children: [
          if (leadingWidget != null) leadingWidget!,
          Flexible(child: child),
          if (trailingWidget != null) trailingWidget!,
        ],
      ),
      if (bottomWidget != null) bottomWidget!,
    ],
  );

  EdgeInsetsGeometry _resolveDefaultPadding(BuildContext context) {
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
