// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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
                case 'textStream':
          return TextStreamMessage.fromJson(
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
                case 'video':
          return VideoMessage.fromJson(
            json
          );
                case 'audio':
          return AudioMessage.fromJson(
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

/// Unique identifier for the message.
 String get id;/// ID of the user who sent the message.
 String get authorId;/// ID of the message this one is replying to.
 String? get replyToMessageId;/// Timestamp when the message was created.
@EpochDateTimeConverter() DateTime? get createdAt;/// Timestamp when the message was marked as deleted.
@EpochDateTimeConverter() DateTime? get deletedAt;/// Timestamp when the message failed to send.
@EpochDateTimeConverter() DateTime? get failedAt;/// Timestamp when the message was successfully sent.
@EpochDateTimeConverter() DateTime? get sentAt;/// Timestamp when the message was delivered to the recipient.
@EpochDateTimeConverter() DateTime? get deliveredAt;/// Timestamp when the message was seen by the recipient.
@EpochDateTimeConverter() DateTime? get seenAt;/// Timestamp when the message was last updated.
@EpochDateTimeConverter() DateTime? get updatedAt;/// Map of reaction keys to lists of user IDs who reacted.
 Map<String, List<String>>? get reactions;/// Indicates if the message is pinned.
 bool? get pinned;/// Additional custom metadata associated with the message.
 Map<String, dynamic>? get metadata;/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
 MessageStatus? get status;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(reactions),pinned,const DeepCollectionEquality().hash(metadata),status);

@override
String toString() {
  return 'Message(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextMessage value)?  text,TResult Function( TextStreamMessage value)?  textStream,TResult Function( ImageMessage value)?  image,TResult Function( FileMessage value)?  file,TResult Function( VideoMessage value)?  video,TResult Function( AudioMessage value)?  audio,TResult Function( SystemMessage value)?  system,TResult Function( CustomMessage value)?  custom,TResult Function( UnsupportedMessage value)?  unsupported,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that);case TextStreamMessage() when textStream != null:
return textStream(_that);case ImageMessage() when image != null:
return image(_that);case FileMessage() when file != null:
return file(_that);case VideoMessage() when video != null:
return video(_that);case AudioMessage() when audio != null:
return audio(_that);case SystemMessage() when system != null:
return system(_that);case CustomMessage() when custom != null:
return custom(_that);case UnsupportedMessage() when unsupported != null:
return unsupported(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextMessage value)  text,required TResult Function( TextStreamMessage value)  textStream,required TResult Function( ImageMessage value)  image,required TResult Function( FileMessage value)  file,required TResult Function( VideoMessage value)  video,required TResult Function( AudioMessage value)  audio,required TResult Function( SystemMessage value)  system,required TResult Function( CustomMessage value)  custom,required TResult Function( UnsupportedMessage value)  unsupported,}){
final _that = this;
switch (_that) {
case TextMessage():
return text(_that);case TextStreamMessage():
return textStream(_that);case ImageMessage():
return image(_that);case FileMessage():
return file(_that);case VideoMessage():
return video(_that);case AudioMessage():
return audio(_that);case SystemMessage():
return system(_that);case CustomMessage():
return custom(_that);case UnsupportedMessage():
return unsupported(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextMessage value)?  text,TResult? Function( TextStreamMessage value)?  textStream,TResult? Function( ImageMessage value)?  image,TResult? Function( FileMessage value)?  file,TResult? Function( VideoMessage value)?  video,TResult? Function( AudioMessage value)?  audio,TResult? Function( SystemMessage value)?  system,TResult? Function( CustomMessage value)?  custom,TResult? Function( UnsupportedMessage value)?  unsupported,}){
final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that);case TextStreamMessage() when textStream != null:
return textStream(_that);case ImageMessage() when image != null:
return image(_that);case FileMessage() when file != null:
return file(_that);case VideoMessage() when video != null:
return video(_that);case AudioMessage() when audio != null:
return audio(_that);case SystemMessage() when system != null:
return system(_that);case CustomMessage() when custom != null:
return custom(_that);case UnsupportedMessage() when unsupported != null:
return unsupported(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt, @EpochDateTimeConverter()  DateTime? editedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text,  LinkPreviewData? linkPreviewData)?  text,TResult Function( String id,  String authorId,  String? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<String>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String streamId)?  textStream,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? thumbhash,  String? blurhash,  double? width,  double? height,  int? size,  bool? hasOverlay)?  image,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String name,  int? size,  String? mimeType)?  file,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? name,  int? size,  double? width,  double? height)?  video,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source, @DurationConverter()  Duration duration,  String? text,  int? size,  List<double>? waveform)?  audio,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text)?  system,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)?  custom,TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)?  unsupported,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.editedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text,_that.linkPreviewData);case TextStreamMessage() when textStream != null:
return textStream(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.streamId);case ImageMessage() when image != null:
return image(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.thumbhash,_that.blurhash,_that.width,_that.height,_that.size,_that.hasOverlay);case FileMessage() when file != null:
return file(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.name,_that.size,_that.mimeType);case VideoMessage() when video != null:
return video(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.name,_that.size,_that.width,_that.height);case AudioMessage() when audio != null:
return audio(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.duration,_that.text,_that.size,_that.waveform);case SystemMessage() when system != null:
return system(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text);case CustomMessage() when custom != null:
return custom(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);case UnsupportedMessage() when unsupported != null:
return unsupported(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt, @EpochDateTimeConverter()  DateTime? editedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text,  LinkPreviewData? linkPreviewData)  text,required TResult Function( String id,  String authorId,  String? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<String>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String streamId)  textStream,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? thumbhash,  String? blurhash,  double? width,  double? height,  int? size,  bool? hasOverlay)  image,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String name,  int? size,  String? mimeType)  file,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? name,  int? size,  double? width,  double? height)  video,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source, @DurationConverter()  Duration duration,  String? text,  int? size,  List<double>? waveform)  audio,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text)  system,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)  custom,required TResult Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)  unsupported,}) {final _that = this;
switch (_that) {
case TextMessage():
return text(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.editedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text,_that.linkPreviewData);case TextStreamMessage():
return textStream(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.streamId);case ImageMessage():
return image(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.thumbhash,_that.blurhash,_that.width,_that.height,_that.size,_that.hasOverlay);case FileMessage():
return file(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.name,_that.size,_that.mimeType);case VideoMessage():
return video(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.name,_that.size,_that.width,_that.height);case AudioMessage():
return audio(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.duration,_that.text,_that.size,_that.waveform);case SystemMessage():
return system(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text);case CustomMessage():
return custom(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);case UnsupportedMessage():
return unsupported(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt, @EpochDateTimeConverter()  DateTime? editedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text,  LinkPreviewData? linkPreviewData)?  text,TResult? Function( String id,  String authorId,  String? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<String>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String streamId)?  textStream,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? thumbhash,  String? blurhash,  double? width,  double? height,  int? size,  bool? hasOverlay)?  image,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String name,  int? size,  String? mimeType)?  file,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source,  String? text,  String? name,  int? size,  double? width,  double? height)?  video,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String source, @DurationConverter()  Duration duration,  String? text,  int? size,  List<double>? waveform)?  audio,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status,  String text)?  system,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)?  custom,TResult? Function( MessageID id,  UserID authorId,  MessageID? replyToMessageId, @EpochDateTimeConverter()  DateTime? createdAt, @EpochDateTimeConverter()  DateTime? deletedAt, @EpochDateTimeConverter()  DateTime? failedAt, @EpochDateTimeConverter()  DateTime? sentAt, @EpochDateTimeConverter()  DateTime? deliveredAt, @EpochDateTimeConverter()  DateTime? seenAt, @EpochDateTimeConverter()  DateTime? updatedAt,  Map<String, List<UserID>>? reactions,  bool? pinned,  Map<String, dynamic>? metadata,  MessageStatus? status)?  unsupported,}) {final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.editedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text,_that.linkPreviewData);case TextStreamMessage() when textStream != null:
return textStream(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.streamId);case ImageMessage() when image != null:
return image(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.thumbhash,_that.blurhash,_that.width,_that.height,_that.size,_that.hasOverlay);case FileMessage() when file != null:
return file(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.name,_that.size,_that.mimeType);case VideoMessage() when video != null:
return video(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.text,_that.name,_that.size,_that.width,_that.height);case AudioMessage() when audio != null:
return audio(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.source,_that.duration,_that.text,_that.size,_that.waveform);case SystemMessage() when system != null:
return system(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status,_that.text);case CustomMessage() when custom != null:
return custom(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);case UnsupportedMessage() when unsupported != null:
return unsupported(_that.id,_that.authorId,_that.replyToMessageId,_that.createdAt,_that.deletedAt,_that.failedAt,_that.sentAt,_that.deliveredAt,_that.seenAt,_that.updatedAt,_that.reactions,_that.pinned,_that.metadata,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextMessage extends Message {
  const TextMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, @EpochDateTimeConverter() this.editedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.text, this.linkPreviewData, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'text',super._();
  factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Timestamp when the message was last edited.
@EpochDateTimeConverter() final  DateTime? editedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// The text content of the message.
 final  String text;
/// Optional preview data for a link found in the [text].
 final  LinkPreviewData? linkPreviewData;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.text, text) || other.text == text)&&(identical(other.linkPreviewData, linkPreviewData) || other.linkPreviewData == linkPreviewData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,editedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,text,linkPreviewData);

