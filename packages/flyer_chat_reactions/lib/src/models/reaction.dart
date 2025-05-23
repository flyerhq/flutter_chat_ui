import 'package:flutter_chat_core/flutter_chat_core.dart';

class Reaction {
  final String emoji;
  final int count;
  final bool reactedByUser;

  Reaction({
    required this.emoji,
    required this.count,
    required this.reactedByUser,
  });
}

/// Converts a map of reactions to a list of [Reaction] objects
///
/// [reactions] is a map [MessageReactions] where keys are emoji strings and values are lists of user IDs
/// [currentUserId] is used to determine if the current user has reacted
List<Reaction> reactionsFromMessageReactions({
  required MessageReactions reactions,
  required String currentUserId,
}) {
  return reactions.entries.map((entry) {
    final emoji = entry.key;
    final userIds = entry.value;
    return Reaction(
      emoji: emoji,
      count: userIds.length,
      reactedByUser: userIds.contains(currentUserId),
    );
  }).toList();
}
