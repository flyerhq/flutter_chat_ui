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
import '../utils/composer_height_notifier.dart';
import '../utils/load_more_notifier.dart';
import '../utils/message_list_diff.dart';
import '../utils/typedefs.dart';

/// An animated list widget specifically designed for displaying chat messages,
/// growing from bottom to top (reversed).
///
/// Handles message insertion/removal animations, pagination (loading older messages),
/// automatic scrolling, keyboard handling, and scroll-to-bottom functionality.
/// It listens to a [ChatController] for message updates.
class ChatAnimatedListReversed extends StatefulWidget {
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

  // Note: Initial scroll is implicitly handled by `reverse: true`.

  /// Whether to automatically scroll to the end (bottom) when a new message is sent (inserted).
  final bool? shouldScrollToEndWhenSendingMessage;

  // Note: `shouldScrollToEndWhenAtBottom` is not applicable as new items appear at the bottom.

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
    // Threshold for triggering pagination, represented as a value between 0 (top)
    // and 1 (bottom). In reversed list, 0 is visually the bottom, 1 is visually the top.
    //
    // Unlike the non-reversed list, scroll anchoring isn't typically needed here
    // because new items are added at the bottom (index 0). The default of 0.2
    // triggers pagination when 20% from the visual top is reached.
    this.paginationThreshold = 0.2,
    this.messageGroupingTimeoutInSeconds,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatAnimatedListReversedState createState() =>
      _ChatAnimatedListReversedState();
}

/// State for [ChatAnimatedListReversed].
class _ChatAnimatedListReversedState extends State<ChatAnimatedListReversed>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late final ScrollController _scrollController;
  late List<Message> _oldList;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

  // Used by scrollview_observer to allow for scroll to specific item
  BuildContext? _sliverListViewContext;

  late final AnimationController _scrollToBottomController;
  late final Animation<double> _scrollToBottomAnimation;
  Timer? _scrollToBottomShowTimer;

  bool _userHasScrolled = false;
  bool _isScrollingToBottom = false;
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
          _oldList.insert(event.index!, event.message!);
          _onInserted(event.index!, event.message!);
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
          _oldList.removeAt(event.index!);
          _onRemoved(event.index!, event.message!);
          break;
        case ChatOperationType.set:
          final newList = _chatController.messages;

          final updates =
              diffutil
                  .calculateDiff<Message>(MessageListDiff(_oldList, newList))
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

    // If controller supports ScrollToMessageMixin, attach the scroll methods
    if (_chatController is ScrollToMessageMixin) {
      (_chatController as ScrollToMessageMixin).attachScrollMethods(
        scrollToMessageId: _scrollToMessageId,
        scrollToIndex: _scrollToIndex,
      );
    }
  }

  @override
  void dispose() {
    _scrollToBottomShowTimer?.cancel();
    _scrollToBottomController.dispose();
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
            sliverContexts:
                () => [
                  if (_sliverListViewContext != null) _sliverListViewContext!,
                ],
            child: CustomScrollView(
              reverse: true,
              controller: _scrollController,
              keyboardDismissBehavior:
                  widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: <Widget>[
                Consumer<ComposerHeightNotifier>(
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
                if (widget.bottomSliver != null) widget.bottomSliver!,
                SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _oldList.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                    Animation<double> animation,
                  ) {
                    _sliverListViewContext ??= context;
                    final currentIndex = max(_oldList.length - 1 - index, 0);
                    final message = _oldList[currentIndex];

                    return widget.itemBuilder(
                      context,
                      message,
                      currentIndex,
                      animation,
                      messageGroupingTimeoutInSeconds:
                          widget.messageGroupingTimeoutInSeconds,
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_scrollController.hasClients || !mounted) return;

      // Skip auto-scrolling if scroll behavior is disabled:
      // - Scrolling when user sends a new message
      if (widget.shouldScrollToEndWhenSendingMessage == false) {
        return;
      }

      // Skip scroll logic if this is not the most recently inserted message
      // or if the list is already scrolled to the bottom. This prevents
      // duplicate scrolling when multiple messages are inserted at once.
      if (data.id != _lastInsertedMessageId || _scrollController.offset <= 0) {
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
        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          _scrollController.jumpTo(0);
        } else {
          await _scrollController.animateTo(
            0,
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }

        return;
      }
    });
  }

  void _handleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      _isScrollingToBottom = true;

      _scrollToBottomController.reverse();

      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.animateTo(
          0,
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
      if (_scrollController.offset > 0) {
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
        if (_scrollController.hasClients && mounted) {
          // Hide loading indicator now that pagination is complete
          context.read<LoadMoreNotifier>().setLoading(false);
        }
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
    if (index < 0 || index >= _chatController.messages.length) {
      return;
    }

    // Transform the content index to visual index for the reversed list
    final currentIndex = max(_chatController.messages.length - 1 - index, 0);

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
          index: currentIndex,
          alignment: alignment,
          offset: (targetOffset) => offset,
          renderSliverType: ObserverRenderSliverType.list,
        );
      } else {
        await _observerController.animateTo(
          index: currentIndex,
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
    if (_userHasScrolled && _scrollController.offset <= 0) {
      _userHasScrolled = false;
    }

    // Use animation duration resolver if provided, otherwise use default duration.
    final duration =
        widget.insertAnimationDurationResolver != null
            ? (widget.insertAnimationDurationResolver!(data) ??
                widget.insertAnimationDuration)
            : widget.insertAnimationDuration;

    _listKey.currentState!.insertItem(
      max(_oldList.length - 1 - position, 0).toInt(),
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
    final visualPosition = max(_oldList.length - position - 1, 0);
    _listKey.currentState!.removeItem(
      visualPosition,
      (context, animation) => widget.itemBuilder(
        context,
        data,
        visualPosition,
        animation,
        messageGroupingTimeoutInSeconds: widget.messageGroupingTimeoutInSeconds,
        isRemoved: true,
      ),
      duration: duration,
    );
  }

  void _onChanged(int position, Message oldData, Message newData) {
    // Use animation duration resolver if provided, otherwise use default duration.
    final duration =
        widget.insertAnimationDurationResolver != null
            ? (widget.insertAnimationDurationResolver!(newData) ??
                widget.insertAnimationDuration)
            : widget.insertAnimationDuration;

    _onRemoved(position, oldData);
    _listKey.currentState!.insertItem(
      max(_oldList.length - position - 1, 0),
      duration: duration,
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
