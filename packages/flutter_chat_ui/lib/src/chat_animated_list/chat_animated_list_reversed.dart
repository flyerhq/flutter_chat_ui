import 'dart:async';
import 'dart:math';

import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../load_more.dart';
import '../scroll_to_bottom.dart';
import '../utils/chat_input_height_notifier.dart';
import '../utils/load_more_notifier.dart';
import '../utils/message_list_diff.dart';
import '../utils/typedefs.dart';

class ChatAnimatedListReversed extends StatefulWidget {
  final ScrollController scrollController;
  final ChatItem itemBuilder;
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
  final bool? shouldScrollToEndWhenSendingMessage;
  final PaginationCallback? onEndReached;

  /// Threshold for triggering pagination, represented as a value between 0 and 1.
  /// 0 represents the top of the list, while 1 represents the bottom.
  /// A value of 0.2 means pagination will trigger when scrolled to 20% from the top.
  final double? paginationThreshold;

  const ChatAnimatedListReversed({
    super.key,
    required this.scrollController,
    required this.itemBuilder,
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
    this.shouldScrollToEndWhenSendingMessage = true,
    this.onEndReached,
    this.paginationThreshold = 0.2,
  });

  @override
  ChatAnimatedListReversedState createState() =>
      ChatAnimatedListReversedState();
}

