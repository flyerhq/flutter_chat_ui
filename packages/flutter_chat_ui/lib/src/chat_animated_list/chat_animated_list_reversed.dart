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

  /// Callback triggered when the user scrolls near the top (visually bottom), requesting older messages.
  final PaginationCallback? onEndReached;

  /// Threshold (0.0 to 1.0) from the top (visually bottom) to trigger [onEndReached].
  /// Defaults to 0.2. See note below.
  final double? paginationThreshold;

  /// Timeout in seconds for grouping consecutive messages from the same author.
  final int? messageGroupingTimeoutInSeconds;

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
    this.paginationThreshold = 0.2,
    this.messageGroupingTimeoutInSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return ChatAnimatedList(
      key: key,
      itemBuilder: itemBuilder,
      scrollController: scrollController,
      insertAnimationDuration: insertAnimationDuration,
      removeAnimationDuration: removeAnimationDuration,
      insertAnimationDurationResolver: insertAnimationDurationResolver,
      removeAnimationDurationResolver: removeAnimationDurationResolver,
      scrollToEndAnimationDuration: scrollToEndAnimationDuration,
      scrollToBottomAppearanceDelay: scrollToBottomAppearanceDelay,
      topPadding: bottomPadding,
      bottomPadding: topPadding,
      topSliver: bottomSliver,
      bottomSliver: topSliver,
      handleSafeArea: handleSafeArea,
      keyboardDismissBehavior: keyboardDismissBehavior,
      shouldScrollToEndWhenSendingMessage: shouldScrollToEndWhenSendingMessage,
      onEndReached: onEndReached,
      paginationThreshold: paginationThreshold,
      messageGroupingTimeoutInSeconds: messageGroupingTimeoutInSeconds,
      reversed: true,
    );
  }
}
