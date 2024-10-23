// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'text':
      return TextMessage.fromJson(json);
    case 'image':
      return ImageMessage.fromJson(json);

    default:
      return UnsupportedMessage.fromJson(json);
  }
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError;
  User get author => throw _privateConstructorUsedError;
  @EpochDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)
        text,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)
        image,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextMessage value) text,
    required TResult Function(ImageMessage value) image,
    required TResult Function(UnsupportedMessage value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextMessage value)? text,
    TResult? Function(ImageMessage value)? image,
    TResult? Function(UnsupportedMessage value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextMessage value)? text,
    TResult Function(ImageMessage value)? image,
    TResult Function(UnsupportedMessage value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String id,
      User author,
      @EpochDateTimeConverter() DateTime createdAt,
      Map<String, dynamic>? metadata});

  $UserCopyWith<$Res> get author;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? createdAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get author {
    return $UserCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TextMessageImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$TextMessageImplCopyWith(
          _$TextMessageImpl value, $Res Function(_$TextMessageImpl) then) =
      __$$TextMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      User author,
      @EpochDateTimeConverter() DateTime createdAt,
      Map<String, dynamic>? metadata,
      String text,
      LinkPreview? linkPreview});

  @override
  $UserCopyWith<$Res> get author;
  $LinkPreviewCopyWith<$Res>? get linkPreview;
}

/// @nodoc
class __$$TextMessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$TextMessageImpl>
    implements _$$TextMessageImplCopyWith<$Res> {
  __$$TextMessageImplCopyWithImpl(
      _$TextMessageImpl _value, $Res Function(_$TextMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? createdAt = null,
    Object? metadata = freezed,
    Object? text = null,
    Object? linkPreview = freezed,
  }) {
    return _then(_$TextMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      linkPreview: freezed == linkPreview
          ? _value.linkPreview
          : linkPreview // ignore: cast_nullable_to_non_nullable
              as LinkPreview?,
    ));
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkPreviewCopyWith<$Res>? get linkPreview {
    if (_value.linkPreview == null) {
      return null;
    }

    return $LinkPreviewCopyWith<$Res>(_value.linkPreview!, (value) {
      return _then(_value.copyWith(linkPreview: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextMessageImpl extends TextMessage {
  const _$TextMessageImpl(
      {required this.id,
      required this.author,
      @EpochDateTimeConverter() required this.createdAt,
      final Map<String, dynamic>? metadata,
      required this.text,
      this.linkPreview,
      final String? $type})
      : _metadata = metadata,
        $type = $type ?? 'text',
        super._();

  factory _$TextMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextMessageImplFromJson(json);

  @override
  final String id;
  @override
  final User author;
  @override
  @EpochDateTimeConverter()
  final DateTime createdAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String text;
  @override
  final LinkPreview? linkPreview;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Message.text(id: $id, author: $author, createdAt: $createdAt, metadata: $metadata, text: $text, linkPreview: $linkPreview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.linkPreview, linkPreview) ||
                other.linkPreview == linkPreview));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, author, createdAt,
      const DeepCollectionEquality().hash(_metadata), text, linkPreview);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextMessageImplCopyWith<_$TextMessageImpl> get copyWith =>
      __$$TextMessageImplCopyWithImpl<_$TextMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)
        text,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)
        image,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)
        unsupported,
  }) {
    return text(id, author, createdAt, metadata, this.text, linkPreview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
  }) {
    return text?.call(id, author, createdAt, metadata, this.text, linkPreview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(id, author, createdAt, metadata, this.text, linkPreview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextMessage value) text,
    required TResult Function(ImageMessage value) image,
    required TResult Function(UnsupportedMessage value) unsupported,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextMessage value)? text,
    TResult? Function(ImageMessage value)? image,
    TResult? Function(UnsupportedMessage value)? unsupported,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextMessage value)? text,
    TResult Function(ImageMessage value)? image,
    TResult Function(UnsupportedMessage value)? unsupported,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextMessageImplToJson(
      this,
    );
  }
}

