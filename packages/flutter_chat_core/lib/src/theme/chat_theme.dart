import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_theme.freezed.dart';

@freezed
class ChatTheme with _$ChatTheme {
  const factory ChatTheme({
    required ChatColors colors,
    required ChatTypography typography,
    required BorderRadiusGeometry shape,
  }) = _ChatTheme;

  const ChatTheme._();

  factory ChatTheme.light({String? fontFamily}) => ChatTheme(
        colors: ChatColors.light(),
        typography: ChatTypography.standard(fontFamily: fontFamily),
        shape: const BorderRadius.all(Radius.circular(12)),
      );

  factory ChatTheme.dark({String? fontFamily}) => ChatTheme(
        colors: ChatColors.dark(),
        typography: ChatTypography.standard(fontFamily: fontFamily),
        shape: const BorderRadius.all(Radius.circular(12)),
      );

  factory ChatTheme.fromThemeData(ThemeData themeData) => ChatTheme(
        colors: ChatColors.fromThemeData(themeData),
        typography: ChatTypography.fromThemeData(themeData),
        shape: const BorderRadius.all(Radius.circular(12)),
      );

  ChatTheme merge(ChatTheme? other) {
    if (other == null) return this;
    return copyWith(
      colors: colors.merge(other.colors),
      typography: typography.merge(other.typography),
      shape: other.shape,
    );
  }
}

@freezed
class ChatColors with _$ChatColors {
  const factory ChatColors({
    required Color primary,
    required Color onPrimary,
    required Color surface,
    required Color onSurface,
    required Color surfaceContainer,
    required Color surfaceContainerLow,
    required Color surfaceContainerHigh,
  }) = _ChatColors;

  const ChatColors._();

  factory ChatColors.light() => const ChatColors(
        primary: Color(0xff4169e1),
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xff101010),
        surfaceContainerLow: Color(0xfffafafa),
        surfaceContainer: Color(0xfff5f5f5),
        surfaceContainerHigh: Color(0xffeeeeee),
      );

  factory ChatColors.dark() => const ChatColors(
        primary: Color(0xff4169e1),
        onPrimary: Colors.white,
        surface: Color(0xff101010),
        onSurface: Colors.white,
        surfaceContainerLow: Color(0xff121212),
        surfaceContainer: Color(0xff1c1c1c),
        surfaceContainerHigh: Color(0xff242424),
      );

  factory ChatColors.fromThemeData(ThemeData themeData) => ChatColors(
        primary: themeData.colorScheme.primary,
        onPrimary: themeData.colorScheme.onPrimary,
        surface: themeData.colorScheme.surface,
        onSurface: themeData.colorScheme.onSurface,
        surfaceContainerLow: themeData.colorScheme.surfaceContainerLow,
        surfaceContainer: themeData.colorScheme.surfaceContainer,
        surfaceContainerHigh: themeData.colorScheme.surfaceContainerHigh,
      );

  ChatColors merge(ChatColors? other) {
    if (other == null) return this;
    return copyWith(
      primary: other.primary,
      onPrimary: other.onPrimary,
      surface: other.surface,
      onSurface: other.onSurface,
      surfaceContainerLow: other.surfaceContainerLow,
      surfaceContainer: other.surfaceContainer,
      surfaceContainerHigh: other.surfaceContainerHigh,
    );
  }
}

@freezed
class ChatTypography with _$ChatTypography {
  const factory ChatTypography({
    required TextStyle bodyLarge,
    required TextStyle bodyMedium,
    required TextStyle bodySmall,
    required TextStyle labelLarge,
    required TextStyle labelMedium,
    required TextStyle labelSmall,
  }) = _ChatTypography;

  const ChatTypography._();

  factory ChatTypography.standard({String? fontFamily}) => ChatTypography(
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
      );

  factory ChatTypography.fromThemeData(ThemeData themeData) => ChatTypography(
        bodyLarge: themeData.textTheme.bodyLarge!,
        bodyMedium: themeData.textTheme.bodyMedium!,
        bodySmall: themeData.textTheme.bodySmall!,
        labelLarge: themeData.textTheme.labelLarge!,
        labelMedium: themeData.textTheme.labelMedium!,
        labelSmall: themeData.textTheme.labelSmall!,
      );

  ChatTypography merge(ChatTypography? other) {
    if (other == null) return this;
    return copyWith(
      bodyLarge: other.bodyLarge,
      bodyMedium: other.bodyMedium,
      bodySmall: other.bodySmall,
      labelLarge: other.labelLarge,
      labelMedium: other.labelMedium,
      labelSmall: other.labelSmall,
    );
  }
}
