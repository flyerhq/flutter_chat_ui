import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

import '../utils/typedefs.dart';
import 'chat_animated_list.dart';

/// An animated list widget specifically designed for displaying chat messages,
/// growing from bottom to top (reversed).
///
/// This is a convenience wrapper around [ChatAnimatedList] with [reversed] set to true.
/// See [ChatAnimatedList] for detailed documentation of all parameters.
class ChatAnimatedListReversed extends StatelessWidget {
  /// Builder function for creating individual chat message widgets.
  final ChatItem itemBuilder;

  /// Optional scroll controller for the underlying [CustomScrollView].
  final ScrollController? scrollController;

  /// Default duration for message insertion animations.
  final Duration insertAnimationDuration;

  /// Default duration for message removal animations.
  final Duration removeAnimationDuration;

  /// Optional function to resolve custom insertion animation duration per message.
  final MessageAnimationDurationResolver? insertAnimationDurationResolver;

  /// Optional function to resolve custom removal animation duration per message.
  final MessageAnimationDurationResolver? removeAnimationDurationResolver;

  /// Duration for scrolling to the end/bottom of the list.
  final Duration scrollToEndAnimationDuration;

  /// Delay before the scroll-to-bottom button appears after scrolling up.
  final Duration scrollToBottomAppearanceDelay;

  /// Padding added above the first item (visually the bottom-most).
  final double? topPadding;

  /// Padding added below the last item (visually the top-most, before the composer).
  final double? bottomPadding;

  /// Optional sliver widget to place at the very top (visually bottom) of the scroll view.
  final Widget? topSliver;

  /// Optional sliver widget to place at the very bottom (visually top) of the scroll view.
  final Widget? bottomSliver;

  /// Whether to handle bottom safe area padding automatically.
  final bool? handleSafeArea;

  /// How the scroll view should dismiss the keyboard.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// Whether to automatically scroll to the end (bottom) when a new message is sent (inserted).
  final bool? shouldScrollToEndWhenSendingMessage;

  /// Callback triggered when the user scrolls near the top, requesting older messages.
  final PaginationCallback? onEndReached;

  /// Callback triggered when the user scrolls near the bottom, requesting newer messages.
  final PaginationCallback? onStartReached;

  /// Threshold (0.0 to 1.0) from the top to trigger [onEndReached].
  /// Defaults to 0.2. See note below.
  final double? paginationThreshold;

  /// Threshold (0.0 to 1.0) from the top to trigger [onStartReached].
  final double? startPaginationThreshold;

  /// The mode to use for grouping messages.
  final MessagesGroupingMode? messagesGroupingMode;

  /// Timeout in seconds for grouping consecutive messages from the same author.
  final int? messageGroupingTimeoutInSeconds;

  /// Physics for the scroll view.
  final ScrollPhysics? physics;

  /// Creates a reversed animated chat list.
  const ChatAnimatedListReversed({
    super.key,
    required this.itemBuilder,
    this.scrollController,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
    this.insertAnimationDurationResolver,
    this.removeAnimationDurationResolver,
    this.scrollToEndAnimationDuration = const Duration(milliseconds: 250),
    this.scrollToBottomAppearanceDelay = const Duration(milliseconds: 250),
    this.topPadding = 8,
    this.bottomPadding = 20,
    this.topSliver,
    this.bottomSliver,
    this.handleSafeArea = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.shouldScrollToEndWhenSendingMessage = true,
    this.onEndReached,
    this.onStartReached,
    // Threshold for triggering pagination, represented as a value between 0 (top)
    // and 1 (bottom).
    //
    // Unlike the non-reversed list, scroll anchoring isn't typically needed here
    // because new items are added at the bottom (index 0). The default of 0.2
    // triggers pagination when 20% from the visual top is reached.
    this.paginationThreshold = 0.2,
    // Threshold for triggering pagination for newer messages, represented as
    // a value between 0 (top) and 1 (bottom).
    //
    // IMPORTANT: This value defaults to a very big number (e.g., 0.99 or 99%)
    // for a critical reason. The scroll anchoring mechanism used to prevent
    // content jumps during pagination relies on accurately identifying the
    // *actual* bottommost visible item *before* loading new content.
    //
    // A small threshold ensures that pagination is triggered only when the user
    // is very close to the bottom, making it highly likely that the scroll observer
    // correctly identifies the visually bottommost item as the anchor.
    //
    // WARNING: Decreasing this value significantly (e.g., to 0.8 or lower)
    // means pagination might trigger when items further up the viewport are
    // technically the "first visible" according to the observer. This will cause
    // the anchoring logic to select the wrong item, resulting in the list
    // jumping incorrectly after new items are loaded, potentially appearing to
    // scroll to a random position.
    //
    // Modify this value at your own risk. If you decrease it and experience
    // unstable pagination jumps, revert to a bigger value like 0.99.
    this.startPaginationThreshold = 0.99,
    this.messagesGroupingMode,
    this.messageGroupingTimeoutInSeconds,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ChatAnimatedList(
      key: key,
      itemBuilder: itemBuilder,
      scrollController: scrollController,
      reversed: true,
      insertAnimationDuration: insertAnimationDuration,
      removeAnimationDuration: removeAnimationDuration,
      insertAnimationDurationResolver: insertAnimationDurationResolver,
      removeAnimationDurationResolver: removeAnimationDurationResolver,
      scrollToEndAnimationDuration: scrollToEndAnimationDuration,
      scrollToBottomAppearanceDelay: scrollToBottomAppearanceDelay,
      topPadding: topPadding,
      bottomPadding: bottomPadding,
      topSliver: topSliver,
      bottomSliver: bottomSliver,
      handleSafeArea: handleSafeArea,
      keyboardDismissBehavior: keyboardDismissBehavior,
      initialScrollToEndMode: InitialScrollToEndMode.none,
      shouldScrollToEndWhenSendingMessage: shouldScrollToEndWhenSendingMessage,
      shouldScrollToEndWhenAtBottom: false,
      onEndReached: onEndReached,
      onStartReached: onStartReached,
      paginationThreshold: paginationThreshold,
      startPaginationThreshold: startPaginationThreshold,
      messageGroupingTimeoutInSeconds: messageGroupingTimeoutInSeconds,
      physics: physics,
    );
  }
}
