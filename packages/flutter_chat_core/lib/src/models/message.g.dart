// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) => TextMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  parentId: json['parentId'] as String?,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sending: json['sending'] as bool?,
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
  metadata: json['metadata'] as Map<String, dynamic>?,
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
  if (instance.parentId case final value?) 'parentId': value,
  'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  if (_$JsonConverterToJson<int, DateTime>(
        instance.deletedAt,
        const EpochDateTimeConverter().toJson,
      )
      case final value?)
    'deletedAt': value,
  if (instance.sending case final value?) 'sending': value,
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
  if (instance.metadata case final value?) 'metadata': value,
  'text': instance.text,
  if (instance.linkPreview?.toJson() case final value?) 'linkPreview': value,
  if (instance.isOnlyEmoji case final value?) 'isOnlyEmoji': value,
  'type': instance.$type,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

ImageMessage _$ImageMessageFromJson(Map<String, dynamic> json) => ImageMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  parentId: json['parentId'] as String?,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sending: json['sending'] as bool?,
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
  metadata: json['metadata'] as Map<String, dynamic>?,
  source: json['source'] as String,
  text: json['text'] as String?,
  thumbhash: json['thumbhash'] as String?,
  blurhash: json['blurhash'] as String?,
  width: (json['width'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  hasOverlay: json['hasOverlay'] as bool?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageMessageToJson(ImageMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      if (instance.parentId case final value?) 'parentId': value,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (_$JsonConverterToJson<int, DateTime>(
            instance.deletedAt,
            const EpochDateTimeConverter().toJson,
          )
          case final value?)
        'deletedAt': value,
      if (instance.sending case final value?) 'sending': value,
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
      if (instance.metadata case final value?) 'metadata': value,
      'source': instance.source,
      if (instance.text case final value?) 'text': value,
      if (instance.thumbhash case final value?) 'thumbhash': value,
      if (instance.blurhash case final value?) 'blurhash': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.hasOverlay case final value?) 'hasOverlay': value,
      'type': instance.$type,
    };

FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  parentId: json['parentId'] as String?,
  createdAt: const EpochDateTimeConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  deletedAt: _$JsonConverterFromJson<int, DateTime>(
    json['deletedAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  sending: json['sending'] as bool?,
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
  metadata: json['metadata'] as Map<String, dynamic>?,
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
      if (instance.parentId case final value?) 'parentId': value,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (_$JsonConverterToJson<int, DateTime>(
            instance.deletedAt,
            const EpochDateTimeConverter().toJson,
          )
          case final value?)
        'deletedAt': value,
      if (instance.sending case final value?) 'sending': value,
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
      if (instance.metadata case final value?) 'metadata': value,
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
      parentId: json['parentId'] as String?,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sending: json['sending'] as bool?,
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
      metadata: json['metadata'] as Map<String, dynamic>?,
      text: json['text'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SystemMessageToJson(SystemMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      if (instance.parentId case final value?) 'parentId': value,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (_$JsonConverterToJson<int, DateTime>(
            instance.deletedAt,
            const EpochDateTimeConverter().toJson,
          )
          case final value?)
        'deletedAt': value,
      if (instance.sending case final value?) 'sending': value,
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
      if (instance.metadata case final value?) 'metadata': value,
      'text': instance.text,
      'type': instance.$type,
    };

CustomMessage _$CustomMessageFromJson(Map<String, dynamic> json) =>
    CustomMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      parentId: json['parentId'] as String?,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sending: json['sending'] as bool?,
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
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CustomMessageToJson(CustomMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      if (instance.parentId case final value?) 'parentId': value,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (_$JsonConverterToJson<int, DateTime>(
            instance.deletedAt,
            const EpochDateTimeConverter().toJson,
          )
          case final value?)
        'deletedAt': value,
      if (instance.sending case final value?) 'sending': value,
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
      if (instance.metadata case final value?) 'metadata': value,
      'type': instance.$type,
    };

UnsupportedMessage _$UnsupportedMessageFromJson(Map<String, dynamic> json) =>
    UnsupportedMessage(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      parentId: json['parentId'] as String?,
      createdAt: const EpochDateTimeConverter().fromJson(
        (json['createdAt'] as num).toInt(),
      ),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
        json['deletedAt'],
        const EpochDateTimeConverter().fromJson,
      ),
      sending: json['sending'] as bool?,
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
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UnsupportedMessageToJson(UnsupportedMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      if (instance.parentId case final value?) 'parentId': value,
      'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
      if (_$JsonConverterToJson<int, DateTime>(
            instance.deletedAt,
            const EpochDateTimeConverter().toJson,
          )
          case final value?)
        'deletedAt': value,
      if (instance.sending case final value?) 'sending': value,
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
      if (instance.metadata case final value?) 'metadata': value,
      'type': instance.$type,
    };
