import 'dart:async';
import 'dart:math';

import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../empty_chat_list.dart';
import '../load_more.dart';
import '../scroll_to_bottom.dart';
import '../utils/load_more_notifier.dart';
import '../utils/message_list_diff.dart';
import '../utils/typedefs.dart';
import 'sliver_spacing.dart';

/// Enum controlling the initial scroll behavior of the chat list.
enum InitialScrollToEndMode {
  /// Do not scroll initially.
  none,

  /// Jump directly to the end without animation.
  jump,

  /// Animate scrolling to the end.
  animate,
}

/// An animated list widget specifically designed for displaying chat messages.
///
/// Handles message insertion/removal animations, pagination (loading older messages),
/// automatic scrolling, keyboard handling, and scroll-to-bottom functionality.
/// It listens to a [ChatController] for message updates.
class ChatAnimatedList extends StatefulWidget {
  /// Builder function for creating individual chat message widgets.
  final ChatItem itemBuilder;

  /// Optional scroll controller for the underlying [CustomScrollView].
  final ScrollController? scrollController;

  /// Whether the list should be laid out and scrolled in reverse order.
  /// When true, new items are added at the bottom and the list grows upwards.
  final bool reversed;

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

  /// Threshold for triggering scroll-to-bottom button appearance.
  final double scrollToBottomAppearanceThreshold;

  /// Padding added above the first item in the list.
  final double? topPadding;

  /// Padding added below the last item (before the composer).
  final double? bottomPadding;

  /// Optional sliver widget to place at the very top of the scroll view.
  final Widget? topSliver;

  /// Optional sliver widget to place at the very bottom of the scroll view.
  final Widget? bottomSliver;

  /// Whether to handle bottom safe area padding automatically.
  final bool? handleSafeArea;

  /// How the scroll view should dismiss the keyboard.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// How the list should initially scroll to the end.
  /// Note: has no effect if [reversed] is true, as list starts at the bottom.
  final InitialScrollToEndMode? initialScrollToEndMode;

  /// Whether to automatically scroll to the end when a new message is sent (inserted).
  final bool? shouldScrollToEndWhenSendingMessage;

  /// Whether to automatically scroll to the end if the user is already at the bottom
  /// when a new message arrives.
  /// Note: has no effect if [reversed] is true, as new items appear at the bottom.
  final bool? shouldScrollToEndWhenAtBottom;

  /// Callback triggered when the user scrolls near the top, requesting older messages.
  final PaginationCallback? onEndReached;

  /// Threshold for triggering pagination, represented as a value between 0 and 1.
  /// 0 represents the top of the list, while 1 represents the bottom.
  /// A value of 0.2 means pagination will trigger when scrolled to 20% from the top.
  final double? paginationThreshold;

  /// The mode to use for grouping messages.
  final MessagesGroupingMode? messagesGroupingMode;

  /// Timeout in seconds for grouping consecutive messages from the same author.
  final int? messageGroupingTimeoutInSeconds;

  /// Physics for the scroll view.
  final ScrollPhysics? physics;