@override
String toString() {
  return 'Message.text(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, editedAt: $editedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, text: $text, linkPreviewData: $linkPreviewData)';
}


}

/// @nodoc
abstract mixin class $TextMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $TextMessageCopyWith(TextMessage value, $Res Function(TextMessage) _then) = _$TextMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt,@EpochDateTimeConverter() DateTime? editedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String text, LinkPreviewData? linkPreviewData
});


$LinkPreviewDataCopyWith<$Res>? get linkPreviewData;

}
/// @nodoc
class _$TextMessageCopyWithImpl<$Res>
    implements $TextMessageCopyWith<$Res> {
  _$TextMessageCopyWithImpl(this._self, this._then);

  final TextMessage _self;
  final $Res Function(TextMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? editedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? text = null,Object? linkPreviewData = freezed,}) {
  return _then(TextMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,linkPreviewData: freezed == linkPreviewData ? _self.linkPreviewData : linkPreviewData // ignore: cast_nullable_to_non_nullable
as LinkPreviewData?,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkPreviewDataCopyWith<$Res>? get linkPreviewData {
    if (_self.linkPreviewData == null) {
    return null;
  }

  return $LinkPreviewDataCopyWith<$Res>(_self.linkPreviewData!, (value) {
    return _then(_self.copyWith(linkPreviewData: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class TextStreamMessage extends Message {
  const TextStreamMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<String>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.streamId, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'textStream',super._();
  factory TextStreamMessage.fromJson(Map<String, dynamic> json) => _$TextStreamMessageFromJson(json);

/// Unique identifier for the message.
@override final  String id;
/// ID of the user (typically the AI) sending the message.
@override final  String authorId;
/// ID of the message this one is replying to.
@override final  String? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message sending failed (e.g., network error during stream).
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent (e.g., stream completed).
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was fully delivered (stream completed).
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<String>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<String>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// Identifier for the stream this message belongs to.
 final  String streamId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextStreamMessageCopyWith<TextStreamMessage> get copyWith => _$TextStreamMessageCopyWithImpl<TextStreamMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextStreamMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextStreamMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.streamId, streamId) || other.streamId == streamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,streamId);

@override
String toString() {
  return 'Message.textStream(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, streamId: $streamId)';
}


}

/// @nodoc
abstract mixin class $TextStreamMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $TextStreamMessageCopyWith(TextStreamMessage value, $Res Function(TextStreamMessage) _then) = _$TextStreamMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<String>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String streamId
});




}
/// @nodoc
class _$TextStreamMessageCopyWithImpl<$Res>
    implements $TextStreamMessageCopyWith<$Res> {
  _$TextStreamMessageCopyWithImpl(this._self, this._then);

  final TextStreamMessage _self;
  final $Res Function(TextStreamMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? streamId = null,}) {
  return _then(TextStreamMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ImageMessage extends Message {
  const ImageMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.source, this.text, this.thumbhash, this.blurhash, this.width, this.height, this.size, this.hasOverlay, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'image',super._();
  factory ImageMessage.fromJson(Map<String, dynamic> json) => _$ImageMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// Source URL or path of the image.
 final  String source;
/// Optional text caption accompanying the image.
 final  String? text;
/// ThumbHash string for a low-resolution placeholder.
 final  String? thumbhash;
/// BlurHash string for a low-resolution placeholder.
 final  String? blurhash;
/// Width of the image in pixels.
 final  double? width;
/// Height of the image in pixels.
 final  double? height;
/// Size of the image in bytes.
 final  int? size;
/// Indicates if an overlay should be shown (e.g., for NSFW content).
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.text, text) || other.text == text)&&(identical(other.thumbhash, thumbhash) || other.thumbhash == thumbhash)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size)&&(identical(other.hasOverlay, hasOverlay) || other.hasOverlay == hasOverlay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,source,text,thumbhash,blurhash,width,height,size,hasOverlay]);

@override
String toString() {
  return 'Message.image(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, source: $source, text: $text, thumbhash: $thumbhash, blurhash: $blurhash, width: $width, height: $height, size: $size, hasOverlay: $hasOverlay)';
}


}

