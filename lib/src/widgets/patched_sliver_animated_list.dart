import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// NOTE: See here for an explanation of the fix:
/// https://github.com/flutter/flutter/pull/108710
/// Remove this file and replace with the upstream version once the fix is merged.

/// Signature for the builder callback used by [AnimatedList].
typedef AnimatedListItemBuilder = Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
);

/// Signature for the builder callback used by [AnimatedListState.removeItem].
typedef AnimatedListRemovedItemBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
);

// The default insert/remove animation duration.
const Duration _kDuration = Duration(milliseconds: 300);

// Incoming and outgoing AnimatedList items.
class _ActiveItem implements Comparable<_ActiveItem> {
  _ActiveItem.incoming(this.controller, this.itemIndex)
      : removedItemBuilder = null;
  _ActiveItem.outgoing(
    this.controller,
    this.itemIndex,
    this.removedItemBuilder,
  );
  _ActiveItem.index(this.itemIndex)
      : controller = null,
        removedItemBuilder = null;

  final AnimationController? controller;
  final AnimatedListRemovedItemBuilder? removedItemBuilder;
  int itemIndex;

  @override
  int compareTo(_ActiveItem other) => itemIndex - other.itemIndex;
}

/// A sliver that animates items when they are inserted or removed.
///
/// This widget's [PatchedSliverAnimatedListState] can be used to dynamically insert or
/// remove items. To refer to the [PatchedSliverAnimatedListState] either provide a
/// [GlobalKey] or use the static [PatchedSliverAnimatedList.of] method from an item's
/// input callback.
///
/// {@tool dartpad}
/// This sample application uses a [PatchedSliverAnimatedList] to create an animated
/// effect when items are removed or added to the list.
///
/// ** See code in examples/api/lib/widgets/animated_list/sliver_animated_list.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [SliverList], which does not animate items when they are inserted or
///    removed.
///  * [AnimatedList], a non-sliver scrolling container that animates items when
///    they are inserted or removed.
class PatchedSliverAnimatedList extends StatefulWidget {
  /// Creates a sliver that animates items when they are inserted or removed.
  const PatchedSliverAnimatedList({
    super.key,
    required this.itemBuilder,
    this.findChildIndexCallback,
    this.initialItemCount = 0,
  }) : assert(initialItemCount >= 0);

  /// Called, as needed, to build list item widgets.
  ///
  /// List items are only built when they're scrolled into view.
  ///
  /// The [AnimatedListItemBuilder] index parameter indicates the item's
  /// position in the list. The value of the index parameter will be between 0
  /// and [initialItemCount] plus the total number of items that have been
  /// inserted with [PatchedSliverAnimatedListState.insertItem] and less the total
  /// number of items that have been removed with
  /// [PatchedSliverAnimatedListState.removeItem].
  ///
  /// Implementations of this callback should assume that
  /// [PatchedSliverAnimatedListState.removeItem] removes an item immediately.
  final AnimatedListItemBuilder itemBuilder;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.findChildIndexCallback}
  final ChildIndexGetter? findChildIndexCallback;

  /// {@macro flutter.widgets.animatedList.initialItemCount}
  final int initialItemCount;

  @override
  PatchedSliverAnimatedListState createState() =>
      PatchedSliverAnimatedListState();
}