  /// Creates an animated chat list.
  const ChatAnimatedList({
    super.key,
    required this.itemBuilder,
    this.scrollController,
    this.reversed = false,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
    this.insertAnimationDurationResolver,
    this.removeAnimationDurationResolver,
    this.scrollToEndAnimationDuration = const Duration(milliseconds: 250),
    this.scrollToBottomAppearanceDelay = const Duration(milliseconds: 250),
    this.scrollToBottomAppearanceThreshold = 0,
    this.topPadding = 8,
    this.bottomPadding = 20,
    this.topSliver,
    this.bottomSliver,
    this.handleSafeArea = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.initialScrollToEndMode = InitialScrollToEndMode.jump,
    this.shouldScrollToEndWhenSendingMessage = true,
    this.shouldScrollToEndWhenAtBottom = true,
    this.onEndReached,
    // Threshold for triggering pagination, represented as a value between 0 (top)
    // and 1 (bottom).
    //
    // IMPORTANT: This value defaults to a very small number (e.g., 0.01 or 1%)
    // for a critical reason. The scroll anchoring mechanism used to prevent
    // content jumps during pagination relies on accurately identifying the
    // *actual* topmost visible item *before* loading new content.
    //
    // A small threshold ensures that pagination is triggered only when the user
    // is very close to the top, making it highly likely that the scroll observer
    // correctly identifies the visually topmost item as the anchor.
    //
    // WARNING: Increasing this value significantly (e.g., to 0.2 or higher)
    // means pagination might trigger when items further down the viewport are
    // technically the "first visible" according to the observer. This will cause
    // the anchoring logic to select the wrong item, resulting in the list
    // jumping incorrectly after new items are loaded, potentially appearing to
    // scroll to a random position.
    //
    // Modify this value at your own risk. If you increase it and experience
    // unstable pagination jumps, revert to a smaller value like 0.01.
    this.paginationThreshold = 0.01,
    this.messagesGroupingMode,
    this.messageGroupingTimeoutInSeconds,
    this.physics,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatAnimatedListState createState() => _ChatAnimatedListState();
}

/// State for [ChatAnimatedList].
class _ChatAnimatedListState extends State<ChatAnimatedList>
    with TickerProviderStateMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late final ScrollController _scrollController;
  late List<Message> _oldList;
  late ValueNotifier<bool> _oldListEmptyNotifier;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

  // Queue of operations to be processed
  final List<ChatOperation> _operationsQueue = [];
  bool _isProcessingOperations = false;

  late final AnimationController _scrollAnimationController;
  late final AnimationController _scrollToBottomController;
  late final Animation<double> _scrollToBottomAnimation;
  Timer? _scrollToBottomShowTimer;

  bool _userHasScrolled = false;
  bool _isScrollingToBottom = false;
  // This flag is used to determine if we already adjusted the initial
  // scroll position (so we can see latest messages when we enter chat)
  late bool _needsInitialScrollPositionAdjustment;
  MessageID _lastInsertedMessageId = '';
  // Controls whether pagination should be triggered when scrolling to the top.
  // Set to true when user scrolls up, and false after pagination is triggered.
  // This prevents infinite pagination loops when reaching the end of available messages,
  // ensuring onEndReached only fires once per user scroll gesture.
  bool _paginationShouldTrigger = false;

  @override
  void initState() {
    super.initState();
    _chatController = context.read<ChatController>();
    _scrollController = widget.scrollController ?? ScrollController();
    _observerController = SliverObserverController(
      controller: _scrollController,
    )..cacheJumpIndexOffset = false;

    _oldList = List.from(_chatController.messages);
    _oldListEmptyNotifier = ValueNotifier(_oldList.isEmpty);
    _operationsSubscription = _chatController.operationsStream.listen((event) {
      _operationsQueue.add(event);
      _processOperationsQueue();
    });

    _scrollAnimationController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
    _scrollAnimationController.addListener(_linkAnimationToScroll);

    _scrollToBottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scrollToBottomAnimation = CurvedAnimation(
      parent: _scrollToBottomController,
      curve: Curves.linearToEaseOut,
    );

    if (widget.reversed) {
      // For reversed lists, the list naturally starts at the visual bottom (end).
      // So, initial scroll modes (animate/jump to end) have no effect.
      _needsInitialScrollPositionAdjustment = false;
    } else {
      // Logic for non-reversed lists
      if (widget.initialScrollToEndMode == InitialScrollToEndMode.animate) {
        _handleScrollToBottom();
        // If we animate to bottom, no further jump adjustment is needed.
        _needsInitialScrollPositionAdjustment = false;
      } else {
        // For .jump, we need adjustment. For .none, we don't.
        _needsInitialScrollPositionAdjustment =
            widget.initialScrollToEndMode == InitialScrollToEndMode.jump;
      }
    }

    // If controller supports ScrollToMessageMixin, attach the scroll methods
    if (_chatController is ScrollToMessageMixin) {
      (_chatController as ScrollToMessageMixin).attachScrollMethods(
        scrollToMessageId: _scrollToMessageId,
        scrollToIndex: _scrollToIndex,
      );
    }
  }

  void onKeyboardHeightChanged(double height) {
    // Reversed lists handle keyboard automatically
    if (widget.reversed) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || !_scrollController.hasClients || height == 0) {
        return;
      }

      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(
          min(
            _scrollController.offset + height,
            _scrollController.position.maxScrollExtent,
          ),
        );
      } else {
        await _scrollController.animateTo(
          min(
            _scrollController.offset + height,
            _scrollController.position.maxScrollExtent,
          ),
          duration: widget.scrollToEndAnimationDuration,
          curve: Curves.linearToEaseOut,
        );
      }
      // we don't want to show the scroll to bottom button when automatically scrolling content with keyboard
      _scrollToBottomShowTimer?.cancel();
    });
  }

  @override
  void dispose() {
    _oldListEmptyNotifier.dispose();
    _scrollToBottomShowTimer?.cancel();
    _scrollToBottomController.dispose();
    _scrollAnimationController.removeListener(_linkAnimationToScroll);
    _scrollAnimationController.dispose();
    _operationsSubscription.cancel();

    // Only try to dispose scroll controller if it's not provided, let
    // user handle disposing it how they want.
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }

    // If controller supports ScrollToMessageMixin, detach the scroll methods
    if (_chatController is ScrollToMessageMixin) {
      (_chatController as ScrollToMessageMixin).detachScrollMethods();
    }

    super.dispose();
  }

  /// Checks if the scroll view is currently at the very end of the chat list.
  /// For a reversed list, this means the scroll offset is at or before 0.
  /// For a normal list, this means the scroll offset is at or beyond `maxScrollExtent`.
  bool get _isAtChatEndScrollPosition {
    return widget.reversed
        ? _scrollController.offset <= _chatEndScrollPosition
        : _scrollController.offset >= _chatEndScrollPosition;
  }

  /// The scroll position that represents the end of the chat list.
  /// For a reversed list, this is 0.
  /// For a normal list, this is `maxScrollExtent`.
  double get _chatEndScrollPosition {
    return widget.reversed ? 0 : _scrollController.position.maxScrollExtent;
  }

  /// If the scroll-to-bottom button should be shown.
  bool get _shouldShowScrollToBottomButton {
    final scrollOffsetFromBottom =
        widget.reversed
            ? _scrollController.offset
            : _chatEndScrollPosition - _scrollController.offset;

    return scrollOffsetFromBottom > widget.scrollToBottomAppearanceThreshold;
  }

  @override
  Widget build(BuildContext context) {
    final builders = context.read<Builders>();

    // Define the SliverAnimatedList once as it's used for both
    // reversed and non-reversed lists.
    final sliverAnimatedList = SliverAnimatedList(
      key: _listKey,
      initialItemCount: _oldList.length,
      itemBuilder: (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) {
        final message = _oldList[visualPosition(index)];

        return widget.itemBuilder(
          context,
          message,
          visualPosition(index),
          animation,
          messagesGroupingMode: widget.messagesGroupingMode,
          messageGroupingTimeoutInSeconds:
              widget.messageGroupingTimeoutInSeconds,
        );
      },
    );

    List<Widget> buildSlivers() {
      if (widget.reversed) {
        // Order for CustomScrollView(reverse: true) -> Visual Bottom to Top
        return <Widget>[
          // Visually at the bottom (first in sliver list for reverse: true)
          _buildComposerHeightSliver(context),
          if (widget.bottomSliver != null) widget.bottomSliver!,
          sliverAnimatedList,
          if (widget.onEndReached != null) _buildLoadMoreSliver(builders),
          if (widget.topSliver != null) widget.topSliver!,
          if (widget.topPadding != null)
            SliverPadding(padding: EdgeInsets.only(top: widget.topPadding!)),
          // Visually at the top (last in sliver list for reverse: true)
        ];
      } else {
        // Order for CustomScrollView(reverse: false) -> Visual Top to Bottom
        return <Widget>[
          // Visually at the top
          if (widget.topPadding != null)
            SliverPadding(padding: EdgeInsets.only(top: widget.topPadding!)),
          if (widget.topSliver != null) widget.topSliver!,
          if (widget.onEndReached != null) _buildLoadMoreSliver(builders),
          sliverAnimatedList,
          if (widget.bottomSliver != null) widget.bottomSliver!,
          _buildComposerHeightSliver(context),
          // Visually at the bottom
        ];
      }
    }

    return NotificationListener<Notification>(
      onNotification: (notification) {
        if (notification is ScrollMetricsNotification) {
          // Handle initial scroll to bottom so you see latest messages
          _adjustInitialScrollPosition();
          _handleToggleScrollToBottom();
          _handlePagination();
        }

        if (notification is UserScrollNotification) {
          // When user scrolls up, save it to `_userHasScrolled`
          if (notification.direction ==
              (widget.reversed
                  ? ScrollDirection.reverse
                  : ScrollDirection.forward)) {
            _paginationShouldTrigger = true;
            _userHasScrolled = true;
          } else {
            // When user overscolls to the bottom or stays idle at the bottom, set `_userHasScrolled` to false
            if (_isAtChatEndScrollPosition) {
              _userHasScrolled = false;
            }
          }
        }

        if (notification is ScrollUpdateNotification) {
          _handleToggleScrollToBottom();
        }

        // Allow other listeners to get the notification
        return false;
      },
      child: Stack(
        children: [
          SliverViewObserver(
            controller: _observerController,
            sliverContexts: () {
              // Using the key's context ensures we always have the latest, valid
              // context for the SliverAnimatedList, or null if it's not built.
              // This is safer than storing a BuildContext.
              final context = _listKey.currentContext;
              return [if (context != null) context];
            },
            child: CustomScrollView(
              controller: _scrollController,
              reverse: widget.reversed,
              physics: widget.physics,
              keyboardDismissBehavior:
                  widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: buildSlivers(), // Use the new helper method
            ),
          ),
          builders.scrollToBottomBuilder?.call(
                context,
                _scrollToBottomAnimation,
                _handleScrollToBottom,
              ) ??
              ScrollToBottom(
                animation: _scrollToBottomAnimation,
                onPressed: _handleScrollToBottom,
              ),
          ValueListenableBuilder<bool>(
            valueListenable: _oldListEmptyNotifier,
            builder: (context, isEmpty, child) {
              if (isEmpty) {
                return Positioned.fill(
                  child:
                      builders.emptyChatListBuilder?.call(context) ??
                      const EmptyChatList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComposerHeightSliver(BuildContext context) => SliverSpacing(
    bottomPadding: widget.bottomPadding,
    handleSafeArea: widget.handleSafeArea,
    onKeyboardHeightChanged: widget.reversed ? null : onKeyboardHeightChanged,
  );

  Widget _buildLoadMoreSliver(Builders builders) {
    return SliverToBoxAdapter(
      child: Consumer<LoadMoreNotifier>(
        builder: (context, notifier, child) {
          return Visibility(
            visible: notifier.isLoading,
            maintainState: true,
            child: child!,
          );
        },
        child: builders.loadMoreBuilder?.call(context) ?? LoadMore(),
      ),
    );
  }

  /// Joins the `AnimationController` to the `ScrollController`, providing ample
  /// time for the lazy list to render its contents while scrolling to the bottom.
  /// See https://stackoverflow.com/a/77175903 for more details.
  void _linkAnimationToScroll() {
    // In reversed lists, scrolling to the bottom corresponds to a position of 0,
    // which eliminates concerns about the dynamic nature of maxScrollExtent.
    if (widget.reversed) {
      return;
    }

    _scrollController.jumpTo(
      _scrollAnimationController.value *
          _scrollController.position.maxScrollExtent,
    );
  }

  void _initialScrollToEnd() async {
    // Delay the scroll to the end animation so new message is painted, otherwise
    // maxScrollExtent is not yet updated and the animation might not work.
    await Future.delayed(widget.insertAnimationDuration);

    if (!_scrollController.hasClients ||
        !mounted ||
        _isAtChatEndScrollPosition) {
      return;
    }

    if (widget.scrollToEndAnimationDuration == Duration.zero) {
      _scrollController.jumpTo(_chatEndScrollPosition);
    } else {
      await _scrollController.animateTo(
        _chatEndScrollPosition,
        duration: widget.scrollToEndAnimationDuration,
        curve: Curves.linearToEaseOut,
      );
    }
  }

  void _subsequentScrollToEnd(Message data) async {
    // Skip auto-scrolling based on configuration.
    // For reversed lists, scrolling is skipped if `shouldScrollToEndWhenSendingMessage` is false.
    // For non-reversed lists, scrolling is skipped if *both* `shouldScrollToEndWhenSendingMessage`
    // and `shouldScrollToEndWhenAtBottom` are false.
    if (widget.shouldScrollToEndWhenSendingMessage == false &&
        (widget.reversed || widget.shouldScrollToEndWhenAtBottom == false)) {
      return;
    }

    // Skip scroll logic if this is not the most recently inserted message
    // or if the list is already scrolled to the bottom. This prevents
    // duplicate scrolling when multiple messages are inserted at once.
    if (data.id != _lastInsertedMessageId || _isAtChatEndScrollPosition) {
      return;
    }

    // When user hasn't manually scrolled up, automatically scroll to show new messages.
    // This matches typical chat behavior where you stay at the bottom to see incoming
    // messages unless you've explicitly scrolled up to view history.
    // After scrolling, exit the function since no other scroll behavior is needed.
    if (!widget.reversed &&
        widget.shouldScrollToEndWhenAtBottom == true &&
        !_userHasScrolled) {
      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(_chatEndScrollPosition);
      } else {
        await _scrollController.animateTo(
          _chatEndScrollPosition,
          duration: widget.scrollToEndAnimationDuration,
          curve: Curves.linearToEaseOut,
        );
      }
      return;
    }

    final currentUserId = context.read<UserID>();

    // When the user sends a new message, automatically scroll back to
    // the bottom to show their message.
    // This matches common chat UX where sending a message returns focus
    // to the most recent messages. After scrolling, exit the function since
    // no other scroll behavior is needed.
    if (widget.shouldScrollToEndWhenSendingMessage == true &&
        currentUserId == data.authorId &&
        _oldList.last.id == data.id) {
      // When scrolled up in chat history use fling to guarantee scrolling
      // to the very end of the list.
      // See https://stackoverflow.com/a/77175903 for more details.
      if (!widget.reversed && _userHasScrolled) {
        _scrollAnimationController.value =
            _scrollController.offset /
            _scrollController.position.maxScrollExtent;
        await _scrollAnimationController.fling();
      } else {
        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          _scrollController.jumpTo(_chatEndScrollPosition);
        } else {
          await _scrollController.animateTo(
            _chatEndScrollPosition,
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }
      }
      return;
    }
  }

  void _scrollToEnd(Message data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      // We need this condition because if scroll view is not yet scrollable,
      // we want to wait for the insert animation to finish before scrolling to the end.
      if (!widget.reversed && _scrollController.position.maxScrollExtent == 0) {
        // Scroll view is not yet scrollable, scroll to the end if
        // new message makes it scrollable.
        _initialScrollToEnd();
      } else {
        _subsequentScrollToEnd(data);
      }
    });
  }

  void _adjustInitialScrollPosition() {
    // If the chat list is reversed, it begins at the bottom,
    // so no adjustment to the initial scroll position is necessary.
    if (widget.reversed) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      // If the list is empty there is no need to adjust the initial scroll position.
      if (_oldList.isEmpty) {
        _needsInitialScrollPositionAdjustment = false;
        return;
      }

      if (_needsInitialScrollPositionAdjustment) {
        // Flutter might return a bunch of 0 values for maxScrollExtent,
        // we need to ignore those.
        if (_scrollController.position.maxScrollExtent == 0) {
          return;
        }

        // jump until pixels == maxScrollExtent, i.e. end of the list
        if (_scrollController.offset == _chatEndScrollPosition) {
          _needsInitialScrollPositionAdjustment = false;
        } else {
          _scrollController.jumpTo(_chatEndScrollPosition);
        }
      }
    });
  }

  void _handleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      _isScrollingToBottom = true;

      _scrollToBottomController.reverse();

      if (widget.reversed) {
        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          _scrollController.jumpTo(_chatEndScrollPosition);
        } else {
          _scrollController.animateTo(
            _chatEndScrollPosition,
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }
      } else {
        // Use fling to guarantee scrolling to the very end of the list.
        // See https://stackoverflow.com/a/77175903 for more details.
        // N/A for reversed list above as position 0 is stable, while
        // maxScrollExtent is not.
        _scrollAnimationController.value =
            _scrollController.offset /
            _scrollController.position.maxScrollExtent;
        _scrollAnimationController.fling();
      }

      _userHasScrolled = false;
      _isScrollingToBottom = false;
    });
  }

  void _handleToggleScrollToBottom() {
    if (!_isScrollingToBottom) {
      _scrollToBottomShowTimer?.cancel();
      if (_shouldShowScrollToBottomButton) {
        _scrollToBottomShowTimer = Timer(
          widget.scrollToBottomAppearanceDelay,
          () {
            if (mounted) {
              // If we show scroll to bottom that means user is viewing the history
              // so we set `_userHasScrolled` to true.
              _userHasScrolled = true;
              _scrollToBottomController.forward();
            }
          },
        );
      } else {
        if (_scrollToBottomController.status == AnimationStatus.completed ||
            _scrollToBottomController.status == AnimationStatus.forward) {
          _scrollToBottomController.reverse();
        }
      }
    }
  }

  void _handlePagination() async {
    if (!_scrollController.hasClients ||
        !mounted ||
        _needsInitialScrollPositionAdjustment ||
        widget.onEndReached == null ||
        context.read<LoadMoreNotifier>().isLoading ||
        !_paginationShouldTrigger) {
      return;
    }

    // Get the threshold for pagination, defaulting to the very top of the list
    var threshold = (widget.paginationThreshold ?? 0);
    if (widget.reversed) {
      threshold = 1 - threshold;
    }

    // Calculate the user's scroll position as a percentage of the total scrollable area, ranging from 0 to 1.
    // In a standard list, 0 represents the topmost position and 1 represents the bottommost position.
    // In a reversed list, the values are inverted: 1 indicates the top and 0 indicates the bottom.
    final scrollPercentage =
        _scrollController.position.maxScrollExtent == 0
            ? 0
            : _scrollController.offset /
                _scrollController.position.maxScrollExtent;

    final shouldTrigger =
        widget.reversed
            ? scrollPercentage >= threshold
            : scrollPercentage <= threshold;

    // Trigger pagination if user scrolled past the threshold towards the top.
    if (shouldTrigger) {
      // Prevent multiple triggers during one scroll gesture.
      _paginationShouldTrigger = false;

      // Store the ID of the topmost visible item before loading new messages.
      // This item will be used as an anchor to maintain scroll position.
      MessageID? anchorMessageId;
      int? initialMessagesCount;

      // --- Scroll Anchoring Setup: Only for non-reversed lists ---
      if (!widget.reversed) {
        try {
          // We can only anchor the scroll position if the list is actually
          // in the widget tree and has a context.
          if (_listKey.currentContext != null) {
            final notificationResult = await _observerController
                .dispatchOnceObserve(
                  sliverContext: _listKey.currentContext!,
                  isForce: true,
                  isDependObserveCallback: false,
                );
            final firstItem =
                notificationResult
                    .observeResult
                    ?.innerDisplayingChildModelList
                    .firstOrNull;
            final anchorIndex = firstItem?.index;

            if (anchorIndex != null &&
                anchorIndex >= 0 &&
                anchorIndex < _oldList.length) {
              anchorMessageId = _oldList[anchorIndex].id;
            }
          }
        } catch (e) {
          debugPrint('Error observing scroll position for anchoring: $e');
        }
        if (!mounted) return;
        initialMessagesCount = _oldList.length;
      }
      // --- End Scroll Anchoring Setup ---

      // Ensure mounted before using context or calling async widget callbacks
      if (!mounted) return;

      // Show loading indicator.
      context.read<LoadMoreNotifier>().setLoading(true);

      // Load older messages.
      await widget.onEndReached!();

      // Ensure mounted after await, as onEndReached might unmount the widget
      if (!mounted) return;

      // Wait for the next frame for UI updates.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients || !mounted) return;

        final notifier = context.read<LoadMoreNotifier>();

        // --- Scroll Anchoring Action: Only for non-reversed lists ---
        if (!widget.reversed) {
          // initialMessageCount will be non-null here if !widget.reversed
          final didAddMessages = _oldList.length > initialMessagesCount!;
          if (didAddMessages && anchorMessageId != null) {
            final newIndex = _oldList.indexWhere(
              (m) => m.id == anchorMessageId,
            );
            if (newIndex != -1) {
              _scrollToIndex(
                newIndex,
                duration: Duration.zero, // Jump immediately
                alignment: 0, // Align to the top edge
                offset: 0, // Keep item top edge aligned with viewport top edge
              );
            }
          }
        }
        // --- End Scroll Anchoring Action ---

        // Hide loading indicator.
        notifier.setLoading(false);
      });
    }
  }

  /// Scrolls to a specific message by ID.
  Future<void> _scrollToMessageId(
    MessageID messageId, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linearToEaseOut,
    double alignment = 0,
    double offset = 0,
  }) async {
    final index = _oldList.indexWhere((m) => m.id == messageId);
    if (index == -1) {
      return;
    }

    return _scrollToIndex(
      index,
      duration: duration,
      curve: curve,
      alignment: alignment,
      offset: offset,
    );
  }

  /// Scrolls to a specific index in the message list.
  Future<void> _scrollToIndex(
    int index, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linearToEaseOut,
    double alignment = 0,
    double offset = 0,
  }) async {
    if (index < 0 || index >= _oldList.length) {
      return;
    }

    // If the context is null, it means the list is not
    // in the tree, and there's nothing to scroll to.
    if (_listKey.currentContext == null) {
      return;
    }

    final visualIndex = visualPosition(index);

    try {
      if (duration == Duration.zero) {
        await _observerController.jumpTo(
          index: visualIndex,
          alignment: alignment,
          offset: (targetOffset) => offset,
          renderSliverType: ObserverRenderSliverType.list,
        );
      } else {
        await _observerController.animateTo(
          index: visualIndex,
          duration: duration,
          curve: curve,
          alignment: alignment,
          offset: (targetOffset) => offset,
          renderSliverType: ObserverRenderSliverType.list,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onInserted(final int position, final Message data) {
    // If for some reason `_userHasScrolled` is true and the user is not at the bottom of the list,
    // set `_userHasScrolled` to false
    if (_userHasScrolled && _isAtChatEndScrollPosition) {
      _userHasScrolled = false;
    }

    final Duration duration;
    // Determine the animation duration for inserting the item.
    // - For reversed lists, always use the specified insert animation duration.
    // - For non-reversed lists, use the animation duration only if the list is not yet scrollable.
    //   If it's already scrollable, the item is added instantly (Duration.zero),
    //   and the _scrollToEnd logic handles the visual scroll to the new item.
    if (widget.reversed || _scrollController.position.maxScrollExtent == 0) {
      if (widget.insertAnimationDurationResolver != null) {
        duration =
            widget.insertAnimationDurationResolver!(data) ??
            widget.insertAnimationDuration;
      } else {
        duration = widget.insertAnimationDuration;
      }
    } else {
      // Non-reversed and already scrollable
      duration = Duration.zero;
    }

    _oldList.insert(position, data);
    _updateOldListEmptyNotifier();
    // The insertItem method requires the position of the item after the insert
    _listKey.currentState!.insertItem(
      visualPosition(position),
      // We are only animating items when scroll view is not yet scrollable,
      // otherwise we just insert the item without animation.
      // (animation is replaced with scroll to bottom animation)
      duration: duration,
    );

    // Used later to trigger scroll to end only for the last inserted message.
    _lastInsertedMessageId = data.id;

    _scrollToEnd(data);
  }

  void _onInsertedAll(final int position, List<Message> messagesToInsert) {
    // If for some reason `_userHasScrolled` is true and the user is not at the bottom of the list,
    // set `_userHasScrolled` to false
    if (_userHasScrolled && _isAtChatEndScrollPosition) {
      _userHasScrolled = false;
    }

    final Duration duration;
    // Determine the animation duration for inserting the item.
    // - For reversed lists, always use the specified insert animation duration.
    // - For non-reversed lists, use the animation duration only if the list is not yet scrollable.
    //   If it's already scrollable, the item is added instantly (Duration.zero),
    //   and the _scrollToEnd logic handles the visual scroll to the new item.
    if (widget.reversed || _scrollController.position.maxScrollExtent == 0) {
      if (widget.insertAnimationDurationResolver != null) {
        duration =
            widget.insertAnimationDurationResolver!(messagesToInsert.last) ??
            widget.insertAnimationDuration;
      } else {
        duration = widget.insertAnimationDuration;
      }
    } else {
      // Non-reversed and already scrollable
      duration = Duration.zero;
    }

    _oldList.insertAll(position, messagesToInsert);
    _updateOldListEmptyNotifier();

    int visualStartIndexForInsertAllItems;

    if (widget.reversed) {
      // For a reversed list, the `index` for insertAllItems should be the
      // visual index of the item that will appear "earliest" (visually lowest index)
      // in the rendering of the newly inserted block.
      // Since the block itself is also visually reversed when rendered,
      // this corresponds to the visual position of the last content item in the block.
      // Example: Block [C,D] (C=content[pos], D=content[pos+1]) is visually [D, C].
      // We need the visual index of D for insertAllItems.
      visualStartIndexForInsertAllItems = visualPosition(
        position + messagesToInsert.length - 1,
      );
    } else {
      // Normal list
      // For non-reversed, content position is the same as visual insertion position.
      // visualPosition(position) will correctly return `position`.
      visualStartIndexForInsertAllItems = visualPosition(position);
    }

    _listKey.currentState!.insertAllItems(
      visualStartIndexForInsertAllItems,
      messagesToInsert.length,
      duration: duration,
    );

    _lastInsertedMessageId = messagesToInsert.last.id;

    _scrollToEnd(messagesToInsert.last);
  }

  void _onRemoved(final int position, final Message data) {
    // Use animation duration resolver if provided, otherwise use default duration.
    final duration =
        widget.removeAnimationDurationResolver != null
            ? (widget.removeAnimationDurationResolver!(data) ??
                widget.removeAnimationDuration)
            : widget.removeAnimationDuration;

    // Calculate the visual index for SliverAnimatedList.removeItem BEFORE modifying _oldList.
    // SliverAnimatedList.removeItem expects the index of the item *before* it's removed.
    final visualIndex = visualPosition(position);

    _oldList.removeAt(position);
    _updateOldListEmptyNotifier();

    _listKey.currentState!.removeItem(
      visualIndex, // Use the pre-calculated visual index.
      (context, animation) => widget.itemBuilder(
        context,
        data, // Pass the actual message data being removed.
        position, // Pass its original position.
        animation,
        messagesGroupingMode: widget.messagesGroupingMode,
        messageGroupingTimeoutInSeconds: widget.messageGroupingTimeoutInSeconds,
        isRemoved: true,
      ),
      duration: duration,
    );
  }

  void _onChanged(int position, Message oldData, Message newData) {
    _onRemoved(position, oldData);
    _onInserted(position, newData);
  }

  /// Handles a `Move` operation as identified by `diffutil.calculateDiff`.
  /// A move operation is treated as a removal from the `oldPos` followed by an
  /// insertion at an adjusted `newPos`.
  ///
  /// Parameters from `diffutil.DataMove<Message>`:
  ///  - `oldPos`: The original index of the item in `_oldList` before any
  ///    operations from the current diff batch have been applied.
  ///  - `newPos`: The target index for the item in the list *after* it has been
  ///    notionally removed from `oldPos` (and other preceding removals in the
  ///    batch might have occurred, though this method only considers the local
  ///    effect of its own `_onRemoved` call when adjusting `newPos`).
  ///    `diffutil_dart` seems to provide `newPos` as the target index in the list
  ///    state if the item at `oldPos` was the only one removed.
  ///  - `data`: The message data being moved.
  ///
  /// The method first calls `_onRemoved` using `oldPos`. Then, it uses `newPos`
  /// (clamped to valid list bounds) as the `insertionPos` for the subsequent
  /// `_onInserted` call. This sequence correctly updates `_oldList` and drives
  /// the `SliverAnimatedList` removal and insertion animations to visually
  /// represent the move.
  void _onMove(int oldPosition, int newPosition, Message data) {
    // 1. Perform the removal part of the move.
    // This removes the item from _oldList at oldPos and triggers removeItem animation.
    _onRemoved(oldPosition, data);

    // 2. Determine the insertion position.
    // Based on testing, diffutil_dart's `newPos` for a Move operation appears
    // to be the target index *after* the item at `oldPos` is removed.
    // We use this `newPos` directly, after clamping it to the current list bounds.
    var insertionPos = newPosition;

    // Sanity check: Ensure insertionPos is within the bounds of _oldList,
    // which has now shrunk by one item due to the preceding _onRemoved call.
    // Valid insertion indices for _oldList.insert() are 0 to _oldList.length (inclusive).
    if (_oldList.isNotEmpty) {
      insertionPos = insertionPos.clamp(0, _oldList.length);
    } else {
      // If _oldList becomes empty after removal, the only valid insertion index is 0.
      insertionPos = 0;
    }

    // 3. Perform the insertion part of the move.
    // This inserts the item back into _oldList at the calculated insertionPos
    // and triggers insertItem animation.
    _onInserted(insertionPos, data);
  }

  /// Maps a conceptual item position from `_oldList` (content order) to its
  /// visual position in the `SliverAnimatedList` (rendering order).
  /// For non-reversed lists, content and visual positions are the same.
  /// For reversed lists, this transforms the index to account for the reversed rendering order
  /// (e.g., content item 0 becomes the last visual item).
  /// The `indexPosition` refers to the index in the `_oldList`.
  int visualPosition(int indexPosition) {
    return widget.reversed
        ? max(_oldList.length - indexPosition - 1, 0)
        : indexPosition;
  }

  void _onDiffUpdate(diffutil.DataDiffUpdate<Message> update) {
    update.when<void>(
      insert: (pos, data) => _onInserted(pos, data),
      remove: (pos, data) => _onRemoved(pos, data),
      change: (pos, oldData, newData) => _onChanged(pos, oldData, newData),
      move: (oldPos, newPos, data) => _onMove(oldPos, newPos, data),
    );
  }

  /// Update the _oldListEmptyNotifier if necessary
  void _updateOldListEmptyNotifier() {
    final newIsEmpty = _oldList.isEmpty;
    if (newIsEmpty != _oldListEmptyNotifier.value) {
      _oldListEmptyNotifier.value = newIsEmpty;
    }
  }

  /// Processes the queue of chat operations.
  void _processOperationsQueue() {
    // Safety to no process twice, should not really happen
    if (_isProcessingOperations) return;
    _isProcessingOperations = true;
    while (_operationsQueue.isNotEmpty) {
      final ops = List.of(_operationsQueue);
      _operationsQueue.clear();
      for (final op in ops) {
        switch (op.type) {
          case ChatOperationType.insert:
            assert(
              op.index != null,
              'Index must be provided when inserting a message.',
            );
            assert(
              op.message != null,
              'Message must be provided when inserting a message.',
            );
            _onInserted(op.index!, op.message!);
            break;
          case ChatOperationType.remove:
            assert(
              op.index != null,
              'Index must be provided when removing a message.',
            );
            assert(
              op.message != null,
              'Message must be provided when removing a message.',
            );
            _onRemoved(op.index!, op.message!);
            break;
          case ChatOperationType.set:
            // If op.messages is provided (even if empty), it's the new desired state.
            // If op.messages is null, it signifies that the list should be cleared.
            final newList = op.messages ?? const <Message>[];

            final updates =
                diffutil
                    .calculateDiff<Message>(
                      MessageListDiff(_oldList, newList),
                      detectMoves: true,
                    )
                    .getUpdatesWithData();

            for (final update in updates) {
              _onDiffUpdate(update);
            }
            break;
          case ChatOperationType.insertAll:
            assert(
              op.index != null,
              'Index must be provided when inserting all messages.',
            );
            assert(
              op.messages != null && op.messages!.isNotEmpty,
              'Messages must be provided and be non-empty when inserting all.',
            );
            _onInsertedAll(op.index!, op.messages!);
            break;
          case ChatOperationType.update:
            assert(
              op.index != null,
              'Index must be provided when updating a message.',
            );
            _oldList[op.index!] = op.message!;
            break;
        }
      }
    }
    _isProcessingOperations = false;
  }
}
