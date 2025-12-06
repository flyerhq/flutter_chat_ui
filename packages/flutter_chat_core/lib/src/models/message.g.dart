// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) => TextMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  replyToMessageId: json['replyToMessageId'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  failedAt: _$JsonConverterFromJson<int, DateTime>(
    json['failedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sentAt: _$JsonConverterFromJson<int, DateTime>(
    json['sentAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deliveredAt: _$JsonConverterFromJson<int, DateTime>(
    json['deliveredAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  seenAt: _$JsonConverterFromJson<int, DateTime>(
    json['seenAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  editedAt: _$JsonConverterFromJson<int, DateTime>(
    json['editedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  pinned: json['pinned'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  text: json['text'] as String,
  linkPreviewData: json['linkPreviewData'] == null
      ? null
      : LinkPreviewData.fromJson(
          json['linkPreviewData'] as Map<String, dynamic>,
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'editedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.editedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'text': instance.text,
      'linkPreviewData': ?instance.linkPreviewData?.toJson(),
      'type': instance.$type,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$MessageStatusEnumMap = {
  MessageStatus.delivered: 'delivered',
  MessageStatus.error: 'error',
  MessageStatus.seen: 'seen',
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

TextStreamMessage _$TextStreamMessageFromJson(Map<String, dynamic> json) =>
    TextStreamMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      replyToMessageId: json['replyToMessageId'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
        json['createdAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      failedAt: _$JsonConverterFromJson<int, DateTime>(
        json['failedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sentAt: _$JsonConverterFromJson<int, DateTime>(
        json['sentAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deliveredAt: _$JsonConverterFromJson<int, DateTime>(
        json['deliveredAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      seenAt: _$JsonConverterFromJson<int, DateTime>(
        json['seenAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
        json['updatedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      pinned: json['pinned'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      streamId: json['streamId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TextStreamMessageToJson(TextStreamMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'streamId': instance.streamId,
      'type': instance.$type,
    };

ImageMessage _$ImageMessageFromJson(Map<String, dynamic> json) => ImageMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  replyToMessageId: json['replyToMessageId'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  failedAt: _$JsonConverterFromJson<int, DateTime>(
    json['failedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sentAt: _$JsonConverterFromJson<int, DateTime>(
    json['sentAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deliveredAt: _$JsonConverterFromJson<int, DateTime>(
    json['deliveredAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  seenAt: _$JsonConverterFromJson<int, DateTime>(
    json['seenAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  pinned: json['pinned'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  source: json['source'] as String,
  text: json['text'] as String?,
  thumbhash: json['thumbhash'] as String?,
  blurhash: json['blurhash'] as String?,
  width: (json['width'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  size: (json['size'] as num?)?.toInt(),
  hasOverlay: json['hasOverlay'] as bool?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageMessageToJson(ImageMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'source': instance.source,
      'text': ?instance.text,
      'thumbhash': ?instance.thumbhash,
      'blurhash': ?instance.blurhash,
      'width': ?instance.width,
      'height': ?instance.height,
      'size': ?instance.size,
      'hasOverlay': ?instance.hasOverlay,
      'type': instance.$type,
    };

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  replyToMessageId: json['replyToMessageId'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  failedAt: _$JsonConverterFromJson<int, DateTime>(
    json['failedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sentAt: _$JsonConverterFromJson<int, DateTime>(
    json['sentAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deliveredAt: _$JsonConverterFromJson<int, DateTime>(
    json['deliveredAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  seenAt: _$JsonConverterFromJson<int, DateTime>(
    json['seenAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  pinned: json['pinned'] as bool?,
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
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'source': instance.source,
      'name': instance.name,
      'size': ?instance.size,
      'mimeType': ?instance.mimeType,
      'type': instance.$type,
    };

VideoMessage _$VideoMessageFromJson(Map<String, dynamic> json) => VideoMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  replyToMessageId: json['replyToMessageId'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  failedAt: _$JsonConverterFromJson<int, DateTime>(
    json['failedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sentAt: _$JsonConverterFromJson<int, DateTime>(
    json['sentAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deliveredAt: _$JsonConverterFromJson<int, DateTime>(
    json['deliveredAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  seenAt: _$JsonConverterFromJson<int, DateTime>(
    json['seenAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  pinned: json['pinned'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  source: json['source'] as String,
  text: json['text'] as String?,
  name: json['name'] as String?,
  size: (json['size'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VideoMessageToJson(VideoMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'source': instance.source,
      'text': ?instance.text,
      'name': ?instance.name,
      'size': ?instance.size,
      'width': ?instance.width,
      'height': ?instance.height,
      'type': instance.$type,
    };

AudioMessage _$AudioMessageFromJson(Map<String, dynamic> json) => AudioMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  replyToMessageId: json['replyToMessageId'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  failedAt: _$JsonConverterFromJson<int, DateTime>(
    json['failedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sentAt: _$JsonConverterFromJson<int, DateTime>(
    json['sentAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  deliveredAt: _$JsonConverterFromJson<int, DateTime>(
    json['deliveredAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  seenAt: _$JsonConverterFromJson<int, DateTime>(
    json['seenAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  updatedAt: _$JsonConverterFromJson<int, DateTime>(
    json['updatedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  pinned: json['pinned'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  source: json['source'] as String,
  duration: const DurationConverter().fromJson(
    (json['duration'] as num).toInt(),
  ),
  text: json['text'] as String?,
  size: (json['size'] as num?)?.toInt(),
  waveform: (json['waveform'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AudioMessageToJson(AudioMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'source': instance.source,
      'duration': const DurationConverter().toJson(instance.duration),
      'text': ?instance.text,
      'size': ?instance.size,
      'waveform': ?instance.waveform,
      'type': instance.$type,
    };

SystemMessage _$SystemMessageFromJson(Map<String, dynamic> json) =>
    SystemMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      replyToMessageId: json['replyToMessageId'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
        json['createdAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      failedAt: _$JsonConverterFromJson<int, DateTime>(
        json['failedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sentAt: _$JsonConverterFromJson<int, DateTime>(
        json['sentAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deliveredAt: _$JsonConverterFromJson<int, DateTime>(
        json['deliveredAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      seenAt: _$JsonConverterFromJson<int, DateTime>(
        json['seenAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
        json['updatedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      pinned: json['pinned'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      text: json['text'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SystemMessageToJson(SystemMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'text': instance.text,
      'type': instance.$type,
    };

CustomMessage _$CustomMessageFromJson(Map<String, dynamic> json) =>
    CustomMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      replyToMessageId: json['replyToMessageId'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
        json['createdAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      failedAt: _$JsonConverterFromJson<int, DateTime>(
        json['failedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sentAt: _$JsonConverterFromJson<int, DateTime>(
        json['sentAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deliveredAt: _$JsonConverterFromJson<int, DateTime>(
        json['deliveredAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      seenAt: _$JsonConverterFromJson<int, DateTime>(
        json['seenAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
        json['updatedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      pinned: json['pinned'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CustomMessageToJson(CustomMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'type': instance.$type,
    };

UnsupportedMessage _$UnsupportedMessageFromJson(Map<String, dynamic> json) =>
    UnsupportedMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      replyToMessageId: json['replyToMessageId'] as String?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
        json['createdAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      failedAt: _$JsonConverterFromJson<int, DateTime>(
        json['failedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sentAt: _$JsonConverterFromJson<int, DateTime>(
        json['sentAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      deliveredAt: _$JsonConverterFromJson<int, DateTime>(
        json['deliveredAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      seenAt: _$JsonConverterFromJson<int, DateTime>(
        json['seenAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
        json['updatedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      pinned: json['pinned'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UnsupportedMessageToJson(UnsupportedMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'replyToMessageId': ?instance.replyToMessageId,
      'createdAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deletedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'failedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'sentAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      ),
      'deliveredAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      ),
      'seenAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      ),
      'updatedAt': ?_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      ),
      'reactions': ?instance.reactions,
      'pinned': ?instance.pinned,
      'metadata': ?instance.metadata,
      'status': ?_$MessageStatusEnumMap[instance.status],
      'type': instance.$type,
    };
