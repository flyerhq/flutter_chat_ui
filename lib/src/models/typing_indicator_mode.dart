/// Used to toggle the display of avatars, text or both on [TypingIndicator].
enum TypingIndicatorMode {
  /// Show [Text] for typing users.
  text,

  /// Show [UserAvatar] instead of text for typing users.
  avatar,

  /// Show both [Text] and [UserAvatar] for typing users.
  both,
}
