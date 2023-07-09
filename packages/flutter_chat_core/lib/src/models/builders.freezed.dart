// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'builders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Builders {
  TextMessageBuilder? get textMessageBuilder =>
      throw _privateConstructorUsedError;
  ImageMessageBuilder? get imageMessageBuilder =>
      throw _privateConstructorUsedError;
  UnsupportedMessageBuilder? get unsupportedMessageBuilder =>
      throw _privateConstructorUsedError;

  /// Create a copy of Builders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuildersCopyWith<Builders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildersCopyWith<$Res> {
  factory $BuildersCopyWith(Builders value, $Res Function(Builders) then) =
      _$BuildersCopyWithImpl<$Res, Builders>;
  @useResult
  $Res call(
      {TextMessageBuilder? textMessageBuilder,
      ImageMessageBuilder? imageMessageBuilder,
      UnsupportedMessageBuilder? unsupportedMessageBuilder});
}

/// @nodoc
class _$BuildersCopyWithImpl<$Res, $Val extends Builders>
    implements $BuildersCopyWith<$Res> {
  _$BuildersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Builders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textMessageBuilder = freezed,
    Object? imageMessageBuilder = freezed,
    Object? unsupportedMessageBuilder = freezed,
  }) {
    return _then(_value.copyWith(
      textMessageBuilder: freezed == textMessageBuilder
          ? _value.textMessageBuilder
          : textMessageBuilder // ignore: cast_nullable_to_non_nullable
              as TextMessageBuilder?,
      imageMessageBuilder: freezed == imageMessageBuilder
          ? _value.imageMessageBuilder
          : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
              as ImageMessageBuilder?,
      unsupportedMessageBuilder: freezed == unsupportedMessageBuilder
          ? _value.unsupportedMessageBuilder
          : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
              as UnsupportedMessageBuilder?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuildersImplCopyWith<$Res>
    implements $BuildersCopyWith<$Res> {
  factory _$$BuildersImplCopyWith(
          _$BuildersImpl value, $Res Function(_$BuildersImpl) then) =
      __$$BuildersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextMessageBuilder? textMessageBuilder,
      ImageMessageBuilder? imageMessageBuilder,
      UnsupportedMessageBuilder? unsupportedMessageBuilder});
}

/// @nodoc
class __$$BuildersImplCopyWithImpl<$Res>
    extends _$BuildersCopyWithImpl<$Res, _$BuildersImpl>
    implements _$$BuildersImplCopyWith<$Res> {
  __$$BuildersImplCopyWithImpl(
      _$BuildersImpl _value, $Res Function(_$BuildersImpl) _then)
      : super(_value, _then);

  /// Create a copy of Builders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textMessageBuilder = freezed,
    Object? imageMessageBuilder = freezed,
    Object? unsupportedMessageBuilder = freezed,
  }) {
    return _then(_$BuildersImpl(
      textMessageBuilder: freezed == textMessageBuilder
          ? _value.textMessageBuilder
          : textMessageBuilder // ignore: cast_nullable_to_non_nullable
              as TextMessageBuilder?,
      imageMessageBuilder: freezed == imageMessageBuilder
          ? _value.imageMessageBuilder
          : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
              as ImageMessageBuilder?,
      unsupportedMessageBuilder: freezed == unsupportedMessageBuilder
          ? _value.unsupportedMessageBuilder
          : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
              as UnsupportedMessageBuilder?,
    ));
  }
}

/// @nodoc

class _$BuildersImpl extends _Builders {
  const _$BuildersImpl(
      {this.textMessageBuilder,
      this.imageMessageBuilder,
      this.unsupportedMessageBuilder})
      : super._();

  @override
  final TextMessageBuilder? textMessageBuilder;
  @override
  final ImageMessageBuilder? imageMessageBuilder;
  @override
  final UnsupportedMessageBuilder? unsupportedMessageBuilder;

  @override
  String toString() {
    return 'Builders(textMessageBuilder: $textMessageBuilder, imageMessageBuilder: $imageMessageBuilder, unsupportedMessageBuilder: $unsupportedMessageBuilder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildersImpl &&
            (identical(other.textMessageBuilder, textMessageBuilder) ||
                other.textMessageBuilder == textMessageBuilder) &&
            (identical(other.imageMessageBuilder, imageMessageBuilder) ||
                other.imageMessageBuilder == imageMessageBuilder) &&
            (identical(other.unsupportedMessageBuilder,
                    unsupportedMessageBuilder) ||
                other.unsupportedMessageBuilder == unsupportedMessageBuilder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textMessageBuilder,
      imageMessageBuilder, unsupportedMessageBuilder);

  /// Create a copy of Builders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildersImplCopyWith<_$BuildersImpl> get copyWith =>
      __$$BuildersImplCopyWithImpl<_$BuildersImpl>(this, _$identity);
}

abstract class _Builders extends Builders {
  const factory _Builders(
          {final TextMessageBuilder? textMessageBuilder,
          final ImageMessageBuilder? imageMessageBuilder,
          final UnsupportedMessageBuilder? unsupportedMessageBuilder}) =
      _$BuildersImpl;
  const _Builders._() : super._();

  @override
  TextMessageBuilder? get textMessageBuilder;
  @override
  ImageMessageBuilder? get imageMessageBuilder;
  @override
  UnsupportedMessageBuilder? get unsupportedMessageBuilder;

  /// Create a copy of Builders
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuildersImplCopyWith<_$BuildersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
