// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatTheme {

/// The color scheme used throughout the chat UI.
 ChatColors get colors;/// The text styles used for various elements.
 ChatTypography get typography;/// The default border radius for message bubbles only.
 BorderRadiusGeometry get shape;
/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThemeCopyWith<ChatTheme> get copyWith => _$ChatThemeCopyWithImpl<ChatTheme>(this as ChatTheme, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTheme&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.typography, typography) || other.typography == typography)&&(identical(other.shape, shape) || other.shape == shape));
}


@override
int get hashCode => Object.hash(runtimeType,colors,typography,shape);

@override
String toString() {
  return 'ChatTheme(colors: $colors, typography: $typography, shape: $shape)';
}


}

/// @nodoc
abstract mixin class $ChatThemeCopyWith<$Res>  {
  factory $ChatThemeCopyWith(ChatTheme value, $Res Function(ChatTheme) _then) = _$ChatThemeCopyWithImpl;
@useResult
$Res call({
 ChatColors colors, ChatTypography typography, BorderRadiusGeometry shape
});


$ChatColorsCopyWith<$Res> get colors;$ChatTypographyCopyWith<$Res> get typography;

}
/// @nodoc
class _$ChatThemeCopyWithImpl<$Res>
    implements $ChatThemeCopyWith<$Res> {
  _$ChatThemeCopyWithImpl(this._self, this._then);

  final ChatTheme _self;
  final $Res Function(ChatTheme) _then;

/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colors = null,Object? typography = null,Object? shape = null,}) {
  return _then(_self.copyWith(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as ChatColors,typography: null == typography ? _self.typography : typography // ignore: cast_nullable_to_non_nullable
as ChatTypography,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as BorderRadiusGeometry,
  ));
}
/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatColorsCopyWith<$Res> get colors {
  
  return $ChatColorsCopyWith<$Res>(_self.colors, (value) {
    return _then(_self.copyWith(colors: value));
  });
}/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatTypographyCopyWith<$Res> get typography {
  
  return $ChatTypographyCopyWith<$Res>(_self.typography, (value) {
    return _then(_self.copyWith(typography: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatTheme].
extension ChatThemePatterns on ChatTheme {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatTheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatTheme() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatTheme value)  $default,){
final _that = this;
switch (_that) {
case _ChatTheme():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatTheme value)?  $default,){
final _that = this;
switch (_that) {
case _ChatTheme() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatColors colors,  ChatTypography typography,  BorderRadiusGeometry shape)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatTheme() when $default != null:
return $default(_that.colors,_that.typography,_that.shape);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatColors colors,  ChatTypography typography,  BorderRadiusGeometry shape)  $default,) {final _that = this;
switch (_that) {
case _ChatTheme():
return $default(_that.colors,_that.typography,_that.shape);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatColors colors,  ChatTypography typography,  BorderRadiusGeometry shape)?  $default,) {final _that = this;
switch (_that) {
case _ChatTheme() when $default != null:
return $default(_that.colors,_that.typography,_that.shape);case _:
  return null;

}
}

}

/// @nodoc


class _ChatTheme extends ChatTheme {
  const _ChatTheme({required this.colors, required this.typography, required this.shape}): super._();
  

/// The color scheme used throughout the chat UI.
@override final  ChatColors colors;
/// The text styles used for various elements.
@override final  ChatTypography typography;
/// The default border radius for message bubbles only.
@override final  BorderRadiusGeometry shape;

/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThemeCopyWith<_ChatTheme> get copyWith => __$ChatThemeCopyWithImpl<_ChatTheme>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatTheme&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.typography, typography) || other.typography == typography)&&(identical(other.shape, shape) || other.shape == shape));
}


@override
int get hashCode => Object.hash(runtimeType,colors,typography,shape);

@override
String toString() {
  return 'ChatTheme(colors: $colors, typography: $typography, shape: $shape)';
}


}