/// @nodoc
abstract mixin class $ImageMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $ImageMessageCopyWith(ImageMessage value, $Res Function(ImageMessage) _then) = _$ImageMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String source, String? text, String? thumbhash, String? blurhash, double? width, double? height, int? size, bool? hasOverlay
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? source = null,Object? text = freezed,Object? thumbhash = freezed,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,Object? size = freezed,Object? hasOverlay = freezed,}) {
  return _then(ImageMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,thumbhash: freezed == thumbhash ? _self.thumbhash : thumbhash // ignore: cast_nullable_to_non_nullable
as String?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,hasOverlay: freezed == hasOverlay ? _self.hasOverlay : hasOverlay // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FileMessage extends Message {
  const FileMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.source, required this.name, this.size, this.mimeType, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'file',super._();
  factory FileMessage.fromJson(Map<String, dynamic> json) => _$FileMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// Source URL or path of the file.
 final  String source;
/// Name of the file.
 final  String name;
/// Size of the file in bytes.
 final  int? size;
/// MIME type of the file.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.name, name) || other.name == name)&&(identical(other.size, size) || other.size == size)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,source,name,size,mimeType);

@override
String toString() {
  return 'Message.file(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, source: $source, name: $name, size: $size, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $FileMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $FileMessageCopyWith(FileMessage value, $Res Function(FileMessage) _then) = _$FileMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String source, String name, int? size, String? mimeType
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? source = null,Object? name = null,Object? size = freezed,Object? mimeType = freezed,}) {
  return _then(FileMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VideoMessage extends Message {
  const VideoMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.source, this.text, this.name, this.size, this.width, this.height, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'video',super._();
  factory VideoMessage.fromJson(Map<String, dynamic> json) => _$VideoMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// Source URL or path of the video.
 final  String source;
/// Optional text caption accompanying the video.
 final  String? text;
/// Name of the video.
 final  String? name;
/// Size of the video in bytes.
 final  int? size;
/// Width of the video in pixels.
 final  double? width;
/// Height of the video in pixels.
 final  double? height;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoMessageCopyWith<VideoMessage> get copyWith => _$VideoMessageCopyWithImpl<VideoMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.text, text) || other.text == text)&&(identical(other.name, name) || other.name == name)&&(identical(other.size, size) || other.size == size)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,source,text,name,size,width,height]);

