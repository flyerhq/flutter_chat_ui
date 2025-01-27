import 'dart:async';
import 'dart:math';

import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../scroll_to_bottom.dart';
import '../utils/chat_input_height_notifier.dart';
import '../utils/keyboard_mixin.dart';
import '../utils/message_list_diff.dart';

enum InitialScrollToEndMode { none, jump, animate }

class ChatAnimatedList extends StatefulWidget {
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
  final InitialScrollToEndMode? initialScrollToEndMode;
  final bool? shouldScrollToEndWhenSendingMessage;
  final bool? shouldScrollToEndWhenAtBottom;

  const ChatAnimatedList({
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
    this.initialScrollToEndMode = InitialScrollToEndMode.jump,
    this.shouldScrollToEndWhenSendingMessage = true,
    this.shouldScrollToEndWhenAtBottom = true,
  });

  @override
  ChatAnimatedListState createState() => ChatAnimatedListState();
}

class ChatAnimatedListState extends State<ChatAnimatedList>
    with TickerProviderStateMixin, WidgetsBindingObserver, KeyboardMixin {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late final ChatController _chatController;
  late final SliverObserverController _observerController;
  late List<Message> _oldList;
  late final StreamSubscription<ChatOperation> _operationsSubscription;

  // Used by scrollview_observer to allow for scroll to specific item
  BuildContext? _sliverListViewContext;

  late final AnimationController _scrollController;
  late final AnimationController _scrollToBottomController;
  late final Animation<double> _scrollToBottomAnimation;
  Timer? _scrollToBottomShowTimer;

  bool _userHasScrolled = false;
  bool _isScrollingToBottom = false;
  // This flag is used to determine if we already adjusted the initial
  // scroll position (so we can see latest messages when we enter chat)
  late bool _needsInitialScrollPositionAdjustment;
  String _lastInsertedMessageId = '';

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

          final updates = diffutil
              .calculateDiff<Message>(
                MessageListDiff(_oldList, newList),
              )
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

    _scrollController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
    _scrollController.addListener(_linkAnimationToScroll);

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
  }

  @override
  void onKeyboardHeightChanged(double height) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!mounted || !widget.scrollController.hasClients || height == 0) {
          return;
        }

        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          widget.scrollController.jumpTo(
            min(
              widget.scrollController.offset + height,
              widget.scrollController.position.maxScrollExtent,
            ),
          );
        } else {
          await widget.scrollController.animateTo(
            min(
              widget.scrollController.offset + height,
              widget.scrollController.position.maxScrollExtent,
            ),
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }
        // we don't want to show the scroll to bottom button when automatically scrolling content with keyboard
        _scrollToBottomShowTimer?.cancel();
      },
    );
  }

  @override
  void dispose() {
    _scrollToBottomShowTimer?.cancel();
    _scrollToBottomController.dispose();
    _scrollController.removeListener(_linkAnimationToScroll);
    _scrollController.dispose();
    _operationsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final builders = context.watch<Builders>();

    return NotificationListener<Notification>(
      onNotification: (notification) {
        // Handle initial scroll to bottom so you see latest messages
        if (notification is ScrollMetricsNotification) {
          _adjustInitialScrollPosition(notification);
          _handleToggleScrollToBottom();
        }

        if (notification is UserScrollNotification) {
          // When user scrolls up, save it to `_userHasScrolled`
          if (notification.direction == ScrollDirection.forward) {
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
            sliverContexts: () => [
              if (_sliverListViewContext != null) _sliverListViewContext!,
            ],
            child: CustomScrollView(
              controller: widget.scrollController,
              keyboardDismissBehavior: widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              slivers: <Widget>[
                if (widget.topPadding != null)
                  SliverPadding(
                    padding: EdgeInsets.only(top: widget.topPadding!),
                  ),
                if (widget.topSliver != null) widget.topSliver!,
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
                    );
                  },
                ),
                if (widget.bottomSliver != null) widget.bottomSliver!,
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
    widget.scrollController.jumpTo(
      _scrollController.value *
          widget.scrollController.position.maxScrollExtent,
    );
  }

  void _initialScrollToEnd() async {
    // Delay the scroll to the end animation so new message is painted, otherwise
    // maxScrollExtent is not yet updated and the animation might not work.
    await Future.delayed(widget.insertAnimationDuration);

    if (!widget.scrollController.hasClients || !mounted) return;

    if (widget.scrollController.offset >=
        widget.scrollController.position.maxScrollExtent) {
      return;
    }

    if (widget.scrollToEndAnimationDuration == Duration.zero) {
      widget.scrollController
          .jumpTo(widget.scrollController.position.maxScrollExtent);
    } else {
      await widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
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
        widget.scrollController.offset >=
            widget.scrollController.position.maxScrollExtent) {
      return;
    }

    // When user hasn't manually scrolled up, automatically scroll to show new messages.
    // This matches typical chat behavior where you stay at the bottom to see incoming
    // messages unless you've explicitly scrolled up to view history.
    // After scrolling, exit the function since no other scroll behavior is needed.
    if (widget.shouldScrollToEndWhenAtBottom == true && !_userHasScrolled) {
      if (widget.scrollToEndAnimationDuration == Duration.zero) {
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent);
      } else {
        await widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
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
        currentUserId == data.authorId) {
      // When scrolled up in chat history use fling to guarantee scrolling
      // to the very end of the list.
      // See https://stackoverflow.com/a/77175903 for more details.
      if (_userHasScrolled) {
        _scrollController.value = widget.scrollController.position.pixels /
            widget.scrollController.position.maxScrollExtent;
        await _scrollController.fling();
      } else {
        if (widget.scrollToEndAnimationDuration == Duration.zero) {
          widget.scrollController
              .jumpTo(widget.scrollController.position.maxScrollExtent);
        } else {
          await widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            duration: widget.scrollToEndAnimationDuration,
            curve: Curves.linearToEaseOut,
          );
        }
      }
      return;
    }
  }

  void _scrollToEnd(Message data) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!widget.scrollController.hasClients || !mounted) return;

        // We need this condition because if scroll view is not yet scrollable,
        // we want to wait for the insert animation to finish before scrolling to the end.
        if (widget.scrollController.position.maxScrollExtent == 0) {
          // Scroll view is not yet scrollable, scroll to the end if
          // new message makes it scrollable.
          _initialScrollToEnd();
        } else {
          _subsequentScrollToEnd(data);
        }
      },
    );
  }

  void _adjustInitialScrollPosition(ScrollMetricsNotification notification) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!widget.scrollController.hasClients || !mounted) return;

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
            widget.scrollController
                .jumpTo(notification.metrics.maxScrollExtent);
          }
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

        _scrollController.value = widget.scrollController.position.pixels /
            widget.scrollController.position.maxScrollExtent;
        _scrollController.fling();

        _userHasScrolled = false;
        _isScrollingToBottom = false;
      },
    );
  }

  void _handleToggleScrollToBottom() {
    if (!_isScrollingToBottom) {
      _scrollToBottomShowTimer?.cancel();
      if (widget.scrollController.offset <
          widget.scrollController.position.maxScrollExtent) {
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

  void _onInserted(final int position, final Message data) {
    // If for some reason `_userHasScrolled` is true and the user is not at the bottom of the list,
    // set `_userHasScrolled` to false so that the scroll to end animation is triggered.
    if (_userHasScrolled &&
        widget.scrollController.offset >=
            widget.scrollController.position.maxScrollExtent) {
      _userHasScrolled = false;
    }

    _listKey.currentState!.insertItem(
      position,
      // We are only animating items when scroll view is not yet scrollable,
      // otherwise we just insert the item without animation.
      // (animation is replaced with scroll to bottom animation)
      duration: widget.scrollController.position.maxScrollExtent == 0
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
