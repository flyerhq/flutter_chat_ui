// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatTheme {
  ChatColors get colors => throw _privateConstructorUsedError;
  ChatTypography get typography => throw _privateConstructorUsedError;
  BorderRadiusGeometry get shape => throw _privateConstructorUsedError;

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThemeCopyWith<ChatTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThemeCopyWith<$Res> {
  factory $ChatThemeCopyWith(ChatTheme value, $Res Function(ChatTheme) then) =
      _$ChatThemeCopyWithImpl<$Res, ChatTheme>;
  @useResult
  $Res call({
    ChatColors colors,
    ChatTypography typography,
    BorderRadiusGeometry shape,
  });

  $ChatColorsCopyWith<$Res> get colors;
  $ChatTypographyCopyWith<$Res> get typography;
}

/// @nodoc
class _$ChatThemeCopyWithImpl<$Res, $Val extends ChatTheme>
    implements $ChatThemeCopyWith<$Res> {
  _$ChatThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? typography = null,
    Object? shape = null,
  }) {
    return _then(
      _value.copyWith(
            colors:
                null == colors
                    ? _value.colors
                    : colors // ignore: cast_nullable_to_non_nullable
                        as ChatColors,
            typography:
                null == typography
                    ? _value.typography
                    : typography // ignore: cast_nullable_to_non_nullable
                        as ChatTypography,
            shape:
                null == shape
                    ? _value.shape
                    : shape // ignore: cast_nullable_to_non_nullable
                        as BorderRadiusGeometry,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatColorsCopyWith<$Res> get colors {
    return $ChatColorsCopyWith<$Res>(_value.colors, (value) {
      return _then(_value.copyWith(colors: value) as $Val);
    });
  }

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatTypographyCopyWith<$Res> get typography {
    return $ChatTypographyCopyWith<$Res>(_value.typography, (value) {
      return _then(_value.copyWith(typography: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatThemeImplCopyWith<$Res>
    implements $ChatThemeCopyWith<$Res> {
  factory _$$ChatThemeImplCopyWith(
    _$ChatThemeImpl value,
    $Res Function(_$ChatThemeImpl) then,
  ) = __$$ChatThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ChatColors colors,
    ChatTypography typography,
    BorderRadiusGeometry shape,
  });

  @override
  $ChatColorsCopyWith<$Res> get colors;
  @override
  $ChatTypographyCopyWith<$Res> get typography;
}

/// @nodoc
class __$$ChatThemeImplCopyWithImpl<$Res>
    extends _$ChatThemeCopyWithImpl<$Res, _$ChatThemeImpl>
    implements _$$ChatThemeImplCopyWith<$Res> {
  __$$ChatThemeImplCopyWithImpl(
    _$ChatThemeImpl _value,
    $Res Function(_$ChatThemeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? typography = null,
    Object? shape = null,
  }) {
    return _then(
      _$ChatThemeImpl(
        colors:
            null == colors
                ? _value.colors
                : colors // ignore: cast_nullable_to_non_nullable
                    as ChatColors,
        typography:
            null == typography
                ? _value.typography
                : typography // ignore: cast_nullable_to_non_nullable
                    as ChatTypography,
        shape:
            null == shape
                ? _value.shape
                : shape // ignore: cast_nullable_to_non_nullable
                    as BorderRadiusGeometry,
      ),
    );
  }
}

/// @nodoc

class _$ChatThemeImpl extends _ChatTheme {
  const _$ChatThemeImpl({
    required this.colors,
    required this.typography,
    required this.shape,
  }) : super._();

  @override
  final ChatColors colors;
  @override
  final ChatTypography typography;
  @override
  final BorderRadiusGeometry shape;

  @override
  String toString() {
    return 'ChatTheme(colors: $colors, typography: $typography, shape: $shape)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThemeImpl &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.typography, typography) ||
                other.typography == typography) &&
            (identical(other.shape, shape) || other.shape == shape));
  }

  @override
  int get hashCode => Object.hash(runtimeType, colors, typography, shape);

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThemeImplCopyWith<_$ChatThemeImpl> get copyWith =>
      __$$ChatThemeImplCopyWithImpl<_$ChatThemeImpl>(this, _$identity);
}

abstract class _ChatTheme extends ChatTheme {
  const factory _ChatTheme({
    required final ChatColors colors,
    required final ChatTypography typography,
    required final BorderRadiusGeometry shape,
  }) = _$ChatThemeImpl;
  const _ChatTheme._() : super._();

  @override
  ChatColors get colors;
  @override
  ChatTypography get typography;
  @override
  BorderRadiusGeometry get shape;

  /// Create a copy of ChatTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThemeImplCopyWith<_$ChatThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatColors {
  Color get primary => throw _privateConstructorUsedError;
  Color get onPrimary => throw _privateConstructorUsedError;
  Color get surface => throw _privateConstructorUsedError;
  Color get onSurface => throw _privateConstructorUsedError;
  Color get surfaceContainer => throw _privateConstructorUsedError;
  Color get surfaceContainerLow => throw _privateConstructorUsedError;
  Color get surfaceContainerHigh => throw _privateConstructorUsedError;

  /// Create a copy of ChatColors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatColorsCopyWith<ChatColors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatColorsCopyWith<$Res> {
  factory $ChatColorsCopyWith(
    ChatColors value,
    $Res Function(ChatColors) then,
  ) = _$ChatColorsCopyWithImpl<$Res, ChatColors>;
  @useResult
  $Res call({
    Color primary,
    Color onPrimary,
    Color surface,
    Color onSurface,
    Color surfaceContainer,
    Color surfaceContainerLow,
    Color surfaceContainerHigh,
  });
}

/// @nodoc
class _$ChatColorsCopyWithImpl<$Res, $Val extends ChatColors>
    implements $ChatColorsCopyWith<$Res> {
  _$ChatColorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatColors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? onPrimary = null,
    Object? surface = null,
    Object? onSurface = null,
    Object? surfaceContainer = null,
    Object? surfaceContainerLow = null,
    Object? surfaceContainerHigh = null,
  }) {
    return _then(
      _value.copyWith(
            primary:
                null == primary
                    ? _value.primary
                    : primary // ignore: cast_nullable_to_non_nullable
                        as Color,
            onPrimary:
                null == onPrimary
                    ? _value.onPrimary
                    : onPrimary // ignore: cast_nullable_to_non_nullable
                        as Color,
            surface:
                null == surface
                    ? _value.surface
                    : surface // ignore: cast_nullable_to_non_nullable
                        as Color,
            onSurface:
                null == onSurface
                    ? _value.onSurface
                    : onSurface // ignore: cast_nullable_to_non_nullable
                        as Color,
            surfaceContainer:
                null == surfaceContainer
                    ? _value.surfaceContainer
                    : surfaceContainer // ignore: cast_nullable_to_non_nullable
                        as Color,
            surfaceContainerLow:
                null == surfaceContainerLow
                    ? _value.surfaceContainerLow
                    : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
                        as Color,
            surfaceContainerHigh:
                null == surfaceContainerHigh
                    ? _value.surfaceContainerHigh
                    : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
                        as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatColorsImplCopyWith<$Res>
    implements $ChatColorsCopyWith<$Res> {
  factory _$$ChatColorsImplCopyWith(
    _$ChatColorsImpl value,
    $Res Function(_$ChatColorsImpl) then,
  ) = __$$ChatColorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Color primary,
    Color onPrimary,
    Color surface,
    Color onSurface,
    Color surfaceContainer,
    Color surfaceContainerLow,
    Color surfaceContainerHigh,
  });
}

/// @nodoc
class __$$ChatColorsImplCopyWithImpl<$Res>
    extends _$ChatColorsCopyWithImpl<$Res, _$ChatColorsImpl>
    implements _$$ChatColorsImplCopyWith<$Res> {
  __$$ChatColorsImplCopyWithImpl(
    _$ChatColorsImpl _value,
    $Res Function(_$ChatColorsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatColors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? onPrimary = null,
    Object? surface = null,
    Object? onSurface = null,
    Object? surfaceContainer = null,
    Object? surfaceContainerLow = null,
    Object? surfaceContainerHigh = null,
  }) {
    return _then(
      _$ChatColorsImpl(
        primary:
            null == primary
                ? _value.primary
                : primary // ignore: cast_nullable_to_non_nullable
                    as Color,
        onPrimary:
            null == onPrimary
                ? _value.onPrimary
                : onPrimary // ignore: cast_nullable_to_non_nullable
                    as Color,
        surface:
            null == surface
                ? _value.surface
                : surface // ignore: cast_nullable_to_non_nullable
                    as Color,
        onSurface:
            null == onSurface
                ? _value.onSurface
                : onSurface // ignore: cast_nullable_to_non_nullable
                    as Color,
        surfaceContainer:
            null == surfaceContainer
                ? _value.surfaceContainer
                : surfaceContainer // ignore: cast_nullable_to_non_nullable
                    as Color,
        surfaceContainerLow:
            null == surfaceContainerLow
                ? _value.surfaceContainerLow
                : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
                    as Color,
        surfaceContainerHigh:
            null == surfaceContainerHigh
                ? _value.surfaceContainerHigh
                : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
                    as Color,
      ),
    );
  }
}

/// @nodoc

class _$ChatColorsImpl extends _ChatColors {
  const _$ChatColorsImpl({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainer,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
  }) : super._();

  @override
  final Color primary;
  @override
  final Color onPrimary;
  @override
  final Color surface;
  @override
  final Color onSurface;
  @override
  final Color surfaceContainer;
  @override
  final Color surfaceContainerLow;
  @override
  final Color surfaceContainerHigh;

  @override
  String toString() {
    return 'ChatColors(primary: $primary, onPrimary: $onPrimary, surface: $surface, onSurface: $onSurface, surfaceContainer: $surfaceContainer, surfaceContainerLow: $surfaceContainerLow, surfaceContainerHigh: $surfaceContainerHigh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatColorsImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.onPrimary, onPrimary) ||
                other.onPrimary == onPrimary) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.onSurface, onSurface) ||
                other.onSurface == onSurface) &&
            (identical(other.surfaceContainer, surfaceContainer) ||
                other.surfaceContainer == surfaceContainer) &&
            (identical(other.surfaceContainerLow, surfaceContainerLow) ||
                other.surfaceContainerLow == surfaceContainerLow) &&
            (identical(other.surfaceContainerHigh, surfaceContainerHigh) ||
                other.surfaceContainerHigh == surfaceContainerHigh));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    primary,
    onPrimary,
    surface,
    onSurface,
    surfaceContainer,
    surfaceContainerLow,
    surfaceContainerHigh,
  );

  /// Create a copy of ChatColors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatColorsImplCopyWith<_$ChatColorsImpl> get copyWith =>
      __$$ChatColorsImplCopyWithImpl<_$ChatColorsImpl>(this, _$identity);
}