/// @nodoc
abstract mixin class _$ChatThemeCopyWith<$Res> implements $ChatThemeCopyWith<$Res> {
  factory _$ChatThemeCopyWith(_ChatTheme value, $Res Function(_ChatTheme) _then) = __$ChatThemeCopyWithImpl;
@override @useResult
$Res call({
 ChatColors colors, ChatTypography typography, BorderRadiusGeometry shape
});


@override $ChatColorsCopyWith<$Res> get colors;@override $ChatTypographyCopyWith<$Res> get typography;

}
/// @nodoc
class __$ChatThemeCopyWithImpl<$Res>
    implements _$ChatThemeCopyWith<$Res> {
  __$ChatThemeCopyWithImpl(this._self, this._then);

  final _ChatTheme _self;
  final $Res Function(_ChatTheme) _then;

/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colors = null,Object? typography = null,Object? shape = null,}) {
  return _then(_ChatTheme(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as ChatColors,typography: null == typography ? _self.typography : typography // ignore: cast_nullable_to_non_nullable
as ChatTypography,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as BorderRadiusGeometry,
  ));
}

/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatColorsCopyWith<$Res> get colors {
  
  return $ChatColorsCopyWith<$Res>(_self.colors, (value) {
    return _then(_self.copyWith(colors: value));
  });
}/// Create a copy of ChatTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatTypographyCopyWith<$Res> get typography {
  
  return $ChatTypographyCopyWith<$Res>(_self.typography, (value) {
    return _then(_self.copyWith(typography: value));
  });
}
}

/// @nodoc
mixin _$ChatColors {

/// Primary color, often used for sent messages and accents.
 Color get primary;/// Color for text and icons displayed on top of [primary].
 Color get onPrimary;/// The main background color of the chat screen.
 Color get surface;/// Color for text and icons displayed on top of [surface].
 Color get onSurface;/// Background color for elements like received messages.
 Color get surfaceContainer;/// A slightly lighter/darker variant of [surfaceContainer].
 Color get surfaceContainerLow;/// A slightly lighter/darker variant of [surfaceContainer].
 Color get surfaceContainerHigh;
/// Create a copy of ChatColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatColorsCopyWith<ChatColors> get copyWith => _$ChatColorsCopyWithImpl<ChatColors>(this as ChatColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.surfaceContainer, surfaceContainer) || other.surfaceContainer == surfaceContainer)&&(identical(other.surfaceContainerLow, surfaceContainerLow) || other.surfaceContainerLow == surfaceContainerLow)&&(identical(other.surfaceContainerHigh, surfaceContainerHigh) || other.surfaceContainerHigh == surfaceContainerHigh));
}


@override
int get hashCode => Object.hash(runtimeType,primary,onPrimary,surface,onSurface,surfaceContainer,surfaceContainerLow,surfaceContainerHigh);

@override
String toString() {
  return 'ChatColors(primary: $primary, onPrimary: $onPrimary, surface: $surface, onSurface: $onSurface, surfaceContainer: $surfaceContainer, surfaceContainerLow: $surfaceContainerLow, surfaceContainerHigh: $surfaceContainerHigh)';
}


}

