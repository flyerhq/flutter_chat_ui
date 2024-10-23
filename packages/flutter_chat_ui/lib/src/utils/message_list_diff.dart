import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter_chat_core/flutter_chat_core.dart';

class MessageListDiff extends diffutil.ListDiffDelegate<Message> {
  MessageListDiff(super.oldList, super.newList);

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
      equalityChecker(oldList[oldItemPosition], newList[newItemPosition]);

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
      oldList[oldItemPosition].id == newList[newItemPosition].id;
}