abstract class TextMessage extends Message {
  const factory TextMessage(
      {required final String id,
      required final User author,
      @EpochDateTimeConverter() required final DateTime createdAt,
      final Map<String, dynamic>? metadata,
      required final String text,
      final LinkPreview? linkPreview}) = _$TextMessageImpl;
  const TextMessage._() : super._();

  factory TextMessage.fromJson(Map<String, dynamic> json) =
      _$TextMessageImpl.fromJson;

  @override
  String get id;
  @override
  User get author;
  @override
  @EpochDateTimeConverter()
  DateTime get createdAt;
  @override
  Map<String, dynamic>? get metadata;
  String get text;
  LinkPreview? get linkPreview;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextMessageImplCopyWith<_$TextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageMessageImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$ImageMessageImplCopyWith(
          _$ImageMessageImpl value, $Res Function(_$ImageMessageImpl) then) =
      __$$ImageMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      User author,
      @EpochDateTimeConverter() DateTime createdAt,
      Map<String, dynamic>? metadata,
      String source,
      String? thumbhash,
      String? blurhash,
      double? width,
      double? height});

  @override
  $UserCopyWith<$Res> get author;
}

/// @nodoc
class __$$ImageMessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$ImageMessageImpl>
    implements _$$ImageMessageImplCopyWith<$Res> {
  __$$ImageMessageImplCopyWithImpl(
      _$ImageMessageImpl _value, $Res Function(_$ImageMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? createdAt = null,
    Object? metadata = freezed,
    Object? source = null,
    Object? thumbhash = freezed,
    Object? blurhash = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$ImageMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      thumbhash: freezed == thumbhash
          ? _value.thumbhash
          : thumbhash // ignore: cast_nullable_to_non_nullable
              as String?,
      blurhash: freezed == blurhash
          ? _value.blurhash
          : blurhash // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageMessageImpl extends ImageMessage {
  const _$ImageMessageImpl(
      {required this.id,
      required this.author,
      @EpochDateTimeConverter() required this.createdAt,
      final Map<String, dynamic>? metadata,
      required this.source,
      this.thumbhash,
      this.blurhash,
      this.width,
      this.height,
      final String? $type})
      : _metadata = metadata,
        $type = $type ?? 'image',
        super._();

  factory _$ImageMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageMessageImplFromJson(json);

  @override
  final String id;
  @override
  final User author;
  @override
  @EpochDateTimeConverter()
  final DateTime createdAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String source;
  @override
  final String? thumbhash;
  @override
  final String? blurhash;
  @override
  final double? width;
  @override
  final double? height;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Message.image(id: $id, author: $author, createdAt: $createdAt, metadata: $metadata, source: $source, thumbhash: $thumbhash, blurhash: $blurhash, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.thumbhash, thumbhash) ||
                other.thumbhash == thumbhash) &&
            (identical(other.blurhash, blurhash) ||
                other.blurhash == blurhash) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      author,
      createdAt,
      const DeepCollectionEquality().hash(_metadata),
      source,
      thumbhash,
      blurhash,
      width,
      height);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageMessageImplCopyWith<_$ImageMessageImpl> get copyWith =>
      __$$ImageMessageImplCopyWithImpl<_$ImageMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)
        text,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)
        image,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)
        unsupported,
  }) {
    return image(id, author, createdAt, metadata, source, thumbhash, blurhash,
        width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
  }) {
    return image?.call(id, author, createdAt, metadata, source, thumbhash,
        blurhash, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(id, author, createdAt, metadata, source, thumbhash, blurhash,
          width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextMessage value) text,
    required TResult Function(ImageMessage value) image,
    required TResult Function(UnsupportedMessage value) unsupported,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextMessage value)? text,
    TResult? Function(ImageMessage value)? image,
    TResult? Function(UnsupportedMessage value)? unsupported,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextMessage value)? text,
    TResult Function(ImageMessage value)? image,
    TResult Function(UnsupportedMessage value)? unsupported,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageMessageImplToJson(
      this,
    );
  }
}

