// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Message _$MessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text':
          return TextMessage.fromJson(
            json
          );
                case 'image':
          return ImageMessage.fromJson(
            json
          );
                case 'file':
          return FileMessage.fromJson(
            json
          );
                case 'system':
          return SystemMessage.fromJson(
            json
          );
                case 'custom':
          return CustomMessage.fromJson(
            json
          );
        
          default:
            return UnsupportedMessage.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$Message {

 String get id; String get authorId; String? get replyToId;@EpochDateTimeConverter() DateTime get createdAt;@EpochDateTimeConverter() DateTime? get deletedAt; bool? get sending;@EpochDateTimeConverter() DateTime? get failedAt;@EpochDateTimeConverter() DateTime? get sentAt;@EpochDateTimeConverter() DateTime? get deliveredAt;@EpochDateTimeConverter() DateTime? get seenAt;@EpochDateTimeConverter() DateTime? get updatedAt; Map<String, List<String>>? get reactions; Map<String, dynamic>? get metadata;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Message(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class TextMessage extends Message {
  const TextMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, required this.text, this.linkPreview, this.isOnlyEmoji, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'text',super._();
  factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String text;
 final  LinkPreview? linkPreview;
 final  bool? isOnlyEmoji;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextMessageCopyWith<TextMessage> get copyWith => _$TextMessageCopyWithImpl<TextMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.text, text) || other.text == text)&&(identical(other.linkPreview, linkPreview) || other.linkPreview == linkPreview)&&(identical(other.isOnlyEmoji, isOnlyEmoji) || other.isOnlyEmoji == isOnlyEmoji));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata),text,linkPreview,isOnlyEmoji);

@override
String toString() {
  return 'Message.text(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata, text: $text, linkPreview: $linkPreview, isOnlyEmoji: $isOnlyEmoji)';
}


}

/// @nodoc
abstract mixin class $TextMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $TextMessageCopyWith(TextMessage value, $Res Function(TextMessage) _then) = _$TextMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata, String text, LinkPreview? linkPreview, bool? isOnlyEmoji
});


$LinkPreviewCopyWith<$Res>? get linkPreview;

}
/// @nodoc
class _$TextMessageCopyWithImpl<$Res>
    implements $TextMessageCopyWith<$Res> {
  _$TextMessageCopyWithImpl(this._self, this._then);

  final TextMessage _self;
  final $Res Function(TextMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,Object? text = null,Object? linkPreview = freezed,Object? isOnlyEmoji = freezed,}) {
  return _then(TextMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,linkPreview: freezed == linkPreview ? _self.linkPreview : linkPreview // ignore: cast_nullable_to_non_nullable
as LinkPreview?,isOnlyEmoji: freezed == isOnlyEmoji ? _self.isOnlyEmoji : isOnlyEmoji // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkPreviewCopyWith<$Res>? get linkPreview {
    if (_self.linkPreview == null) {
    return null;
  }

  return $LinkPreviewCopyWith<$Res>(_self.linkPreview!, (value) {
    return _then(_self.copyWith(linkPreview: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ImageMessage extends Message {
  const ImageMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, required this.source, this.text, this.thumbhash, this.blurhash, this.width, this.height, this.hasOverlay, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'image',super._();
  factory ImageMessage.fromJson(Map<String, dynamic> json) => _$ImageMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String source;
 final  String? text;
 final  String? thumbhash;
 final  String? blurhash;
 final  double? width;
 final  double? height;
 final  bool? hasOverlay;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageMessageCopyWith<ImageMessage> get copyWith => _$ImageMessageCopyWithImpl<ImageMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.source, source) || other.source == source)&&(identical(other.text, text) || other.text == text)&&(identical(other.thumbhash, thumbhash) || other.thumbhash == thumbhash)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.hasOverlay, hasOverlay) || other.hasOverlay == hasOverlay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata),source,text,thumbhash,blurhash,width,height,hasOverlay]);

@override
String toString() {
  return 'Message.image(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata, source: $source, text: $text, thumbhash: $thumbhash, blurhash: $blurhash, width: $width, height: $height, hasOverlay: $hasOverlay)';
}


}

/// @nodoc
abstract mixin class $ImageMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $ImageMessageCopyWith(ImageMessage value, $Res Function(ImageMessage) _then) = _$ImageMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata, String source, String? text, String? thumbhash, String? blurhash, double? width, double? height, bool? hasOverlay
});




}
/// @nodoc
class _$ImageMessageCopyWithImpl<$Res>
    implements $ImageMessageCopyWith<$Res> {
  _$ImageMessageCopyWithImpl(this._self, this._then);

  final ImageMessage _self;
  final $Res Function(ImageMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,Object? source = null,Object? text = freezed,Object? thumbhash = freezed,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,Object? hasOverlay = freezed,}) {
  return _then(ImageMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,thumbhash: freezed == thumbhash ? _self.thumbhash : thumbhash // ignore: cast_nullable_to_non_nullable
as String?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,hasOverlay: freezed == hasOverlay ? _self.hasOverlay : hasOverlay // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FileMessage extends Message {
  const FileMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, required this.source, required this.name, this.size, this.mimeType, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'file',super._();
  factory FileMessage.fromJson(Map<String, dynamic> json) => _$FileMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String source;
 final  String name;
 final  int? size;
 final  String? mimeType;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileMessageCopyWith<FileMessage> get copyWith => _$FileMessageCopyWithImpl<FileMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.source, source) || other.source == source)&&(identical(other.name, name) || other.name == name)&&(identical(other.size, size) || other.size == size)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata),source,name,size,mimeType);

