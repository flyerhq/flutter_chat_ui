import 'dart:ui';

import 'chat_theme.dart';

/// Extension methods for [ChatTheme] to simplify modifications.
extension ChatThemeExtensions on ChatTheme {
  /// Creates a copy of the theme with updated light colors.
  ///
  /// Uses [ChatColors.light] as the base and overrides specified colors.
  ChatTheme withLightColors({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? onSurface,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
  }) {
    final light = ChatColors.light();
    return copyWith(
      colors: light.copyWith(
        primary: primary ?? light.primary,
        onPrimary: onPrimary ?? light.onPrimary,
        surface: surface ?? light.surface,
        onSurface: onSurface ?? light.onSurface,
        surfaceContainer: surfaceContainer ?? light.surfaceContainer,
        surfaceContainerLow: surfaceContainerLow ?? light.surfaceContainerLow,
        surfaceContainerHigh:
            surfaceContainerHigh ?? light.surfaceContainerHigh,
      ),
    );
  }

  /// Creates a copy of the theme with updated dark colors.
  ///
  /// Uses [ChatColors.dark] as the base and overrides specified colors.
  ChatTheme withDarkColors({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? onSurface,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
  }) {
    final dark = ChatColors.dark();
    return copyWith(
      colors: dark.copyWith(
        primary: primary ?? dark.primary,
        onPrimary: onPrimary ?? dark.onPrimary,
        surface: surface ?? dark.surface,
        onSurface: onSurface ?? dark.onSurface,
        surfaceContainer: surfaceContainer ?? dark.surfaceContainer,
        surfaceContainerLow: surfaceContainerLow ?? dark.surfaceContainerLow,
        surfaceContainerHigh: surfaceContainerHigh ?? dark.surfaceContainerHigh,
      ),
    );
  }
}