/// @nodoc
abstract mixin class $ChatColorsCopyWith<$Res>  {
  factory $ChatColorsCopyWith(ChatColors value, $Res Function(ChatColors) _then) = _$ChatColorsCopyWithImpl;
@useResult
$Res call({
 Color primary, Color onPrimary, Color surface, Color onSurface, Color surfaceContainer, Color surfaceContainerLow, Color surfaceContainerHigh
});




}
/// @nodoc
class _$ChatColorsCopyWithImpl<$Res>
    implements $ChatColorsCopyWith<$Res> {
  _$ChatColorsCopyWithImpl(this._self, this._then);

  final ChatColors _self;
  final $Res Function(ChatColors) _then;

/// Create a copy of ChatColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? onPrimary = null,Object? surface = null,Object? onSurface = null,Object? surfaceContainer = null,Object? surfaceContainerLow = null,Object? surfaceContainerHigh = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainer: null == surfaceContainer ? _self.surfaceContainer : surfaceContainer // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLow: null == surfaceContainerLow ? _self.surfaceContainerLow : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHigh: null == surfaceContainerHigh ? _self.surfaceContainerHigh : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatColors].
extension ChatColorsPatterns on ChatColors {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatColors() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatColors value)  $default,){
final _that = this;
switch (_that) {
case _ChatColors():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatColors value)?  $default,){
final _that = this;
switch (_that) {
case _ChatColors() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color primary,  Color onPrimary,  Color surface,  Color onSurface,  Color surfaceContainer,  Color surfaceContainerLow,  Color surfaceContainerHigh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatColors() when $default != null:
return $default(_that.primary,_that.onPrimary,_that.surface,_that.onSurface,_that.surfaceContainer,_that.surfaceContainerLow,_that.surfaceContainerHigh);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color primary,  Color onPrimary,  Color surface,  Color onSurface,  Color surfaceContainer,  Color surfaceContainerLow,  Color surfaceContainerHigh)  $default,) {final _that = this;
switch (_that) {
case _ChatColors():
return $default(_that.primary,_that.onPrimary,_that.surface,_that.onSurface,_that.surfaceContainer,_that.surfaceContainerLow,_that.surfaceContainerHigh);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color primary,  Color onPrimary,  Color surface,  Color onSurface,  Color surfaceContainer,  Color surfaceContainerLow,  Color surfaceContainerHigh)?  $default,) {final _that = this;
switch (_that) {
case _ChatColors() when $default != null:
return $default(_that.primary,_that.onPrimary,_that.surface,_that.onSurface,_that.surfaceContainer,_that.surfaceContainerLow,_that.surfaceContainerHigh);case _:
  return null;

}
}

}

/// @nodoc


class _ChatColors extends ChatColors {
  const _ChatColors({required this.primary, required this.onPrimary, required this.surface, required this.onSurface, required this.surfaceContainer, required this.surfaceContainerLow, required this.surfaceContainerHigh}): super._();
  

/// Primary color, often used for sent messages and accents.
@override final  Color primary;
/// Color for text and icons displayed on top of [primary].
@override final  Color onPrimary;
/// The main background color of the chat screen.
@override final  Color surface;
/// Color for text and icons displayed on top of [surface].
@override final  Color onSurface;
/// Background color for elements like received messages.
@override final  Color surfaceContainer;
/// A slightly lighter/darker variant of [surfaceContainer].
@override final  Color surfaceContainerLow;
/// A slightly lighter/darker variant of [surfaceContainer].
@override final  Color surfaceContainerHigh;

/// Create a copy of ChatColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatColorsCopyWith<_ChatColors> get copyWith => __$ChatColorsCopyWithImpl<_ChatColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.surfaceContainer, surfaceContainer) || other.surfaceContainer == surfaceContainer)&&(identical(other.surfaceContainerLow, surfaceContainerLow) || other.surfaceContainerLow == surfaceContainerLow)&&(identical(other.surfaceContainerHigh, surfaceContainerHigh) || other.surfaceContainerHigh == surfaceContainerHigh));
}


@override
int get hashCode => Object.hash(runtimeType,primary,onPrimary,surface,onSurface,surfaceContainer,surfaceContainerLow,surfaceContainerHigh);

@override
String toString() {
  return 'ChatColors(primary: $primary, onPrimary: $onPrimary, surface: $surface, onSurface: $onSurface, surfaceContainer: $surfaceContainer, surfaceContainerLow: $surfaceContainerLow, surfaceContainerHigh: $surfaceContainerHigh)';
}


}

