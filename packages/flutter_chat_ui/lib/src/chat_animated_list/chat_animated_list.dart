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
import '../utils/chat_input_height_notifier.dart';
import '../utils/keyboard_mixin.dart';
import '../utils/load_more_notifier.dart';
import '../utils/message_list_diff.dart';
import '../utils/typedefs.dart';

enum InitialScrollToEndMode { none, jump, animate }

class ChatAnimatedList extends StatefulWidget {
  final ChatItem itemBuilder;
  final ScrollController? scrollController;
  final Duration insertAnimationDuration;
  final Duration removeAnimationDuration;
  final Duration scrollToEndAnimationDuration;
  final Duration scrollToBottomAppearanceDelay;
  final double? topPadding;
  final double? bottomPadding;
  final Widget? topSliver;
  final Widget? bottomSliver;
  final bool? handleSafeArea;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final InitialScrollToEndMode? initialScrollToEndMode;
  final bool? shouldScrollToEndWhenSendingMessage;
  final bool? shouldScrollToEndWhenAtBottom;
  final PaginationCallback? onEndReached;

  /// Threshold for triggering pagination, represented as a value between 0 and 1.
  /// 0 represents the top of the list, while 1 represents the bottom.
  /// A value of 0.2 means pagination will trigger when scrolled to 20% from the top.
  final double? paginationThreshold;
  final int? messageGroupingTimeoutInSeconds;

  const ChatAnimatedList({
    super.key,
    required this.itemBuilder,
    this.scrollController,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
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
    this.paginationThreshold = 0.2,
    this.messageGroupingTimeoutInSeconds,
  });

  @override
  ChatAnimatedListState createState() => ChatAnimatedListState();
}

