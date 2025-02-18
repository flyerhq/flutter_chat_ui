// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LinkPreview _$LinkPreviewFromJson(Map<String, dynamic> json) {
  return _LinkPreview.fromJson(json);
}

/// @nodoc
mixin _$LinkPreview {
  String get link => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Serializes this LinkPreview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkPreviewCopyWith<LinkPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkPreviewCopyWith<$Res> {
  factory $LinkPreviewCopyWith(
    LinkPreview value,
    $Res Function(LinkPreview) then,
  ) = _$LinkPreviewCopyWithImpl<$Res, LinkPreview>;
  @useResult
  $Res call({
    String link,
    String? description,
    String? imageUrl,
    String? title,
  });
}

/// @nodoc
class _$LinkPreviewCopyWithImpl<$Res, $Val extends LinkPreview>
    implements $LinkPreviewCopyWith<$Res> {
  _$LinkPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _value.copyWith(
            link:
                null == link
                    ? _value.link
                    : link // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LinkPreviewImplCopyWith<$Res>
    implements $LinkPreviewCopyWith<$Res> {
  factory _$$LinkPreviewImplCopyWith(
    _$LinkPreviewImpl value,
    $Res Function(_$LinkPreviewImpl) then,
  ) = __$$LinkPreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String link,
    String? description,
    String? imageUrl,
    String? title,
  });
}

/// @nodoc
class __$$LinkPreviewImplCopyWithImpl<$Res>
    extends _$LinkPreviewCopyWithImpl<$Res, _$LinkPreviewImpl>
    implements _$$LinkPreviewImplCopyWith<$Res> {
  __$$LinkPreviewImplCopyWithImpl(
    _$LinkPreviewImpl _value,
    $Res Function(_$LinkPreviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LinkPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _$LinkPreviewImpl(
        link:
            null == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkPreviewImpl implements _LinkPreview {
  const _$LinkPreviewImpl({
    required this.link,
    this.description,
    this.imageUrl,
    this.title,
  });

  factory _$LinkPreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkPreviewImplFromJson(json);

  @override
  final String link;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? title;

  @override
  String toString() {
    return 'LinkPreview(link: $link, description: $description, imageUrl: $imageUrl, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkPreviewImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, link, description, imageUrl, title);

  /// Create a copy of LinkPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkPreviewImplCopyWith<_$LinkPreviewImpl> get copyWith =>
      __$$LinkPreviewImplCopyWithImpl<_$LinkPreviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkPreviewImplToJson(this);
  }
}

abstract class _LinkPreview implements LinkPreview {
  const factory _LinkPreview({
    required final String link,
    final String? description,
    final String? imageUrl,
    final String? title,
  }) = _$LinkPreviewImpl;

  factory _LinkPreview.fromJson(Map<String, dynamic> json) =
      _$LinkPreviewImpl.fromJson;

  @override
  String get link;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get title;

  /// Create a copy of LinkPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkPreviewImplCopyWith<_$LinkPreviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