/// @nodoc
abstract mixin class _$ChatColorsCopyWith<$Res> implements $ChatColorsCopyWith<$Res> {
  factory _$ChatColorsCopyWith(_ChatColors value, $Res Function(_ChatColors) _then) = __$ChatColorsCopyWithImpl;
@override @useResult
$Res call({
 Color primary, Color onPrimary, Color surface, Color onSurface, Color surfaceContainer, Color surfaceContainerLow, Color surfaceContainerHigh
});




}
/// @nodoc
class __$ChatColorsCopyWithImpl<$Res>
    implements _$ChatColorsCopyWith<$Res> {
  __$ChatColorsCopyWithImpl(this._self, this._then);

  final _ChatColors _self;
  final $Res Function(_ChatColors) _then;

/// Create a copy of ChatColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? onPrimary = null,Object? surface = null,Object? onSurface = null,Object? surfaceContainer = null,Object? surfaceContainerLow = null,Object? surfaceContainerHigh = null,}) {
  return _then(_ChatColors(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainer: null == surfaceContainer ? _self.surfaceContainer : surfaceContainer // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLow: null == surfaceContainerLow ? _self.surfaceContainerLow : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHigh: null == surfaceContainerHigh ? _self.surfaceContainerHigh : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc
mixin _$ChatTypography {

/// Style for large body text (e.g., potentially message content).
 TextStyle get bodyLarge;/// Style for medium body text (e.g., default message content).
 TextStyle get bodyMedium;/// Style for small body text (e.g., file sizes).
 TextStyle get bodySmall;/// Style for large labels (e.g., potentially user names).
 TextStyle get labelLarge;/// Style for medium labels.
 TextStyle get labelMedium;/// Style for small labels (e.g., timestamps, status).
 TextStyle get labelSmall;
/// Create a copy of ChatTypography
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTypographyCopyWith<ChatTypography> get copyWith => _$ChatTypographyCopyWithImpl<ChatTypography>(this as ChatTypography, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTypography&&(identical(other.bodyLarge, bodyLarge) || other.bodyLarge == bodyLarge)&&(identical(other.bodyMedium, bodyMedium) || other.bodyMedium == bodyMedium)&&(identical(other.bodySmall, bodySmall) || other.bodySmall == bodySmall)&&(identical(other.labelLarge, labelLarge) || other.labelLarge == labelLarge)&&(identical(other.labelMedium, labelMedium) || other.labelMedium == labelMedium)&&(identical(other.labelSmall, labelSmall) || other.labelSmall == labelSmall));
}


@override
int get hashCode => Object.hash(runtimeType,bodyLarge,bodyMedium,bodySmall,labelLarge,labelMedium,labelSmall);

@override
String toString() {
  return 'ChatTypography(bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall, labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall)';
}


}

/// @nodoc
abstract mixin class $ChatTypographyCopyWith<$Res>  {
  factory $ChatTypographyCopyWith(ChatTypography value, $Res Function(ChatTypography) _then) = _$ChatTypographyCopyWithImpl;
@useResult
$Res call({
 TextStyle bodyLarge, TextStyle bodyMedium, TextStyle bodySmall, TextStyle labelLarge, TextStyle labelMedium, TextStyle labelSmall
});




}
/// @nodoc
class _$ChatTypographyCopyWithImpl<$Res>
    implements $ChatTypographyCopyWith<$Res> {
  _$ChatTypographyCopyWithImpl(this._self, this._then);

  final ChatTypography _self;
  final $Res Function(ChatTypography) _then;

/// Create a copy of ChatTypography
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bodyLarge = null,Object? bodyMedium = null,Object? bodySmall = null,Object? labelLarge = null,Object? labelMedium = null,Object? labelSmall = null,}) {
  return _then(_self.copyWith(
bodyLarge: null == bodyLarge ? _self.bodyLarge : bodyLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,bodyMedium: null == bodyMedium ? _self.bodyMedium : bodyMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,bodySmall: null == bodySmall ? _self.bodySmall : bodySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,labelLarge: null == labelLarge ? _self.labelLarge : labelLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,labelMedium: null == labelMedium ? _self.labelMedium : labelMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,labelSmall: null == labelSmall ? _self.labelSmall : labelSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatTypography].
extension ChatTypographyPatterns on ChatTypography {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatTypography value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatTypography() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatTypography value)  $default,){
final _that = this;
switch (_that) {
case _ChatTypography():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatTypography value)?  $default,){
final _that = this;
switch (_that) {
case _ChatTypography() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall,  TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatTypography() when $default != null:
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall,_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall,  TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)  $default,) {final _that = this;
switch (_that) {
case _ChatTypography():
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall,_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall,  TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)?  $default,) {final _that = this;
switch (_that) {
case _ChatTypography() when $default != null:
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall,_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
  return null;

}
}

}

/// @nodoc


class _ChatTypography extends ChatTypography {
  const _ChatTypography({required this.bodyLarge, required this.bodyMedium, required this.bodySmall, required this.labelLarge, required this.labelMedium, required this.labelSmall}): super._();
  

/// Style for large body text (e.g., potentially message content).
@override final  TextStyle bodyLarge;
/// Style for medium body text (e.g., default message content).
@override final  TextStyle bodyMedium;
/// Style for small body text (e.g., file sizes).
@override final  TextStyle bodySmall;
/// Style for large labels (e.g., potentially user names).
@override final  TextStyle labelLarge;
/// Style for medium labels.
@override final  TextStyle labelMedium;
/// Style for small labels (e.g., timestamps, status).
@override final  TextStyle labelSmall;

/// Create a copy of ChatTypography
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatTypographyCopyWith<_ChatTypography> get copyWith => __$ChatTypographyCopyWithImpl<_ChatTypography>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatTypography&&(identical(other.bodyLarge, bodyLarge) || other.bodyLarge == bodyLarge)&&(identical(other.bodyMedium, bodyMedium) || other.bodyMedium == bodyMedium)&&(identical(other.bodySmall, bodySmall) || other.bodySmall == bodySmall)&&(identical(other.labelLarge, labelLarge) || other.labelLarge == labelLarge)&&(identical(other.labelMedium, labelMedium) || other.labelMedium == labelMedium)&&(identical(other.labelSmall, labelSmall) || other.labelSmall == labelSmall));
}


