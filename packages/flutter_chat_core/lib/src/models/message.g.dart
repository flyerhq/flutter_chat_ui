// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextMessageImpl _$$TextMessageImplFromJson(Map<String, dynamic> json) =>
    _$TextMessageImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      text: json['text'] as String,
      linkPreview:
          json['linkPreview'] == null
              ? null
              : LinkPreview.fromJson(
                json['linkPreview'] as Map<String, dynamic>,
              ),
      isOnlyEmoji: json['isOnlyEmoji'] as bool?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextMessageImplToJson(
  _$TextMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  if (instance.metadata case final value?) 'metadata': value,
  'text': instance.text,
  if (instance.linkPreview?.toJson() case final value?) 'linkPreview': value,
  if (instance.isOnlyEmoji case final value?) 'isOnlyEmoji': value,
  'type': instance.$type,
};

_$ImageMessageImpl _$$ImageMessageImplFromJson(Map<String, dynamic> json) =>
    _$ImageMessageImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      source: json['source'] as String,
      thumbhash: json['thumbhash'] as String?,
      blurhash: json['blurhash'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      overlay: json['overlay'] as bool?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageMessageImplToJson(_$ImageMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      'source': instance.source,
      if (instance.thumbhash case final value?) 'thumbhash': value,
      if (instance.blurhash case final value?) 'blurhash': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.overlay case final value?) 'overlay': value,
      'type': instance.$type,
    };

_$CustomMessageImpl _$$CustomMessageImplFromJson(Map<String, dynamic> json) =>
    _$CustomMessageImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CustomMessageImplToJson(_$CustomMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      'type': instance.$type,
    };

_$UnsupportedMessageImpl _$$UnsupportedMessageImplFromJson(
  Map<String, dynamic> json,
) => _$UnsupportedMessageImpl(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$UnsupportedMessageImplToJson(
  _$UnsupportedMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  if (instance.metadata case final value?) 'metadata': value,
  'type': instance.$type,
};