@override
String toString() {
  return 'Message.video(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, source: $source, text: $text, name: $name, size: $size, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $VideoMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $VideoMessageCopyWith(VideoMessage value, $Res Function(VideoMessage) _then) = _$VideoMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String source, String? text, String? name, int? size, double? width, double? height
});




}
/// @nodoc
class _$VideoMessageCopyWithImpl<$Res>
    implements $VideoMessageCopyWith<$Res> {
  _$VideoMessageCopyWithImpl(this._self, this._then);

  final VideoMessage _self;
  final $Res Function(VideoMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? source = null,Object? text = freezed,Object? name = freezed,Object? size = freezed,Object? width = freezed,Object? height = freezed,}) {
  return _then(VideoMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AudioMessage extends Message {
  const AudioMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.source, @DurationConverter() required this.duration, this.text, this.size, final  List<double>? waveform, final  String? $type}): _reactions = reactions,_metadata = metadata,_waveform = waveform,$type = $type ?? 'audio',super._();
  factory AudioMessage.fromJson(Map<String, dynamic> json) => _$AudioMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// Source URL or path of the audio.
 final  String source;
/// Duration of the audio.
@DurationConverter() final  Duration duration;
/// Optional text caption accompanying the audio.
 final  String? text;
/// Size of the audio in bytes.
 final  int? size;
/// Waveform data for the audio.
 final  List<double>? _waveform;
/// Waveform data for the audio.
 List<double>? get waveform {
  final value = _waveform;
  if (value == null) return null;
  if (_waveform is EqualUnmodifiableListView) return _waveform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioMessageCopyWith<AudioMessage> get copyWith => _$AudioMessageCopyWithImpl<AudioMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.text, text) || other.text == text)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._waveform, _waveform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,source,duration,text,size,const DeepCollectionEquality().hash(_waveform)]);

