import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter_chat_core/flutter_chat_core.dart';

/// A [diffutil.ListDiffDelegate] implementation for comparing lists of [Message] objects.
///
/// Used by `diffutil_dart` to calculate differences between old and new message lists
/// for efficient updates in animated lists.
class MessageListDiff extends diffutil.ListDiffDelegate<Message> {
  /// Creates a diff delegate for comparing two message lists.
  MessageListDiff(super.oldList, super.newList);

  /// Checks if the content of two messages at the given positions is the same.
  /// Uses [equalityChecker] from `freezed_annotation` for deep comparison.
  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
      equalityChecker(oldList[oldItemPosition], newList[newItemPosition]);

  /// Checks if two messages at the given positions represent the same item.
  /// Compares messages based on their unique [id].
  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
      oldList[oldItemPosition].id == newList[newItemPosition].id;
}