class ChatAnimatedListReversedState extends State<ChatAnimatedListReversed>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late List<Message> _oldList;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

  // Used by scrollview_observer to allow for scroll to specific item
  BuildContext? _sliverListViewContext;

  late final AnimationController _scrollToBottomController;
  late final Animation<double> _scrollToBottomAnimation;
  Timer? _scrollToBottomShowTimer;

  bool _userHasScrolled = false;
  bool _isScrollingToBottom = false;
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
    _observerController =
        SliverObserverController(controller: widget.scrollController);
    // TODO: Add assert for messages having same id
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
          _onInserted(0, event.message!);
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

          final updates = diffutil
              .calculateDiff<Message>(
                MessageListDiff(_oldList, newList),
              )
              .getUpdatesWithData();

          for (var i = updates.length - 1; i >= 0; i--) {
            _onDiffUpdate(updates.elementAt(i));
          }

          _oldList = List.from(newList);
          break;
        default:
          break;
      }
    });

    _scrollToBottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scrollToBottomAnimation = CurvedAnimation(
      parent: _scrollToBottomController,
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void dispose() {
    _scrollToBottomShowTimer?.cancel();
    _scrollToBottomController.dispose();
    _operationsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final builders = context.watch<Builders>();

    return NotificationListener<Notification>(
      onNotification: (notification) {
        if (notification is ScrollMetricsNotification) {
          _handleToggleScrollToBottom();
          _handlePagination(notification.metrics);
        }

        if (notification is UserScrollNotification) {
          // When user scrolls up, save it to `_userHasScrolled`
          if (notification.direction == ScrollDirection.reverse) {
            _paginationShouldTrigger = true;
            _userHasScrolled = true;
          } else {
            // When user overscolls to the bottom or stays idle at the bottom, set `_userHasScrolled` to false
            if (notification.metrics.pixels <= 0) {
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
            sliverContexts: () => [
              if (_sliverListViewContext != null) _sliverListViewContext!,
            ],
            child: CustomScrollView(
              reverse: true,
              controller: widget.scrollController,
              keyboardDismissBehavior: widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: <Widget>[
                Consumer<ChatInputHeightNotifier>(
                  builder: (context, heightNotifier, child) {
                    return SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: heightNotifier.height +
                            (widget.bottomPadding ?? 0) +
                            (widget.handleSafeArea == true
                                ? bottomSafeArea
                                : 0),
                      ),
                    );
                  },
                ),
                if (widget.bottomSliver != null) widget.bottomSliver!,
                SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _chatController.messages.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                    Animation<double> animation,
                  ) {
                    _sliverListViewContext ??= context;
                    final currentIndex =
                        max(_chatController.messages.length - 1 - index, 0);
                    final message = _chatController.messages[currentIndex];

                    return widget.itemBuilder(
                      context,
                      message,
                      currentIndex,
                      animation,
                    );
                  },
                ),
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
                if (widget.topSliver != null) widget.topSliver!,
                if (widget.topPadding != null)
                  SliverPadding(
                    padding: EdgeInsets.only(top: widget.topPadding!),
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

  void _scrollToEnd(Message data) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!widget.scrollController.hasClients || !mounted) return;

        // Skip auto-scrolling if scroll behavior is disabled:
        // - Scrolling when user sends a new message
        if (widget.shouldScrollToEndWhenSendingMessage == false) {
          return;
        }

        // Skip scroll logic if this is not the most recently inserted message
        // or if the list is already scrolled to the bottom. This prevents
        // duplicate scrolling when multiple messages are inserted at once.
        if (data.id != _lastInsertedMessageId ||
            widget.scrollController.offset <= 0) {
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
          if (widget.scrollToEndAnimationDuration == Duration.zero) {
            widget.scrollController.jumpTo(0);
          } else {
            await widget.scrollController.animateTo(
              0,
              duration: widget.scrollToEndAnimationDuration,
              curve: Curves.linearToEaseOut,
            );
          }

          return;
        }
      },
    );
  }

  void _handleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!widget.scrollController.hasClients || !mounted) return;

        _isScrollingToBottom = true;

        _scrollToBottomController.reverse();

        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          widget.scrollController.jumpTo(0);
        } else {
          widget.scrollController.animateTo(
            0,
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }

        _userHasScrolled = false;
        _isScrollingToBottom = false;
      },
    );
  }

  void _handleToggleScrollToBottom() {
    if (!_isScrollingToBottom) {
      _scrollToBottomShowTimer?.cancel();
      if (widget.scrollController.offset > 0) {
        _scrollToBottomShowTimer =
            Timer(widget.scrollToBottomAppearanceDelay, () {
          if (mounted) {
            // If we show scroll to bottom that means user is viewing the history
            // so we set `_userHasScrolled` to true.
            _userHasScrolled = true;
            _scrollToBottomController.forward();
          }
        });
      } else {
        if (_scrollToBottomController.status == AnimationStatus.completed) {
          _scrollToBottomController.reverse();
        }
      }
    }
  }

  void _handlePagination(ScrollMetrics metrics) async {
    if (!widget.scrollController.hasClients ||
        !mounted ||
        widget.onEndReached == null ||
        context.read<LoadMoreNotifier>().isLoading ||
        !_paginationShouldTrigger) {
      return;
    }
    // Get the threshold for pagination, defaulting to 1 (very top of the list)
    final threshold = 1 - (widget.paginationThreshold ?? 0);

    // Calculate how far the user has scrolled as a percentage from 0 to 1.
    // For example, 0.9 means user has scrolled 10% from the top.
    final scrollPercentage = metrics.pixels / metrics.maxScrollExtent;

    // Check if user has scrolled past the threshold percentage from the top
    if (scrollPercentage >= threshold) {
      // Reset pagination trigger flag to prevent multiple triggers.
      // Flag gets set back to true when user scrolls up again.
      _paginationShouldTrigger = false;

      // Show loading indicator while pagination is in progress
      context.read<LoadMoreNotifier>().setLoading(true);

      // Call user-provided pagination callback to load more items
      await widget.onEndReached!();

      // Wait for next frame when new items have been rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.scrollController.hasClients && mounted) {
          // Hide loading indicator now that pagination is complete
          context.read<LoadMoreNotifier>().setLoading(false);
        }
      });
    }
  }

  void _onInserted(final int position, final Message data) {
    // If for some reason `_userHasScrolled` is true and the user is not at the bottom of the list,
    // set `_userHasScrolled` to false
    if (_userHasScrolled && widget.scrollController.offset <= 0) {
      _userHasScrolled = false;
    }

    _listKey.currentState!.insertItem(
      position,
      duration: widget.insertAnimationDuration,
    );

    // Used later to trigger scroll to end only for the last inserted message.
    _lastInsertedMessageId = data.id;

    _scrollToEnd(data);
  }

  void _onRemoved(final int position, final Message data) {
    final visualPosition = max(_oldList.length - position - 1, 0);
    _listKey.currentState!.removeItem(
      visualPosition,
      (context, animation) => widget.itemBuilder(
        context,
        data,
        visualPosition,
        animation,
        isRemoved: true,
      ),
      duration: widget.removeAnimationDuration,
    );
  }

  void _onChanged(int position, Message oldData, Message newData) {
    _onRemoved(position, oldData);
    _listKey.currentState!.insertItem(
      max(_oldList.length - position - 1, 0),
      duration: widget.insertAnimationDuration,
    );
  }

  void _onDiffUpdate(diffutil.DataDiffUpdate<Message> update) {
    update.when<void>(
      insert: (pos, data) => _onInserted(max(_oldList.length - pos, 0), data),
      remove: (pos, data) => _onRemoved(pos, data),
      change: (pos, oldData, newData) => _onChanged(pos, oldData, newData),
      move: (_, __, ___) => throw UnimplementedError('unused'),
    );
  }
}
