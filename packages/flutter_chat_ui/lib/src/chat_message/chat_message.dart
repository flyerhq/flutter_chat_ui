import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyer_chat_reactions/flyer_chat_reactions.dart';
import 'package:provider/provider.dart' as provider;

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
    final isSentByMe = context.read<UserID>() == message.authorId;

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );

    final resolvedPadding = padding ?? _resolveDefaultPadding(context);

    final Widget messageWidget = Hero(
      tag: message.id,
      // During transition we are in a Third context, we could also pass the providers here
      // Or maybe just use a colored box (resolving the theme here)
      flightShuttleBuilder:
          (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) => ColoredBox(
            color: Colors.red,
            child: SizedBox(height: 100, width: 100),
          ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (headerWidget != null)
            FadeTransition(
              opacity: curvedAnimation,
              child: SizeTransition(
                axisAlignment: 0,
                sizeFactor: curvedAnimation,
                child: headerWidget!,
              ),
            ),
          GestureDetector(
            onTapUp:
                (details) => onMessageTap?.call(
                  context,
                  message,
                  index: index,
                  details: details,
                ),
            // onLongPressStart:
            //     (details) => onMessageLongPress?.call(
            //       message,
            //       index: index,
            //       details: details,
            //     ),
            onLongPress: () {
              final theme = context.read<ChatTheme>();
              final builder = context.read<Builders>();
              final user = context.read<UserID>();
              final timeFormat = context.read<DateFormat>();

              Navigator.of(context).push(
                HeroDialogRoute(
                  // The HeroRoute (and herotransitoon^hero)
                  builder: (context) {
                    // We have to pass the necessary providers to the reactions dialog
                    // This is from py PoV prone to error since me need to be sure to pass all the providers
                    // the widget in the new tree might need (should be only SimpletextMessage and FlyerTextMessage)
                    return ProviderScope(
                      child: provider.MultiProvider(
                        providers: [
                          provider.Provider.value(value: theme),
                          provider.Provider.value(value: builder),
                          provider.Provider.value(value: user),
                          provider.Provider.value(value: timeFormat),
                        ],
                        child: ReactionsDialogWidget(
                          id: message.id,
                          messageWidget: ChatMessageWidget(
                            message: message,
                            isSentByMe: isSentByMe,
                            showReactions: false,
                            child: child,
                          ),
                          onReactionTap: (reaction) {
                            print('reaction: $reaction');

                            if (reaction == '➕') {
                              // show emoji picker container
                            } else {
                              // add reaction to message
                            }
                          },
                          onContextMenuTap: (menuItem) {
                            print('menu item: $menuItem');
                            // handle context menu item
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
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
                    child: ChatMessageWidget(
                      message: message,
                      isSentByMe: isSentByMe,
                      showReactions: true,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (resolvedPadding != EdgeInsets.zero) {
      return paddingChangeAnimationDuration != null
          ? AnimatedPadding(
            padding: resolvedPadding,
            duration: paddingChangeAnimationDuration!,
            curve: Curves.linearToEaseOut,
            child: messageWidget,
          )
          : Padding(padding: resolvedPadding, child: messageWidget);
    }

    return messageWidget;
  }

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

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  final bool isSentByMe;
  final bool showReactions;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final CrossAxisAlignment sentMessageColumnAlignment;
  final CrossAxisAlignment receivedMessageColumnAlignment;
  final CrossAxisAlignment sentMessageRowAlignment;
  final CrossAxisAlignment receivedMessageRowAlignment;
  final Widget child;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.isSentByMe,
    required this.child,
    this.showReactions = true,
    this.topWidget,
    this.bottomWidget,
    this.leadingWidget,
    this.trailingWidget,
    this.sentMessageColumnAlignment = CrossAxisAlignment.end,
    this.receivedMessageColumnAlignment = CrossAxisAlignment.start,
    this.sentMessageRowAlignment = CrossAxisAlignment.end,
    this.receivedMessageRowAlignment = CrossAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    Widget? reactionsWidget;
    if (showReactions) {
      reactionsWidget = FlyerChatReactions(reactions: message.reactions);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isSentByMe
              ? sentMessageColumnAlignment
              : receivedMessageColumnAlignment,
      children: [
        if (topWidget != null) topWidget!,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isSentByMe
                  ? sentMessageRowAlignment
                  : receivedMessageRowAlignment,
          children: [
            if (leadingWidget != null) leadingWidget!,
            Flexible(
              child:
                  showReactions
                      ? Stack(
                        children: [
                          // TODO Find better way to add height for the reactions widget
                          // But the reaction Widget width depends on it's constraints and there is none in the column
                          Column(children: [child, SizedBox(height: 16)]),
                          Positioned(
                            bottom: 0,
                            left: isSentByMe ? 8 : 0,
                            right: isSentByMe ? 0 : 8,
                            child: reactionsWidget!,
                          ),
                        ],
                      )
                      : Container(child: child),
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
        if (bottomWidget != null) bottomWidget!,
      ],
    );
  }
}