@override
String toString() {
  return 'Message.audio(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, source: $source, duration: $duration, text: $text, size: $size, waveform: $waveform)';
}


}

/// @nodoc
abstract mixin class $AudioMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $AudioMessageCopyWith(AudioMessage value, $Res Function(AudioMessage) _then) = _$AudioMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String source,@DurationConverter() Duration duration, String? text, int? size, List<double>? waveform
});




}
/// @nodoc
class _$AudioMessageCopyWithImpl<$Res>
    implements $AudioMessageCopyWith<$Res> {
  _$AudioMessageCopyWithImpl(this._self, this._then);

  final AudioMessage _self;
  final $Res Function(AudioMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? source = null,Object? duration = null,Object? text = freezed,Object? size = freezed,Object? waveform = freezed,}) {
  return _then(AudioMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,waveform: freezed == waveform ? _self._waveform : waveform // ignore: cast_nullable_to_non_nullable
as List<double>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SystemMessage extends Message {
  const SystemMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, required this.text, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'system',super._();
  factory SystemMessage.fromJson(Map<String, dynamic> json) => _$SystemMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user associated with the system event (often a system ID).
@override final  UserID authorId;
/// ID of the message this one is replying to (usually null for system messages).
@override final  MessageID? replyToMessageId;
/// Timestamp when the system event occurred.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send (usually null for system messages).
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent (usually null for system messages).
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered (usually null for system messages).
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen (usually null for system messages).
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;
/// The text content of the system message.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status,text);

@override
String toString() {
  return 'Message.system(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status, text: $text)';
}


}

/// @nodoc
abstract mixin class $SystemMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $SystemMessageCopyWith(SystemMessage value, $Res Function(SystemMessage) _then) = _$SystemMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status, String text
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,Object? text = null,}) {
  return _then(SystemMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CustomMessage extends Message {
  const CustomMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'custom',super._();
  factory CustomMessage.fromJson(Map<String, dynamic> json) => _$CustomMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Application-specific custom metadata.
 final  Map<String, dynamic>? _metadata;
/// Application-specific custom metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status);

@override
String toString() {
  return 'Message.custom(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status)';
}


}

/// @nodoc
abstract mixin class $CustomMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $CustomMessageCopyWith(CustomMessage value, $Res Function(CustomMessage) _then) = _$CustomMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,}) {
  return _then(CustomMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnsupportedMessage extends Message {
  const UnsupportedMessage({required this.id, required this.authorId, this.replyToMessageId, @EpochDateTimeConverter() this.createdAt, @EpochDateTimeConverter() this.deletedAt, @EpochDateTimeConverter() this.failedAt, @EpochDateTimeConverter() this.sentAt, @EpochDateTimeConverter() this.deliveredAt, @EpochDateTimeConverter() this.seenAt, @EpochDateTimeConverter() this.updatedAt, final  Map<String, List<UserID>>? reactions, this.pinned, final  Map<String, dynamic>? metadata, this.status, final  String? $type}): _reactions = reactions,_metadata = metadata,$type = $type ?? 'unsupported',super._();
  factory UnsupportedMessage.fromJson(Map<String, dynamic> json) => _$UnsupportedMessageFromJson(json);

/// Unique identifier for the message.
@override final  MessageID id;
/// ID of the user who sent the message.
@override final  UserID authorId;
/// ID of the message this one is replying to.
@override final  MessageID? replyToMessageId;
/// Timestamp when the message was created.
@override@EpochDateTimeConverter() final  DateTime? createdAt;
/// Timestamp when the message was marked as deleted.
@override@EpochDateTimeConverter() final  DateTime? deletedAt;
/// Timestamp when the message failed to send.
@override@EpochDateTimeConverter() final  DateTime? failedAt;
/// Timestamp when the message was successfully sent.
@override@EpochDateTimeConverter() final  DateTime? sentAt;
/// Timestamp when the message was delivered to the recipient.
@override@EpochDateTimeConverter() final  DateTime? deliveredAt;
/// Timestamp when the message was seen by the recipient.
@override@EpochDateTimeConverter() final  DateTime? seenAt;
/// Timestamp when the message was last updated.
@override@EpochDateTimeConverter() final  DateTime? updatedAt;
/// Map of reaction keys to lists of user IDs who reacted.
 final  Map<String, List<UserID>>? _reactions;
/// Map of reaction keys to lists of user IDs who reacted.
@override Map<String, List<UserID>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Indicates if the message is pinned.
@override final  bool? pinned;
/// Additional custom metadata associated with the message.
 final  Map<String, dynamic>? _metadata;
/// Additional custom metadata associated with the message.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Status of the message. Takes precedence over the timestamp based status.
/// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
@override final  MessageStatus? status;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsupportedMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,replyToMessageId,createdAt,deletedAt,failedAt,sentAt,deliveredAt,seenAt,updatedAt,const DeepCollectionEquality().hash(_reactions),pinned,const DeepCollectionEquality().hash(_metadata),status);

@override
String toString() {
  return 'Message.unsupported(id: $id, authorId: $authorId, replyToMessageId: $replyToMessageId, createdAt: $createdAt, deletedAt: $deletedAt, failedAt: $failedAt, sentAt: $sentAt, deliveredAt: $deliveredAt, seenAt: $seenAt, updatedAt: $updatedAt, reactions: $reactions, pinned: $pinned, metadata: $metadata, status: $status)';
}


}

/// @nodoc
abstract mixin class $UnsupportedMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $UnsupportedMessageCopyWith(UnsupportedMessage value, $Res Function(UnsupportedMessage) _then) = _$UnsupportedMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageID id, UserID authorId, MessageID? replyToMessageId,@EpochDateTimeConverter() DateTime? createdAt,@EpochDateTimeConverter() DateTime? deletedAt,@EpochDateTimeConverter() DateTime? failedAt,@EpochDateTimeConverter() DateTime? sentAt,@EpochDateTimeConverter() DateTime? deliveredAt,@EpochDateTimeConverter() DateTime? seenAt,@EpochDateTimeConverter() DateTime? updatedAt, Map<String, List<UserID>>? reactions, bool? pinned, Map<String, dynamic>? metadata, MessageStatus? status
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? replyToMessageId = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,Object? failedAt = freezed,Object? sentAt = freezed,Object? deliveredAt = freezed,Object? seenAt = freezed,Object? updatedAt = freezed,Object? reactions = freezed,Object? pinned = freezed,Object? metadata = freezed,Object? status = freezed,}) {
  return _then(UnsupportedMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as MessageID,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as UserID,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as MessageID?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<UserID>>?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus?,
  ));
}


}

// dart format on
