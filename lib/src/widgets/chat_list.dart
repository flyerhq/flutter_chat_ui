import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// Animated list that handles automatic animations and pagination.
class ChatList extends StatefulWidget {
  /// Creates a chat list widget.
  const ChatList({
    super.key,
    this.isLastPage,
    required this.itemBuilder,
    required this.items,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.scrollController,
    this.scrollPhysics,
  });

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// When true, indicates that there are no more pages to load and
  /// pagination will not be triggered.
  final bool? isLastPage;

  /// Item builder.
  final Widget Function(Object, int? index) itemBuilder;

  /// Items to build.
  final List<Object> items;

  /// Used for pagination (infinite scroll). Called when user scrolls
  /// to the very end of the list (minus [onEndReachedThreshold]).
  final Future<void> Function()? onEndReached;

  /// A representation of how a [ScrollView] should dismiss the on-screen keyboard.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// Can be anything from 0 to 1, where 0 is immediate load of the next page
  /// as soon as scroll starts, and 1 is load of the next page only if scrolled
  /// to the very end of the list. Default value is 0.75, e.g. start loading
  /// next page when scrolled through about 3/4 of the available content.
  final double? onEndReachedThreshold;

  /// Used to control the chat list scroll view.
  final ScrollController? scrollController;

  /// Determines the physics of the scroll view.
  final ScrollPhysics? scrollPhysics;

  @override
  State<ChatList> createState() => _ChatListState();
}

/// [ChatList] widget state.
class _ChatListState extends State<ChatList>
    with SingleTickerProviderStateMixin {
  final Set<String> seenIds = {};
  late final Animation<double> _animation = CurvedAnimation(
    curve: Curves.easeOutQuad,
    parent: _controller,
  );

  late final AnimationController _controller = AnimationController(vsync: this);

  bool _isNextPageLoading = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = widget.scrollController ?? ScrollController();
    for (final item in widget.items) {
      _mapMessage(item, (message) {
        seenIds.add(message.id);
      });
    }
    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _scrollToBottomIfNeeded(oldWidget.items);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (widget.onEndReached == null || widget.isLastPage == true) {
            return false;
          }

          if (notification.metrics.pixels >=
              (notification.metrics.maxScrollExtent *
                  (widget.onEndReachedThreshold ?? 0.75))) {
            if (widget.items.isEmpty || _isNextPageLoading) return false;

            _controller.duration = Duration.zero;
            _controller.forward();

            setState(() {
              _isNextPageLoading = true;
            });

            widget.onEndReached!().whenComplete(() {
              _controller.duration = const Duration(milliseconds: 300);
              _controller.reverse();

              setState(() {
                _isNextPageLoading = false;
              });
            });
          }

          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          physics: widget.scrollPhysics,
          reverse: true,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 4),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = widget.items[index];
                    final animate = _mapMessage(
                          item,
                          (message) => seenIds.add(message.id), // returns true if item not yet in the set
                        ) ??
                        false;
                    return AnimatedMessage(
                      key: _valueKeyForItem(item),
                      child: widget.itemBuilder(item, index),
                      animate: animate,
                    );
                  },
                  findChildIndexCallback: (Key key) {
                    if (key is ValueKey<Object>) {
                      final newIndex = widget.items.indexWhere(
                        (v) => _valueKeyForItem(v) == key,
                      );
                      if (newIndex != -1) {
                        return newIndex;
                      }
                    }
                    return null;
                  },
                  childCount: widget.items.length,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 16 + (kIsWeb ? 0 : MediaQuery.of(context).padding.top),
              ),
              sliver: SliverToBoxAdapter(
                child: SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: _animation,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 32,
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: _isNextPageLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  InheritedChatTheme.of(context)
                                      .theme
                                      .primaryColor,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // Hacky solution to reconsider.
  void _scrollToBottomIfNeeded(List<Object> oldList) {
    try {
      // Take index 1 because there is always a spacer on index 0.
      final oldItem = oldList[1];
      final item = widget.items[1];
      _mapMessage(
        oldItem,
        (oldMessage) => _mapMessage(item, (message) {
          // Compare items to fire only on newly added messages.
          if (oldMessage != message) {
            // Run only for sent message.
            if (message.author.id == InheritedUser.of(context).user.id) {
              // Delay to give some time for Flutter to calculate new
              // size after new message was added
              Future.delayed(const Duration(milliseconds: 100), () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInQuad,
                  );
                }
              });
            }
          }
        }),
      );
    } catch (e) {
      // Do nothing if there are no items.
    }
  }

  Key? _valueKeyForItem(Object item) =>
      _mapMessage(item, (message) => ValueKey(message.id));

  T? _mapMessage<T>(Object maybeMessage, T Function(types.Message) f) {
    if (maybeMessage is Map<String, Object>) {
      return f(maybeMessage['message'] as types.Message);
    }
    return null;
  }
}

class AnimatedMessage extends StatefulWidget {
  final bool animate; // just show the message without animation if set to false

  const AnimatedMessage({
    super.key,
    required this.child,
    this.animate = true,
  });

  final Widget child;

  @override
  _AnimatedMessageState createState() => _AnimatedMessageState();
}

class _AnimatedMessageState extends State<AnimatedMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad,
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
        axisAlignment: -1,
        sizeFactor: _animation,
        child: widget.child,
      );
}