@override
String toString() {
  return 'Message.file(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata, source: $source, name: $name, size: $size, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $FileMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $FileMessageCopyWith(FileMessage value, $Res Function(FileMessage) _then) = _$FileMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata, String source, String name, int? size, String? mimeType
});




}
/// @nodoc
class _$FileMessageCopyWithImpl<$Res>
    implements $FileMessageCopyWith<$Res> {
  _$FileMessageCopyWithImpl(this._self, this._then);

  final FileMessage _self;
  final $Res Function(FileMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,Object? source = null,Object? name = null,Object? size = freezed,Object? mimeType = freezed,}) {
  return _then(FileMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SystemMessage extends Message {
  const SystemMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, required this.text, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'system',super._();
  factory SystemMessage.fromJson(Map<String, dynamic> json) => _$SystemMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemMessageCopyWith<SystemMessage> get copyWith => _$SystemMessageCopyWithImpl<SystemMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata),text);

@override
String toString() {
  return 'Message.system(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata, text: $text)';
}


}

/// @nodoc
abstract mixin class $SystemMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $SystemMessageCopyWith(SystemMessage value, $Res Function(SystemMessage) _then) = _$SystemMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata, String text
});




}
/// @nodoc
class _$SystemMessageCopyWithImpl<$Res>
    implements $SystemMessageCopyWith<$Res> {
  _$SystemMessageCopyWithImpl(this._self, this._then);

  final SystemMessage _self;
  final $Res Function(SystemMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,Object? text = null,}) {
  return _then(SystemMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CustomMessage extends Message {
  const CustomMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'custom',super._();
  factory CustomMessage.fromJson(Map<String, dynamic> json) => _$CustomMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomMessageCopyWith<CustomMessage> get copyWith => _$CustomMessageCopyWithImpl<CustomMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Message.custom(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $CustomMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $CustomMessageCopyWith(CustomMessage value, $Res Function(CustomMessage) _then) = _$CustomMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$CustomMessageCopyWithImpl<$Res>
    implements $CustomMessageCopyWith<$Res> {
  _$CustomMessageCopyWithImpl(this._self, this._then);

  final CustomMessage _self;
  final $Res Function(CustomMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,}) {
  return _then(CustomMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnsupportedMessage extends Message {
  const UnsupportedMessage({required this.id, required this.authorId, this.replyToId, @EpochDateTimeConverter() required this.createdAt, @EpochDateTimeConverter() this.deletedAt, this.sending, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, final  Map<String, dynamic>? metadata, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'unsupported',super._();
  factory UnsupportedMessage.fromJson(Map<String, dynamic> json) => _$UnsupportedMessageFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? replyToId;
@override@EpochDateTimeConverter() final  DateTime createdAt;
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
@override final  bool? sending;
@override@EpochDateTimeConverter() final  DateTime? failedAt;
@override@EpochDateTimeConverter() final  DateTime? sentAt;
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
@override@EpochDateTimeConverter() final  DateTime? seenAt;
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
 final  Map<String, List<String>>? _reactions;
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsupportedMessageCopyWith<UnsupportedMessage> get copyWith => _$UnsupportedMessageCopyWithImpl<UnsupportedMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsupportedMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsupportedMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToId, replyToId) || other.replyToId == replyToId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToId,createdAt,deletedAt,sending,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Message.unsupported(id: $id, authorId: $authorId, replyToId: $replyToId, createdAt: $createdAt, deletedAt: $deletedAt, sending: $sending, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $UnsupportedMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $UnsupportedMessageCopyWith(UnsupportedMessage value, $Res Function(UnsupportedMessage) _then) = _$UnsupportedMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToId,@EpochDateTimeConverter() DateTime createdAt,@EpochDateTimeConverter() DateTime? deletedAt, bool? sending,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$UnsupportedMessageCopyWithImpl<$Res>
    implements $UnsupportedMessageCopyWith<$Res> {
  _$UnsupportedMessageCopyWithImpl(this._self, this._then);

  final UnsupportedMessage _self;
  final $Res Function(UnsupportedMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToId = freezed,Object? createdAt = null,Object? deletedAt = freezed,Object? sending = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? metadata = freezed,}) {
  return _then(UnsupportedMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToId: freezed == replyToId ? _self.replyToId : replyToId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sending: freezed == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