class ChatAnimatedListState extends State<ChatAnimatedList>
    with TickerProviderStateMixin, WidgetsBindingObserver, KeyboardMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late final ScrollController _scrollController;
  late List<Message> _oldList;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

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
  String _lastInsertedMessageId = '';
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
      switch (event.type) {
        case ChatOperationType.insert:
          assert(
            event.index != null,
            'Index must be provided when inserting a message.',
          );
          assert(
            event.message != null,
            'Message must be provided when inserting a message.',
          );
          _onInserted(event.index!, event.message!);
          _oldList = List.from(_chatController.messages);
          break;
        case ChatOperationType.remove:
          assert(
            event.index != null,
            'Index must be provided when removing a message.',
          );
          assert(
            event.message != null,
            'Message must be provided when removing a message.',
          );
          _onRemoved(event.index!, event.message!);
          _oldList = List.from(_chatController.messages);
          break;
        case ChatOperationType.set:
          final newList = _chatController.messages;

          final updates =
              diffutil
                  .calculateDiff<Message>(MessageListDiff(_oldList, newList))
                  .getUpdatesWithData();

          for (final update in updates) {
            _onDiffUpdate(update);
          }

          _oldList = List.from(newList);
          break;
        default:
          break;
      }
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
          if (notification.direction == ScrollDirection.forward) {
            _paginationShouldTrigger = true;
            _userHasScrolled = true;
          } else {
            // When user overscolls to the bottom or stays idle at the bottom, set `_userHasScrolled` to false
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
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
              controller: _scrollController,
              keyboardDismissBehavior:
                  widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: <Widget>[
                if (widget.topPadding != null)
                  SliverPadding(
                    padding: EdgeInsets.only(top: widget.topPadding!),
                  ),
                if (widget.topSliver != null) widget.topSliver!,
                if (widget.onEndReached != null)
                  SliverToBoxAdapter(
                    child: Consumer<LoadMoreNotifier>(
                      builder: (context, notifier, child) {
                        return Visibility(
                          visible: notifier.isLoading,
                          maintainState: true,
                          child: child!,
                        );
                      },
                      child:
                          builders.loadMoreBuilder?.call(context) ?? LoadMore(),
                    ),
                  ),
                SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _chatController.messages.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                    Animation<double> animation,
                  ) {
                    _sliverListViewContext ??= context;
                    final message = _chatController.messages[index];

                    return widget.itemBuilder(
                      context,
                      message,
                      index,
                      animation,
                      messageGroupingTimeoutInSeconds:
                          widget.messageGroupingTimeoutInSeconds,
                    );
                  },
                ),
                if (widget.bottomSliver != null) widget.bottomSliver!,
                Consumer<ChatInputHeightNotifier>(
                  builder: (context, heightNotifier, child) {
                    return SliverPadding(
                      padding: EdgeInsets.only(
                        bottom:
                            heightNotifier.height +
                            (widget.bottomPadding ?? 0) +
                            (widget.handleSafeArea == true
                                ? bottomSafeArea
                                : 0),
                      ),
                    );
                  },
                ),
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

  /// Joins the `AnimationController` to the `ScrollController`, providing ample
  /// time for the lazy list to render its contents while scrolling to the bottom.
  /// See https://stackoverflow.com/a/77175903 for more details.
  void _linkAnimationToScroll() {
    _scrollController.jumpTo(
      _scrollAnimationController.value *
          _scrollController.position.maxScrollExtent,
    );
  }

  void _initialScrollToEnd() async {
    // Delay the scroll to the end animation so new message is painted, otherwise
    // maxScrollExtent is not yet updated and the animation might not work.
    await Future.delayed(widget.insertAnimationDuration);

    if (!_scrollController.hasClients || !mounted) return;

    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      return;
    }

    if (widget.scrollToEndAnimationDuration == Duration.zero) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
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
    if (data.id != _lastInsertedMessageId ||
        _scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
      return;
    }

    // When user hasn't manually scrolled up, automatically scroll to show new messages.
    // This matches typical chat behavior where you stay at the bottom to see incoming
    // messages unless you've explicitly scrolled up to view history.
    // After scrolling, exit the function since no other scroll behavior is needed.
    if (widget.shouldScrollToEndWhenAtBottom == true && !_userHasScrolled) {
      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: widget.scrollToEndAnimationDuration,
          curve: Curves.linearToEaseOut,
        );
      }
      return;
    }

    final currentUserId = context.read<String>();

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
      if (_userHasScrolled) {
        _scrollAnimationController.value =
            _scrollController.position.pixels /
            _scrollController.position.maxScrollExtent;
        await _scrollAnimationController.fling();
      } else {
        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        } else {
          await _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
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
      if (_scrollController.position.maxScrollExtent == 0) {
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

        // jump until pixels == maxScrollExtent, i.e. end of the list
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          _needsInitialScrollPositionAdjustment = false;
        } else {
          _scrollController.jumpTo(notification.metrics.maxScrollExtent);
        }
      }
    });
  }

  void _handleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      _isScrollingToBottom = true;

      _scrollToBottomController.reverse();

      _scrollAnimationController.value =
          _scrollController.position.pixels /
          _scrollController.position.maxScrollExtent;
      _scrollAnimationController.fling();

      _userHasScrolled = false;
      _isScrollingToBottom = false;
    });
  }

  void _handleToggleScrollToBottom() {
    if (!_isScrollingToBottom) {
      _scrollToBottomShowTimer?.cancel();
      if (_scrollController.offset <
          _scrollController.position.maxScrollExtent) {
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
    // Get the threshold for pagination, defaulting to 0 (very top of the list)
    final threshold = widget.paginationThreshold ?? 0;

    // Calculate how far the user has scrolled as a percentage from 0 to 1.
    // For example, 0.1 means user has scrolled 10% from the top.
    final scrollPercentage = metrics.pixels / metrics.maxScrollExtent;

    // Check if user has scrolled past the threshold percentage from the top
    if (scrollPercentage <= threshold) {
      // Reset pagination trigger flag to prevent multiple triggers.
      // Flag gets set back to true when user scrolls up again.
      _paginationShouldTrigger = false;

      // Store current scroll metrics before loading more items.
      // We need these to properly adjust scroll position after new items are inserted.
      // Without this, the scroll position would stay at the very top, causing pagination
      // to trigger in a loop.
      final extent = metrics.maxScrollExtent;

      // Show loading indicator while pagination is in progress
      context.read<LoadMoreNotifier>().setLoading(true);

      // Call user-provided pagination callback to load more items
      await widget.onEndReached!();

      // Wait for next frame when new items have been rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients && mounted) {
          final notifier = context.read<LoadMoreNotifier>();
          final loadMoreHeight = notifier.height;
          // Calculate new scroll position that accounts for inserted items.
          // We subtract loading indicator height to get true content extent.
          // This prevents items from being cut off after scroll adjustment.
          final newExtent =
              _scrollController.position.maxScrollExtent - loadMoreHeight;
          final targetOffset = newExtent - extent;

          // Only adjust scroll position if new items were actually added.
          // We add 1 to account for potential floating point differences.
          if (newExtent > extent + 1) {
            _scrollController.jumpTo(targetOffset);
          }

          // Hide loading indicator now that pagination is complete
          notifier.setLoading(false);
        }
      });
    }
  }

  /// Scrolls to a specific message by ID.
  Future<void> _scrollToMessageId(
    String messageId, {
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
    if (index < 0 || index >= _chatController.messages.length) {
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
    // set `_userHasScrolled` to false so that the scroll to end animation is triggered.
    if (_userHasScrolled &&
        _scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
      _userHasScrolled = false;
    }

    _listKey.currentState!.insertItem(
      position,
      // We are only animating items when scroll view is not yet scrollable,
      // otherwise we just insert the item without animation.
      // (animation is replaced with scroll to bottom animation)
      duration:
          _scrollController.position.maxScrollExtent == 0
              ? widget.insertAnimationDuration
              : Duration.zero,
    );

    // Used later to trigger scroll to end only for the last inserted message.
    _lastInsertedMessageId = data.id;

    _scrollToEnd(data);
  }

  void _onRemoved(final int position, final Message data) {
    _listKey.currentState!.removeItem(
      position,
      (context, animation) => widget.itemBuilder(
        context,
        data,
        position,
        animation,
        messageGroupingTimeoutInSeconds: widget.messageGroupingTimeoutInSeconds,
        isRemoved: true,
      ),
      duration: widget.removeAnimationDuration,
    );
  }

  void _onChanged(int position, Message oldData, Message newData) {
    _onRemoved(position, oldData);
    _listKey.currentState!.insertItem(
      position,
      duration: widget.insertAnimationDuration,
    );
  }

  void _onDiffUpdate(diffutil.DataDiffUpdate<Message> update) {
    update.when<void>(
      insert: (pos, data) => _onInserted(pos, data),
      remove: (pos, data) => _onRemoved(pos, data),
      change: (pos, oldData, newData) => _onChanged(pos, oldData, newData),
      move: (_, __, ___) => throw UnimplementedError('unused'),
    );
  }
}
