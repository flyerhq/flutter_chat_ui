// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) => TextMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  text: json['text'] as String,
  linkPreview:
      json['linkPreview'] == null
          ? null
          : LinkPreview.fromJson(json['linkPreview'] as Map<String, dynamic>),
  isOnlyEmoji: json['isOnlyEmoji'] as bool?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextMessageToJson(
  TextMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'text': instance.text,
  if (instance.linkPreview?.toJson() case final value?) 'linkPreview': value,
  if (instance.isOnlyEmoji case final value?) 'isOnlyEmoji': value,
  'type': instance.$type,
};

const _$MessageStatusEnumMap = {
  MessageStatus.delivered: 'delivered',
  MessageStatus.error: 'error',
  MessageStatus.seen: 'seen',
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
};

ImageMessage _$ImageMessageFromJson(Map<String, dynamic> json) => ImageMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  source: json['source'] as String,
  thumbhash: json['thumbhash'] as String?,
  blurhash: json['blurhash'] as String?,
  width: (json['width'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  overlay: json['overlay'] as bool?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageMessageToJson(ImageMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      if (_$MessageStatusEnumMap[instance.status] case final value?)
        'status': value,
      'source': instance.source,
      if (instance.thumbhash case final value?) 'thumbhash': value,
      if (instance.blurhash case final value?) 'blurhash': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.overlay case final value?) 'overlay': value,
      'type': instance.$type,
    };

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  source: json['source'] as String,
  name: json['name'] as String,
  size: (json['size'] as num?)?.toInt(),
  mimeType: json['mimeType'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FileMessageToJson(FileMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      if (_$MessageStatusEnumMap[instance.status] case final value?)
        'status': value,
      'source': instance.source,
      'name': instance.name,
      if (instance.size case final value?) 'size': value,
      if (instance.mimeType case final value?) 'mimeType': value,
      'type': instance.$type,
    };

SystemMessage _$SystemMessageFromJson(Map<String, dynamic> json) =>
    SystemMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      text: json['text'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SystemMessageToJson(SystemMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      if (_$MessageStatusEnumMap[instance.status] case final value?)
        'status': value,
      'text': instance.text,
      'type': instance.$type,
    };

CustomMessage _$CustomMessageFromJson(Map<String, dynamic> json) =>
    CustomMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CustomMessageToJson(CustomMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      if (_$MessageStatusEnumMap[instance.status] case final value?)
        'status': value,
      'type': instance.$type,
    };

UnsupportedMessage _$UnsupportedMessageFromJson(Map<String, dynamic> json) =>
    UnsupportedMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UnsupportedMessageToJson(UnsupportedMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (instance.metadata case final value?) 'metadata': value,
      if (_$MessageStatusEnumMap[instance.status] case final value?)
        'status': value,
      'type': instance.$type,
    };
