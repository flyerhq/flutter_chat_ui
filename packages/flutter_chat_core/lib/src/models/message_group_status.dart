/// Represents the grouping status of a message within a sequence of messages
/// from the same author sent close together in time.
class MessageGroupStatus {
  /// True if this is the first message in the group.
  final bool isFirst;

  /// True if this is the last message in the group.
  final bool isLast;

  /// True if this is a message in the middle of the group (neither first nor last).
  final bool isMiddle;

  /// Creates a [MessageGroupStatus] instance.
  const MessageGroupStatus({
    required this.isFirst,
    required this.isLast,
    required this.isMiddle,
  });
}