abstract class ImageMessage extends Message {
  const factory ImageMessage(
      {required final String id,
      required final User author,
      @EpochDateTimeConverter() required final DateTime createdAt,
      final Map<String, dynamic>? metadata,
      required final String source,
      final String? thumbhash,
      final String? blurhash,
      final double? width,
      final double? height}) = _$ImageMessageImpl;
  const ImageMessage._() : super._();

  factory ImageMessage.fromJson(Map<String, dynamic> json) =
      _$ImageMessageImpl.fromJson;

  @override
  String get id;
  @override
  User get author;
  @override
  @EpochDateTimeConverter()
  DateTime get createdAt;
  @override
  Map<String, dynamic>? get metadata;
  String get source;
  String? get thumbhash;
  String? get blurhash;
  double? get width;
  double? get height;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageMessageImplCopyWith<_$ImageMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnsupportedMessageImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$UnsupportedMessageImplCopyWith(_$UnsupportedMessageImpl value,
          $Res Function(_$UnsupportedMessageImpl) then) =
      __$$UnsupportedMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      User author,
      @EpochDateTimeConverter() DateTime createdAt,
      Map<String, dynamic>? metadata});

  @override
  $UserCopyWith<$Res> get author;
}

/// @nodoc
class __$$UnsupportedMessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$UnsupportedMessageImpl>
    implements _$$UnsupportedMessageImplCopyWith<$Res> {
  __$$UnsupportedMessageImplCopyWithImpl(_$UnsupportedMessageImpl _value,
      $Res Function(_$UnsupportedMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? createdAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_$UnsupportedMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsupportedMessageImpl extends UnsupportedMessage {
  const _$UnsupportedMessageImpl(
      {required this.id,
      required this.author,
      @EpochDateTimeConverter() required this.createdAt,
      final Map<String, dynamic>? metadata,
      final String? $type})
      : _metadata = metadata,
        $type = $type ?? 'unsupported',
        super._();

  factory _$UnsupportedMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnsupportedMessageImplFromJson(json);

  @override
  final String id;
  @override
  final User author;
  @override
  @EpochDateTimeConverter()
  final DateTime createdAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Message.unsupported(id: $id, author: $author, createdAt: $createdAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsupportedMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, author, createdAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsupportedMessageImplCopyWith<_$UnsupportedMessageImpl> get copyWith =>
      __$$UnsupportedMessageImplCopyWithImpl<_$UnsupportedMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)
        text,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)
        image,
    required TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)
        unsupported,
  }) {
    return unsupported(id, author, createdAt, metadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult? Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
  }) {
    return unsupported?.call(id, author, createdAt, metadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String text,
            LinkPreview? linkPreview)?
        text,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata,
            String source,
            String? thumbhash,
            String? blurhash,
            double? width,
            double? height)?
        image,
    TResult Function(
            String id,
            User author,
            @EpochDateTimeConverter() DateTime createdAt,
            Map<String, dynamic>? metadata)?
        unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(id, author, createdAt, metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextMessage value) text,
    required TResult Function(ImageMessage value) image,
    required TResult Function(UnsupportedMessage value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextMessage value)? text,
    TResult? Function(ImageMessage value)? image,
    TResult? Function(UnsupportedMessage value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextMessage value)? text,
    TResult Function(ImageMessage value)? image,
    TResult Function(UnsupportedMessage value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsupportedMessageImplToJson(
      this,
    );
  }
}

abstract class UnsupportedMessage extends Message {
  const factory UnsupportedMessage(
      {required final String id,
      required final User author,
      @EpochDateTimeConverter() required final DateTime createdAt,
      final Map<String, dynamic>? metadata}) = _$UnsupportedMessageImpl;
  const UnsupportedMessage._() : super._();

  factory UnsupportedMessage.fromJson(Map<String, dynamic> json) =
      _$UnsupportedMessageImpl.fromJson;

  @override
  String get id;
  @override
  User get author;
  @override
  @EpochDateTimeConverter()
  DateTime get createdAt;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsupportedMessageImplCopyWith<_$UnsupportedMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