abstract class _ChatColors extends ChatColors {
  const factory _ChatColors({
    required final Color primary,
    required final Color onPrimary,
    required final Color surface,
    required final Color onSurface,
    required final Color surfaceContainer,
    required final Color surfaceContainerLow,
    required final Color surfaceContainerHigh,
  }) = _$ChatColorsImpl;
  const _ChatColors._() : super._();

  @override
  Color get primary;
  @override
  Color get onPrimary;
  @override
  Color get surface;
  @override
  Color get onSurface;
  @override
  Color get surfaceContainer;
  @override
  Color get surfaceContainerLow;
  @override
  Color get surfaceContainerHigh;

  /// Create a copy of ChatColors
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatColorsImplCopyWith<_$ChatColorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatTypography {
  TextStyle get bodyLarge => throw _privateConstructorUsedError;
  TextStyle get bodyMedium => throw _privateConstructorUsedError;
  TextStyle get bodySmall => throw _privateConstructorUsedError;
  TextStyle get labelLarge => throw _privateConstructorUsedError;
  TextStyle get labelMedium => throw _privateConstructorUsedError;
  TextStyle get labelSmall => throw _privateConstructorUsedError;

  /// Create a copy of ChatTypography
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatTypographyCopyWith<ChatTypography> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatTypographyCopyWith<$Res> {
  factory $ChatTypographyCopyWith(
    ChatTypography value,
    $Res Function(ChatTypography) then,
  ) = _$ChatTypographyCopyWithImpl<$Res, ChatTypography>;
  @useResult
  $Res call({
    TextStyle bodyLarge,
    TextStyle bodyMedium,
    TextStyle bodySmall,
    TextStyle labelLarge,
    TextStyle labelMedium,
    TextStyle labelSmall,
  });
}

/// @nodoc
class _$ChatTypographyCopyWithImpl<$Res, $Val extends ChatTypography>
    implements $ChatTypographyCopyWith<$Res> {
  _$ChatTypographyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatTypography
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bodyLarge = null,
    Object? bodyMedium = null,
    Object? bodySmall = null,
    Object? labelLarge = null,
    Object? labelMedium = null,
    Object? labelSmall = null,
  }) {
    return _then(
      _value.copyWith(
            bodyLarge:
                null == bodyLarge
                    ? _value.bodyLarge
                    : bodyLarge // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
            bodyMedium:
                null == bodyMedium
                    ? _value.bodyMedium
                    : bodyMedium // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
            bodySmall:
                null == bodySmall
                    ? _value.bodySmall
                    : bodySmall // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
            labelLarge:
                null == labelLarge
                    ? _value.labelLarge
                    : labelLarge // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
            labelMedium:
                null == labelMedium
                    ? _value.labelMedium
                    : labelMedium // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
            labelSmall:
                null == labelSmall
                    ? _value.labelSmall
                    : labelSmall // ignore: cast_nullable_to_non_nullable
                        as TextStyle,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatTypographyImplCopyWith<$Res>
    implements $ChatTypographyCopyWith<$Res> {
  factory _$$ChatTypographyImplCopyWith(
    _$ChatTypographyImpl value,
    $Res Function(_$ChatTypographyImpl) then,
  ) = __$$ChatTypographyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TextStyle bodyLarge,
    TextStyle bodyMedium,
    TextStyle bodySmall,
    TextStyle labelLarge,
    TextStyle labelMedium,
    TextStyle labelSmall,
  });
}

/// @nodoc
class __$$ChatTypographyImplCopyWithImpl<$Res>
    extends _$ChatTypographyCopyWithImpl<$Res, _$ChatTypographyImpl>
    implements _$$ChatTypographyImplCopyWith<$Res> {
  __$$ChatTypographyImplCopyWithImpl(
    _$ChatTypographyImpl _value,
    $Res Function(_$ChatTypographyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatTypography
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bodyLarge = null,
    Object? bodyMedium = null,
    Object? bodySmall = null,
    Object? labelLarge = null,
    Object? labelMedium = null,
    Object? labelSmall = null,
  }) {
    return _then(
      _$ChatTypographyImpl(
        bodyLarge:
            null == bodyLarge
                ? _value.bodyLarge
                : bodyLarge // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
        bodyMedium:
            null == bodyMedium
                ? _value.bodyMedium
                : bodyMedium // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
        bodySmall:
            null == bodySmall
                ? _value.bodySmall
                : bodySmall // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
        labelLarge:
            null == labelLarge
                ? _value.labelLarge
                : labelLarge // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
        labelMedium:
            null == labelMedium
                ? _value.labelMedium
                : labelMedium // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
        labelSmall:
            null == labelSmall
                ? _value.labelSmall
                : labelSmall // ignore: cast_nullable_to_non_nullable
                    as TextStyle,
      ),
    );
  }
}

/// @nodoc

class _$ChatTypographyImpl extends _ChatTypography {
  const _$ChatTypographyImpl({
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  }) : super._();

  @override
  final TextStyle bodyLarge;
  @override
  final TextStyle bodyMedium;
  @override
  final TextStyle bodySmall;
  @override
  final TextStyle labelLarge;
  @override
  final TextStyle labelMedium;
  @override
  final TextStyle labelSmall;

  @override
  String toString() {
    return 'ChatTypography(bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall, labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatTypographyImpl &&
            (identical(other.bodyLarge, bodyLarge) ||
                other.bodyLarge == bodyLarge) &&
            (identical(other.bodyMedium, bodyMedium) ||
                other.bodyMedium == bodyMedium) &&
            (identical(other.bodySmall, bodySmall) ||
                other.bodySmall == bodySmall) &&
            (identical(other.labelLarge, labelLarge) ||
                other.labelLarge == labelLarge) &&
            (identical(other.labelMedium, labelMedium) ||
                other.labelMedium == labelMedium) &&
            (identical(other.labelSmall, labelSmall) ||
                other.labelSmall == labelSmall));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelMedium,
    labelSmall,
  );

  /// Create a copy of ChatTypography
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatTypographyImplCopyWith<_$ChatTypographyImpl> get copyWith =>
      __$$ChatTypographyImplCopyWithImpl<_$ChatTypographyImpl>(
        this,
        _$identity,
      );
}

abstract class _ChatTypography extends ChatTypography {
  const factory _ChatTypography({
    required final TextStyle bodyLarge,
    required final TextStyle bodyMedium,
    required final TextStyle bodySmall,
    required final TextStyle labelLarge,
    required final TextStyle labelMedium,
    required final TextStyle labelSmall,
  }) = _$ChatTypographyImpl;
  const _ChatTypography._() : super._();

  @override
  TextStyle get bodyLarge;
  @override
  TextStyle get bodyMedium;
  @override
  TextStyle get bodySmall;
  @override
  TextStyle get labelLarge;
  @override
  TextStyle get labelMedium;
  @override
  TextStyle get labelSmall;

  /// Create a copy of ChatTypography
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatTypographyImplCopyWith<_$ChatTypographyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