@override
int get hashCode => Object.hash(runtimeType,bodyLarge,bodyMedium,bodySmall,labelLarge,labelMedium,labelSmall);

@override
String toString() {
  return 'ChatTypography(bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall, labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall)';
}


}

/// @nodoc
abstract mixin class _$ChatTypographyCopyWith<$Res> implements $ChatTypographyCopyWith<$Res> {
  factory _$ChatTypographyCopyWith(_ChatTypography value, $Res Function(_ChatTypography) _then) = __$ChatTypographyCopyWithImpl;
@override @useResult
$Res call({
 TextStyle bodyLarge, TextStyle bodyMedium, TextStyle bodySmall, TextStyle labelLarge, TextStyle labelMedium, TextStyle labelSmall
});




}
/// @nodoc
class __$ChatTypographyCopyWithImpl<$Res>
    implements _$ChatTypographyCopyWith<$Res> {
  __$ChatTypographyCopyWithImpl(this._self, this._then);

  final _ChatTypography _self;
  final $Res Function(_ChatTypography) _then;

/// Create a copy of ChatTypography
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bodyLarge = null,Object? bodyMedium = null,Object? bodySmall = null,Object? labelLarge = null,Object? labelMedium = null,Object? labelSmall = null,}) {
  return _then(_ChatTypography(
bodyLarge: null == bodyLarge ? _self.bodyLarge : bodyLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,bodyMedium: null == bodyMedium ? _self.bodyMedium : bodyMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,bodySmall: null == bodySmall ? _self.bodySmall : bodySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,labelLarge: null == labelLarge ? _self.labelLarge : labelLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,labelMedium: null == labelMedium ? _self.labelMedium : labelMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,labelSmall: null == labelSmall ? _self.labelSmall : labelSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

// dart format on
