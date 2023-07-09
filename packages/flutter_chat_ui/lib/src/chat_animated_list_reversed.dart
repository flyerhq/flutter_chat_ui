import 'dart:async';
import 'dart:math';

import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';

class ChatAnimatedListReversed extends StatefulWidget {
  const ChatAnimatedListReversed({
    super.key,
    required this.itemBuilder,
    required this.scrollController,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
    this.scrollToEndAnimationDuration = const Duration(milliseconds: 250),
  });

  final Widget Function(
    BuildContext,
    Animation<double>,
    Message, {
    bool? isRemoved,
  }) itemBuilder;
  final ScrollController scrollController;
  final Duration insertAnimationDuration;
  final Duration removeAnimationDuration;
  final Duration scrollToEndAnimationDuration;

  @override
  ChatAnimatedListReversedState createState() =>
      ChatAnimatedListReversedState();
}

class ChatAnimatedListReversedState extends State<ChatAnimatedListReversed> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late ChatController _chatController;
  late List<Message> _oldList;
  late StreamSubscription<ChatOperation> _operationsSubscription;

  bool _userHasScrolled = false;
  // This flag is used to determine if we already adjusted the initial
  // scroll position (so we can see latest messages when we enter chat)
  bool _needsInitialScrollPositionAdjustment = true;
  String _lastInsertedMessageId = '';

  @override
  void initState() {
    super.initState();
    _chatController = Provider.of<ChatController>(context, listen: false);
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
  }

  @override
  void dispose() {
    super.dispose();
    _operationsSubscription.cancel();
  }

  void _initialScrollToEnd() async {
    // Delay the scroll to the end animation so new message is painted, otherwise
    // maxScrollExtent is not yet updated and the animation might not work.
    await Future.delayed(widget.insertAnimationDuration);

    if (!widget.scrollController.hasClients || !mounted) return;

    if (widget.scrollController.offset <
        widget.scrollController.position.maxScrollExtent) {
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
  }

  void _subsequentScrollToEnd(Message data) async {
    final userId = Provider.of<String>(context, listen: false);

    // In this case we only want to scroll to the bottom if user has not scrolled up
    // or if the message is sent by the current user.
    if (data.id == _lastInsertedMessageId &&
        widget.scrollController.offset <
            widget.scrollController.position.maxScrollExtent &&
        (userId == data.senderId || !_userHasScrolled)) {
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

      if (!widget.scrollController.hasClients || !mounted) return;

      // Because of the issue I have opened here https://github.com/flutter/flutter/issues/129768
      // we need an additional jump to the end. Sometimes Flutter
      // will not scroll to the very end. Sometimes it will not scroll to the
      // very end even with this, so this is something that needs to be
      // addressed by the Flutter team.
      //
      // Additionally here we have a check for the message id, because
      // if new message arrives in the meantime it will trigger another
      // scroll to the end animation, making this logic redundant.
      if (data.id == _lastInsertedMessageId &&
          widget.scrollController.offset <
              widget.scrollController.position.maxScrollExtent &&
          (userId == data.senderId || !_userHasScrolled)) {
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent);
      }
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

  void _onInserted(final int position, final Message data) {
    final userId = Provider.of<String>(context, listen: false);

    // There is a scroll notification listener the controls the `_userHasScrolled` variable.
    // However, when a new message is sent by the current user we want to
    // set `_userHasScrolled` to false so that the scroll animation is triggered.
    //
    // Also, if for some reason `_userHasScrolled` is true and the user is not at the bottom of the list,
    // set `_userHasScrolled` to false so that the scroll animation is triggered.
    if (userId == data.senderId ||
        (_userHasScrolled == true &&
            widget.scrollController.offset >=
                widget.scrollController.position.maxScrollExtent)) {
      _userHasScrolled = false;
    }

    _listKey.currentState!.insertItem(
      position,
      duration: widget.insertAnimationDuration,
    );

    // Used later to trigger scroll to end only for the last inserted message.
    _lastInsertedMessageId = data.id;

    // _scrollToEnd(data);
  }

  void _onRemoved(final int position, final Message data) {
    final visualPosition = max(_oldList.length - position - 1, 0);
    _listKey.currentState!.removeItem(
      visualPosition,
      (context, animation) => widget.itemBuilder(
        context,
        animation,
        data,
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

  @override
  Widget build(BuildContext context) {
    return NotificationListener<Notification>(
      onNotification: (notification) {
        // Handle initial scroll to bottom so you see latest messages
        if (notification is ScrollMetricsNotification) {
          // _adjustInitialScrollPosition(notification);
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

        // Allow other listeners to get the notification
        return false;
      },
      child: CustomScrollView(
        reverse: true,
        controller: widget.scrollController,
        slivers: <Widget>[
          Consumer<ChatInputHeightNotifier>(
            builder: (context, heightNotifier, child) {
              return SliverPadding(
                padding: heightNotifier.height != 0
                    ? EdgeInsets.only(top: heightNotifier.height + 20)
                    : EdgeInsets.zero,
              );
            },
          ),
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: _chatController.messages.length,
            itemBuilder: (
              BuildContext context,
              int index,
              Animation<double> animation,
            ) {
              final message = _chatController.messages[
                  max(_chatController.messages.length - 1 - index, 0)];
              return widget.itemBuilder(
                context,
                animation,
                message,
              );
            },
          ),
        ],
      ),
    );
  }
}

class MessageListDiff extends diffutil.ListDiffDelegate<Message> {
  MessageListDiff(super.oldList, super.newList);

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
      equalityChecker(oldList[oldItemPosition], newList[newItemPosition]);

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
      oldList[oldItemPosition].id == newList[newItemPosition].id;
}
