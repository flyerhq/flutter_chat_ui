import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

extension ReactionsTheme on ChatTheme {
  Color get reactionBackgroundColor => colors.surfaceContainer;
  Color get reactionReactedBackgroundColor => colors.surfaceContainerHighest;
  Color get reactionBorderColor => colors.surface;

  Color get reactionCountTextColor => colors.onSurface;
  TextStyle get reactionEmojiTextStyle => typography.bodyMedium;
  TextStyle get reactionCountTextStyle =>
      typography.bodySmall.copyWith(fontWeight: FontWeight.bold);
  TextStyle get reactionSurplusTextStyle =>
      typography.bodySmall.copyWith(fontWeight: FontWeight.bold);
}
