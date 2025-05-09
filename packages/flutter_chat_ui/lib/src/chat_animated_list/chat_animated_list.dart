import 'dart:async';
import 'dart:math';

import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../load_more.dart';
import '../scroll_to_bottom.dart';
import '../utils/composer_height_notifier.dart';
import '../utils/keyboard_mixin.dart';
import '../utils/load_more_notifier.dart';
import '../utils/message_list_diff.dart';
import '../utils/typedefs.dart';

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
  final InitialScrollToEndMode? initialScrollToEndMode;

  /// Whether to automatically scroll to the end when a new message is sent (inserted).
  final bool? shouldScrollToEndWhenSendingMessage;

  /// Whether to automatically scroll to the end if the user is already at the bottom
  /// when a new message arrives.
  final bool? shouldScrollToEndWhenAtBottom;

  /// Callback triggered when the user scrolls near the top, requesting older messages.
  final PaginationCallback? onEndReached;

  /// Threshold for triggering pagination, represented as a value between 0 and 1.
  /// 0 represents the top of the list, while 1 represents the bottom.
  /// A value of 0.2 means pagination will trigger when scrolled to 20% from the top.
  final double? paginationThreshold;

  /// Timeout in seconds for grouping consecutive messages from the same author.
  final int? messageGroupingTimeoutInSeconds;

  /// Whether the list should be reversed (growing from bottom to top).
  /// When true, new messages appear at the bottom and the list grows upwards.
  final bool reversed;

  /// Creates an animated chat list.
  const ChatAnimatedList({
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
    this.messageGroupingTimeoutInSeconds,
    this.reversed = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatAnimatedListState createState() => _ChatAnimatedListState();
}

/// State for [ChatAnimatedList].
class _ChatAnimatedListState extends State<ChatAnimatedList>
    with TickerProviderStateMixin, WidgetsBindingObserver, KeyboardMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late final ScrollController _scrollController;
  late List<Message> _oldList;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

  // Queue of operations to be processed
  final List<ChatOperation> _operationsQueue = [];
  bool _isProcessingOperations = false;

  // Used by scrollview_observer to allow for scroll to specific item
  BuildContext? _sliverListViewContext;

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

    if (widget.initialScrollToEndMode == InitialScrollToEndMode.animate) {
      _handleScrollToBottom();
    } else {
      _needsInitialScrollPositionAdjustment =
          widget.initialScrollToEndMode == InitialScrollToEndMode.jump;
    }

    // If controller supports ScrollToMessageMixin, attach the scroll methods
    if (_chatController is ScrollToMessageMixin) {
      (_chatController as ScrollToMessageMixin).attachScrollMethods(
        scrollToMessageId: _scrollToMessageId,
        scrollToIndex: _scrollToIndex,
      );
    }
  }

  @override
  void onKeyboardHeightChanged(double height) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || !_scrollController.hasClients || height == 0) {
        return;
      }

      if (widget.reversed) {
        // Reversed list is anchored at the bottom
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

  Widget _buildComposerHeightSliver(Builders builders, double bottomSafeArea) {
    return Consumer<ComposerHeightNotifier>(
      builder: (context, heightNotifier, child) {
        return SliverPadding(
          padding: EdgeInsets.only(
            bottom:
                heightNotifier.height +
                (widget.bottomPadding ?? 0) +
                (widget.handleSafeArea == true ? bottomSafeArea : 0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final builders = context.watch<Builders>();

    return NotificationListener<Notification>(
      onNotification: (notification) {
        if (notification is ScrollMetricsNotification) {
          // Handle initial scroll to bottom so you see latest messages
          _adjustInitialScrollPosition(notification);
          _handleToggleScrollToBottom();
          _handlePagination(notification.metrics);
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
            if (_isAtScrollBottom) {
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
            sliverContexts:
                () => [
                  if (_sliverListViewContext != null) _sliverListViewContext!,
                ],
            child: CustomScrollView(
              reverse: widget.reversed,
              controller: _scrollController,
              keyboardDismissBehavior:
                  widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: <Widget>[
                if (widget.reversed)
                  _buildComposerHeightSliver(builders, bottomSafeArea),
                if (widget.topPadding != null)
                  SliverPadding(
                    padding: EdgeInsets.only(top: widget.topPadding!),
                  ),
                if (widget.topSliver != null) widget.topSliver!,
                if (widget.onEndReached != null && !widget.reversed)
                  _buildLoadMoreSliver(builders),
                SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _oldList.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                    Animation<double> animation,
                  ) {
                    _sliverListViewContext ??= context;
                    final message = _oldList[visualPosition(index)];

                    return widget.itemBuilder(
                      context,
                      message,
                      visualPosition(index),
                      animation,
                      messageGroupingTimeoutInSeconds:
                          widget.messageGroupingTimeoutInSeconds,
                    );
                  },
                ),
                if (widget.onEndReached != null && widget.reversed)
                  _buildLoadMoreSliver(builders),
                if (widget.bottomSliver != null) widget.bottomSliver!,
                if (!widget.reversed)
                  _buildComposerHeightSliver(builders, bottomSafeArea),
              ],
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
        ],
      ),
    );
  }

  bool get _isAtScrollBottom {
    return widget.reversed
        ? _scrollController.offset <= 0
        : _scrollController.offset >=
            _scrollController.position.maxScrollExtent;
  }

  double get _endScrollPosition {
    return widget.reversed ? 0.0 : _scrollController.position.maxScrollExtent;
  }

  /// Joins the `AnimationController` to the `ScrollController`, providing ample
  /// time for the lazy list to render its contents while scrolling to the bottom.
  /// See https://stackoverflow.com/a/77175903 for more details.
  void _linkAnimationToScroll() {
    // TODO: Not sure why this was not done for reversed lists
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

    // TODO: Why not call _handleScrollToBottom here?

    if (!_scrollController.hasClients || !mounted) return;

    if (widget.scrollToEndAnimationDuration == Duration.zero) {
      _scrollController.jumpTo(_endScrollPosition);
    } else {
      await _scrollController.animateTo(
        _endScrollPosition,
        duration: widget.scrollToEndAnimationDuration,
        curve: Curves.linearToEaseOut,
      );
    }
  }

  void _subsequentScrollToEnd(Message data) async {
    // Skip auto-scrolling if both scroll behaviors are disabled:
    // - Scrolling when user is at bottom of chat
    // - Scrolling when user sends a new message
    if (widget.shouldScrollToEndWhenAtBottom == false &&
        widget.shouldScrollToEndWhenSendingMessage == false) {
      return;
    }

    // Skip scroll logic if this is not the most recently inserted message
    // or if the list is already scrolled to the bottom. This prevents
    // duplicate scrolling when multiple messages are inserted at once.

    if (data.id != _lastInsertedMessageId || _isAtScrollBottom) {
      return;
    }

    // When user hasn't manually scrolled up, automatically scroll to show new messages.
    // This matches typical chat behavior where you stay at the bottom to see incoming
    // messages unless you've explicitly scrolled up to view history.
    // After scrolling, exit the function since no other scroll behavior is needed.
    if (widget.shouldScrollToEndWhenAtBottom == true && !_userHasScrolled) {
      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(_endScrollPosition);
      } else {
        await _scrollController.animateTo(
          _endScrollPosition,
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

      // TODO: Why not use _handleScrollToBottom here too ? this could wrap this whole logic.
      // Currently the fling is not used when tapping the scroll to bottom button.
      if (_userHasScrolled && !widget.reversed) {
        // TODO not really sure why this is not done for reversed lists
        _scrollAnimationController.value =
            _scrollController.position.pixels /
            _scrollController.position.maxScrollExtent;
        await _scrollAnimationController.fling();
      } else {
        // TODO: Not sure why there was an else, if the user has not scrolled we dont need to animate?
        // Maybe juste handle the reverse case here?

        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          _scrollController.jumpTo(_endScrollPosition);
        } else {
          await _scrollController.animateTo(
            _endScrollPosition,
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

  void _adjustInitialScrollPosition(ScrollMetricsNotification notification) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;
      // TODO: Up to you to decide if you want to keep this or not.
      // if (widget.reversed) {
      //   // Reversed lists don't need to adjust the initial scroll position.
      //   return;
      // }

      // If the list is empty there is no need to adjust the initial scroll position.
      if (_oldList.isEmpty) {
        _needsInitialScrollPositionAdjustment = false;
        return;
      }

      if (_needsInitialScrollPositionAdjustment) {
        // Flutter might return a bunch of 0 values for maxScrollExtent,
        // we need to ignore those.
        if (notification.metrics.maxScrollExtent == 0) {
          return;
        }

        // jump until pixels == maxScrollExtent or 0 for reversed lists, i.e. end of the list
        if (notification.metrics.pixels == _endScrollPosition) {
          _needsInitialScrollPositionAdjustment = false;
        } else {
          _scrollController.jumpTo(_endScrollPosition);
        }
      }
    });
  }

  void _handleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      _isScrollingToBottom = true;

      _scrollToBottomController.reverse();

      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(_endScrollPosition);
      } else {
        _scrollController.animateTo(
          _endScrollPosition,
          duration: widget.scrollToEndAnimationDuration,
          curve: Curves.linearToEaseOut,
        );
      }

      _userHasScrolled = false;
      _isScrollingToBottom = false;
    });
  }

  void _handleToggleScrollToBottom() {
    if (!_isScrollingToBottom) {
      _scrollToBottomShowTimer?.cancel();
      if (!_isAtScrollBottom) {
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
        if (_scrollToBottomController.status == AnimationStatus.completed) {
          _scrollToBottomController.reverse();
        }
      }
    }
  }

  void _handlePagination(ScrollMetrics metrics) async {
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
    // Calculate how far the user has scrolled as a percentage from 0 to 1.
    // For a normal list this is 0 at the top and 1 at the bottom.
    // For a reversed list this is 1 at the top and 0 at the bottom.
    final scrollPercentage =
        metrics.maxScrollExtent == 0
            ? 0
            : metrics.pixels / metrics.maxScrollExtent;

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
      try {
        final notificationResult = await _observerController
            .dispatchOnceObserve(
              sliverContext: _sliverListViewContext!,
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
            anchorIndex < _chatController.messages.length) {
          anchorMessageId = _chatController.messages[anchorIndex].id;
        }
      } catch (e) {
        debugPrint('Error observing scroll position for anchoring: $e');
      }

      if (!mounted) return;

      // Record message count before loading to check if new items were added.
      final initialMessageCount = _chatController.messages.length;

      // Show loading indicator.
      context.read<LoadMoreNotifier>().setLoading(true);

      // Load older messages.
      await widget.onEndReached!();

      // Wait for the next frame for UI updates.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients || !mounted) return;

        final notifier = context.read<LoadMoreNotifier>();
        final didAddMessages =
            _chatController.messages.length > initialMessageCount;

        // If new messages were loaded and we have an anchor, scroll to keep the
        // anchor item at the top of the viewport.
        if (didAddMessages && anchorMessageId != null) {
          final newIndex = _chatController.messages.indexWhere(
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
    final index = _chatController.messages.indexWhere((m) => m.id == messageId);
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

    if (_sliverListViewContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!_scrollController.hasClients || !mounted) return;
        return _scrollToIndex(
          index,
          duration: duration,
          curve: curve,
          alignment: alignment,
          offset: offset,
        );
      });
    }

    try {
      if (duration == Duration.zero) {
        await _observerController.jumpTo(
          index: index,
          alignment: alignment,
          offset: (targetOffset) => offset,
          renderSliverType: ObserverRenderSliverType.list,
        );
      } else {
        await _observerController.animateTo(
          index: index,
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
    if (_userHasScrolled && _isAtScrollBottom) {
      _userHasScrolled = false;
    }

    final Duration duration;

    if (_scrollController.position.maxScrollExtent == 0) {
      if (widget.insertAnimationDurationResolver != null) {
        duration =
            widget.insertAnimationDurationResolver!(data) ??
            widget.insertAnimationDuration;
      } else {
        duration = widget.insertAnimationDuration;
      }
    } else {
      duration = Duration.zero;
    }

    _oldList.insert(position, data);
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

  void _onRemoved(final int position, final Message data) {
    // Use animation duration resolver if provided, otherwise use default duration.
    final duration =
        widget.removeAnimationDurationResolver != null
            ? (widget.removeAnimationDurationResolver!(data) ??
                widget.removeAnimationDuration)
            : widget.removeAnimationDuration;

    _oldList.removeAt(position);

    _listKey.currentState!.removeItem(
      visualPosition(position),
      (context, animation) => widget.itemBuilder(
        context,
        data,
        visualPosition(position),
        animation,
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

  /// Maps a content position to its visual position in the list.
  /// For reversed lists, this transforms the index to account for reversed order.
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
      move: (_, __, ___) => throw UnimplementedError('unused'),
    );
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
            // TODO : I kept the old logic for retrocompatibility,
            // but this can cause the issue discussed in #754 #755
            final newList = op.messages ?? _chatController.messages;

            final updates =
                diffutil
                    .calculateDiff<Message>(MessageListDiff(_oldList, newList))
                    .getUpdatesWithData();

            for (var i = updates.length - 1; i >= 0; i--) {
              _onDiffUpdate(updates.elementAt(i));
            }
            break;
          case ChatOperationType.insertAll:
            final newList = op.messages?.reversed ?? [];
            for (final message in newList) {
              _onInserted(op.index!, message);
            }
            break;
          default:
            break;
        }
      }
    }
    _isProcessingOperations = false;
  }
}
