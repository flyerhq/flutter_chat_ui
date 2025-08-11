import 'package:flutter_chat_core/flutter_chat_core.dart';

class Reaction {
  final String emoji;
  final bool isReactedByUser;
  final int count;
  final List<String> userIds;

  Reaction({
    required this.emoji,
    required this.count,
    required this.isReactedByUser,
    required this.userIds,
  });

  @override
  String toString() {
    return 'Reaction(emoji: $emoji, count: $count, isReactedByUser: $isReactedByUser, userIds: $userIds)';
  }
}

/// Converts a map of reactions to a list of [Reaction] objects
///
/// [reactions] is a map [MessageReactions] where keys are emoji strings and values are lists of user IDs
/// [currentUserId] is used to determine if the current user has reacted
List<Reaction> reactionsFromMessageReactions({
  required MessageReactions? reactions,
  required String currentUserId,
}) {
  if (reactions == null) {
    return [];
  }
  return reactions.entries.map((entry) {
    final emoji = entry.key;
    final users = entry.value;
    return Reaction(
      emoji: emoji,
      count: users.length,
      isReactedByUser: users.contains(currentUserId),
      userIds: users,
    );
  }).toList();
}

/// Get the list of reactions that the user has reacted to
///
/// [reactions] is a map [MessageReactions] where keys are emoji strings and values are lists of user IDs
/// [currentUserId] is used to determine if the current user has reacted
List<String> getUserReactions(
  Map<String, List<String>>? reactions,
  String currentUserId,
) {
  if (reactions == null) {
    return [];
  }
  return reactions.entries
      .where((entry) => entry.value.contains(currentUserId))
      .map((entry) => entry.key)
      .toList();
}