class PatchedSliverAnimatedListState extends State<PatchedSliverAnimatedList>
    with TickerProviderStateMixin {
  final List<_ActiveItem> _incomingItems = <_ActiveItem>[];
  final List<_ActiveItem> _outgoingItems = <_ActiveItem>[];
  int _itemsCount = 0;

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.initialItemCount;
  }

  @override
  void dispose() {
    for (final item in _incomingItems.followedBy(_outgoingItems)) {
      item.controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: _createDelegate(),
      );

  /// Insert an item at [index] and start an animation that will be passed to
  /// [PatchedSliverAnimatedList.itemBuilder] when the item is visible.
  ///
  /// This method's semantics are the same as Dart's [List.insert] method:
  /// it increases the length of the list by one and shifts all items at or
  /// after [index] towards the end of the list.
  void insertItem(int index, {Duration duration = _kDuration}) {
    assert(index >= 0);

    final itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex <= _itemsCount);

    // Increment the incoming and outgoing item indices to account
    // for the insertion.
    for (final item in _incomingItems) {
      if (item.itemIndex >= itemIndex) {
        item.itemIndex += 1;
      }
    }
    for (final item in _outgoingItems) {
      if (item.itemIndex >= itemIndex) {
        item.itemIndex += 1;
      }
    }

    final controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    final incomingItem = _ActiveItem.incoming(
      controller,
      itemIndex,
    );
    setState(() {
      _incomingItems
        ..add(incomingItem)
        ..sort();
      _itemsCount += 1;
    });

    controller.forward().then<void>((_) {
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex)!
          .controller!
          .dispose();
    });
  }

  /// Remove the item at [index] and start an animation that will be passed
  /// to [builder] when the item is visible.
  ///
  /// Items are removed immediately. After an item has been removed, its index
  /// will no longer be passed to the [PatchedSliverAnimatedList.itemBuilder]. However
  /// the item will still appear in the list for [duration] and during that time
  /// [builder] must construct its widget as needed.
  ///
  /// This method's semantics are the same as Dart's [List.remove] method:
  /// it decreases the length of the list by one and shifts all items at or
  /// before [index] towards the beginning of the list.
  void removeItem(
    int index,
    AnimatedListRemovedItemBuilder builder, {
    Duration duration = _kDuration,
  }) {
    assert(index >= 0);

    final itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex < _itemsCount);
    assert(_activeItemAt(_outgoingItems, itemIndex) == null);

    final incomingItem = _removeActiveItemAt(_incomingItems, itemIndex);
    final controller = incomingItem?.controller ??
        AnimationController(duration: duration, value: 1.0, vsync: this);
    final outgoingItem = _ActiveItem.outgoing(controller, itemIndex, builder);
    setState(() {
      _outgoingItems
        ..add(outgoingItem)
        ..sort();
    });

    controller.reverse().then<void>((void value) {
      _removeActiveItemAt(_outgoingItems, outgoingItem.itemIndex)!
          .controller!
          .dispose();

      // Decrement the incoming and outgoing item indices to account
      // for the removal.
      for (final item in _incomingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) {
          item.itemIndex -= 1;
        }
      }
      for (final item in _outgoingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) {
          item.itemIndex -= 1;
        }
      }

      setState(() => _itemsCount -= 1);
    });
  }

  _ActiveItem? _removeActiveItemAt(List<_ActiveItem> items, int itemIndex) {
    final i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items.removeAt(i);
  }

  _ActiveItem? _activeItemAt(List<_ActiveItem> items, int itemIndex) {
    final i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items[i];
  }

  // The insertItem() and removeItem() index parameters are defined as if the
  // removeItem() operation removed the corresponding list entry immediately.
  // The entry is only actually removed from the ListView when the remove animation
  // finishes. The entry is added to _outgoingItems when removeItem is called
  // and removed from _outgoingItems when the remove animation finishes.

  int _indexToItemIndex(int index) {
    var itemIndex = index;
    for (final item in _outgoingItems) {
      if (item.itemIndex <= itemIndex) {
        itemIndex += 1;
      } else {
        break;
      }
    }
    return itemIndex;
  }

  int _itemIndexToIndex(int itemIndex) {
    var index = itemIndex;
    for (final item in _outgoingItems) {
      assert(item.itemIndex != itemIndex);
      if (item.itemIndex < itemIndex) {
        index -= 1;
      } else {
        break;
      }
    }
    return index;
  }

  SliverChildDelegate _createDelegate() => SliverChildBuilderDelegate(
        _itemBuilder,
        childCount: _itemsCount,
        findChildIndexCallback: widget.findChildIndexCallback == null
            ? null
            : (Key key) {
                final index = widget.findChildIndexCallback!(key);
                return index != null ? _indexToItemIndex(index) : null;
              },
      );

  Widget _itemBuilder(BuildContext context, int itemIndex) {
    final outgoingItem = _activeItemAt(_outgoingItems, itemIndex);
    if (outgoingItem != null) {
      return outgoingItem.removedItemBuilder!(
        context,
        outgoingItem.controller!.view,
      );
    }

    final incomingItem = _activeItemAt(_incomingItems, itemIndex);
    final animation =
        incomingItem?.controller?.view ?? kAlwaysCompleteAnimation;
    return widget.itemBuilder(
      context,
      _itemIndexToIndex(itemIndex),
      animation,
    );
  }
}
