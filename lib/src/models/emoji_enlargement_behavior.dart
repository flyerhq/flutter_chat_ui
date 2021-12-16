/// Used to control the enlargement behavior of the emojis in the
/// [types.TextMessage].
enum EmojiEnlargementBehavior {
  /// The emojis will be enlarged only if the [types.TextMessage] consists of
  /// one or more emojis.
  multi,

  /// Never enlarge emojis.
  never,

  /// The emoji will be enlarged only if the [types.TextMessage] consists of
  /// a single emoji.
  single,
}
