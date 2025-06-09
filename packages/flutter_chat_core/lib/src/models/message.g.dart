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
  linkPreviewData:
      json['linkPreviewData'] == null
          ? null
          : LinkPreviewData.fromJson(
            json['linkPreviewData'] as Map<String, dynamic>,
          ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextMessageToJson(
  TextMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.editedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'editedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'text': instance.text,
  if (instance.linkPreviewData?.toJson() case final value?)
    'linkPreviewData': value,
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

Map<String, dynamic> _$TextStreamMessageToJson(
  TextStreamMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
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

Map<String, dynamic> _$ImageMessageToJson(
  ImageMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'source': instance.source,
  if (instance.text case final value?) 'text': value,
  if (instance.thumbhash case final value?) 'thumbhash': value,
  if (instance.blurhash case final value?) 'blurhash': value,
  if (instance.width case final value?) 'width': value,
  if (instance.height case final value?) 'height': value,
  if (instance.size case final value?) 'size': value,
  if (instance.hasOverlay case final value?) 'hasOverlay': value,
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

Map<String, dynamic> _$FileMessageToJson(
  FileMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'source': instance.source,
  'name': instance.name,
  if (instance.size case final value?) 'size': value,
  if (instance.mimeType case final value?) 'mimeType': value,
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

Map<String, dynamic> _$VideoMessageToJson(
  VideoMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'source': instance.source,
  if (instance.text case final value?) 'text': value,
  if (instance.name case final value?) 'name': value,
  if (instance.size case final value?) 'size': value,
  if (instance.width case final value?) 'width': value,
  if (instance.height case final value?) 'height': value,
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
  waveform:
      (json['waveform'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AudioMessageToJson(
  AudioMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'source': instance.source,
  'duration': const DurationConverter().toJson(instance.duration),
  if (instance.text case final value?) 'text': value,
  if (instance.size case final value?) 'size': value,
  if (instance.waveform case final value?) 'waveform': value,
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

Map<String, dynamic> _$SystemMessageToJson(
  SystemMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
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

Map<String, dynamic> _$CustomMessageToJson(
  CustomMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
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

Map<String, dynamic> _$UnsupportedMessageToJson(
  UnsupportedMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorId': instance.authorId,
  if (instance.replyToMessageId case final value?) 'replyToMessageId': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.createdAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'createdAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.failedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'failedAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.sentAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'sentAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deliveredAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deliveredAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.seenAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'seenAt': value,
  if (_$JsonConverterToJson<int, DateTime>(
        instance.updatedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'updatedAt': value,
  if (instance.reactions case final value?) 'reactions': value,
  if (instance.pinned case final value?) 'pinned': value,
  if (instance.metadata case final value?) 'metadata': value,
  if (_$MessageStatusEnumMap[instance.status] case final value?)
    'status': value,
  'type': instance.$type,
};
