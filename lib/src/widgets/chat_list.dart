import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
    required this.itemBuilder,
    required this.items,
  }) : super(key: key);

  final List<Object> items;
  final Widget Function(Object, int? index) itemBuilder;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  late List<Object> oldData = List.from(widget.items);

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _calculateDiffs(oldWidget.items);
  }

  void _calculateDiffs(List<Object> oldList) async {
    final diffResult = calculateListDiff<Object>(
      oldList,
      widget.items,
      equalityChecker: (item1, item2) {
        if (item1 is Map<String, Object> && item2 is Map<String, Object>) {
          final message1 = item1['message']! as types.Message;
          final message2 = item2['message']! as types.Message;

          return message1.id == message2.id;
        } else {
          return item1 == item2;
        }
      },
    );

    for (final update in diffResult.getUpdates(batch: false)) {
      update.when(
        insert: (pos, count) => _listKey.currentState?.insertItem(pos),
        remove: (pos, count) {
          final item = oldList[pos];
          _listKey.currentState?.removeItem(
            pos,
            (_, animation) => _buildRemovedMessage(item, animation),
          );
        },
        change: (pos, payload) =>
            print('changed on $pos with payload $payload'),
        move: (from, to) => print('move $from to $to'),
      );
    }

    oldData = List.from(widget.items);
  }

  Widget _buildRemovedMessage(Object item, Animation<double> animation) {
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
      child: FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        child: widget.itemBuilder(item, null),
      ),
    );
  }

  Widget _buildNewMessage(int index, Animation<double> animation) {
    try {
      final item = oldData[index];

      return SizeTransition(
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
        child: widget.itemBuilder(item, index),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      reverse: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          sliver: SliverAnimatedList(
            initialItemCount: widget.items.length,
            key: _listKey,
            itemBuilder: (_, index, animation) =>
                _buildNewMessage(index, animation),
          ),
        ),
      ],
    );
  }
}
