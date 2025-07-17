import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_theme.freezed.dart';

/// Defines the visual styling for the chat UI.
///
/// Includes color scheme, typography, and shape definitions.
/// Uses Freezed for immutable data classes.
@Freezed(fromJson: false, toJson: false)
abstract class ChatTheme with _$ChatTheme {
  /// Creates a [ChatTheme] instance.
  const factory ChatTheme({
    /// The color scheme used throughout the chat UI.
    required ChatColors colors,

    /// The text styles used for various elements.
    required ChatTypography typography,

    /// The default border radius for message bubbles only.
    required BorderRadiusGeometry shape,
  }) = _ChatTheme;

  const ChatTheme._();

  /// Creates a default light theme.
  /// Optionally specify a [fontFamily].
  factory ChatTheme.light({String? fontFamily}) => ChatTheme(
    colors: ChatColors.light(),
    typography: ChatTypography.standard(fontFamily: fontFamily),
    shape: const BorderRadius.all(Radius.circular(12)),
  );

  /// Creates a default dark theme.
  /// Optionally specify a [fontFamily].
  factory ChatTheme.dark({String? fontFamily}) => ChatTheme(
    colors: ChatColors.dark(),
    typography: ChatTypography.standard(fontFamily: fontFamily),
    shape: const BorderRadius.all(Radius.circular(12)),
  );

  /// Creates a [ChatTheme] based on a Material [ThemeData].
  /// Extracts relevant colors and text styles.
  factory ChatTheme.fromThemeData(ThemeData themeData) => ChatTheme(
    colors: ChatColors.fromThemeData(themeData),
    typography: ChatTypography.fromThemeData(themeData),
    shape: const BorderRadius.all(Radius.circular(12)),
  );

  /// Merges this theme with another [ChatTheme].
  ///
  /// Properties from [other] take precedence.
  ChatTheme merge(ChatTheme? other) {
    if (other == null) return this;
    return copyWith(
      colors: colors.merge(other.colors),
      typography: typography.merge(other.typography),
      shape: other.shape,
    );
  }
}

/// Defines the color palette for the chat UI.
@Freezed(fromJson: false, toJson: false)
abstract class ChatColors with _$ChatColors {
  /// Creates a [ChatColors] instance.
  const factory ChatColors({
    /// Primary color, often used for sent messages and accents.
    required Color primary,

    /// Color for text and icons displayed on top of [primary].
    required Color onPrimary,

    /// The main background color of the chat screen.
    required Color surface,

    /// Color for text and icons displayed on top of [surface].
    required Color onSurface,

    /// Background color for elements like received messages.
    required Color surfaceContainer,

    /// A slightly lighter/darker variant of [surfaceContainer].
    required Color surfaceContainerLow,

    /// A slightly lighter/darker variant of [surfaceContainer].
    required Color surfaceContainerHigh,

    /// The highest/most elevated container surface.
    required Color surfaceContainerHighest,
  }) = _ChatColors;

  const ChatColors._();

  /// Default light color palette.
  factory ChatColors.light() => const ChatColors(
    primary: Color(0xff4169e1),
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xff101010),
    surfaceContainerLow: Color(0xfffafafa),
    surfaceContainer: Color(0xfff5f5f5),
    surfaceContainerHigh: Color(0xffeeeeee),
    surfaceContainerHighest: Color(0xfff0f0f0),
  );

  /// Default dark color palette.
  factory ChatColors.dark() => const ChatColors(
    primary: Color(0xff4169e1),
    onPrimary: Colors.white,
    surface: Color(0xff101010),
    onSurface: Colors.white,
    surfaceContainerLow: Color(0xff121212),
    surfaceContainer: Color(0xff1c1c1c),
    surfaceContainerHigh: Color(0xff242424),
    surfaceContainerHighest: Color(0xff2c2c2c),
  );

  /// Creates [ChatColors] from a Material [ThemeData].
  factory ChatColors.fromThemeData(ThemeData themeData) => ChatColors(
    primary: themeData.colorScheme.primary,
    onPrimary: themeData.colorScheme.onPrimary,
    surface: themeData.colorScheme.surface,
    onSurface: themeData.colorScheme.onSurface,
    surfaceContainerLow: themeData.colorScheme.surfaceContainerLow,
    surfaceContainer: themeData.colorScheme.surfaceContainer,
    surfaceContainerHigh: themeData.colorScheme.surfaceContainerHigh,
    surfaceContainerHighest: themeData.colorScheme.surfaceContainerHigh,
  );

  /// Merges this color scheme with another [ChatColors].
  ///
  /// Colors from [other] take precedence.
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
      surfaceContainerHighest: other.surfaceContainerHighest,
    );
  }
}

/// Defines the typography styles used in the chat UI.
@Freezed(fromJson: false, toJson: false)
abstract class ChatTypography with _$ChatTypography {
  /// Creates a [ChatTypography] instance.
  const factory ChatTypography({
    /// Style for large body text (e.g., potentially message content).
    required TextStyle bodyLarge,

    /// Style for medium body text (e.g., default message content).
    required TextStyle bodyMedium,

    /// Style for small body text (e.g., file sizes).
    required TextStyle bodySmall,

    /// Style for large labels (e.g., potentially user names).
    required TextStyle labelLarge,

    /// Style for medium labels.
    required TextStyle labelMedium,

    /// Style for small labels (e.g., timestamps, status).
    required TextStyle labelSmall,
  }) = _ChatTypography;

  const ChatTypography._();

  /// Creates a standard set of text styles.
  /// Optionally specify a custom [fontFamily].
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

  /// Creates [ChatTypography] from a Material [ThemeData].
  factory ChatTypography.fromThemeData(ThemeData themeData) => ChatTypography(
    bodyLarge: themeData.textTheme.bodyLarge!,
    bodyMedium: themeData.textTheme.bodyMedium!,
    bodySmall: themeData.textTheme.bodySmall!,
    labelLarge: themeData.textTheme.labelLarge!,
    labelMedium: themeData.textTheme.labelMedium!,
    labelSmall: themeData.textTheme.labelSmall!,
  );

  /// Merges this typography scheme with another [ChatTypography].
  ///
  /// Styles from [other] take precedence.
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
