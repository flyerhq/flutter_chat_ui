// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextMessageImpl _$$TextMessageImplFromJson(Map<String, dynamic> json) =>
    _$TextMessageImpl(
      id: json['id'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: const EpochDateTimeConverter()
          .fromJson((json['createdAt'] as num).toInt()),
      metadata: json['metadata'] as Map<String, dynamic>?,
      text: json['text'] as String,
      linkPreview: json['linkPreview'] == null
          ? null
          : LinkPreview.fromJson(json['linkPreview'] as Map<String, dynamic>),
      isOnlyEmoji: json['isOnlyEmoji'] as bool?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextMessageImplToJson(_$TextMessageImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'author': instance.author.toJson(),
    'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  val['text'] = instance.text;
  writeNotNull('linkPreview', instance.linkPreview?.toJson());
  writeNotNull('isOnlyEmoji', instance.isOnlyEmoji);
  val['type'] = instance.$type;
  return val;
}

_$ImageMessageImpl _$$ImageMessageImplFromJson(Map<String, dynamic> json) =>
    _$ImageMessageImpl(
      id: json['id'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: const EpochDateTimeConverter()
          .fromJson((json['createdAt'] as num).toInt()),
      metadata: json['metadata'] as Map<String, dynamic>?,
      source: json['source'] as String,
      thumbhash: json['thumbhash'] as String?,
      blurhash: json['blurhash'] as String?,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      overlay: json['overlay'] as bool?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageMessageImplToJson(_$ImageMessageImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'author': instance.author.toJson(),
    'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  val['source'] = instance.source;
  writeNotNull('thumbhash', instance.thumbhash);
  writeNotNull('blurhash', instance.blurhash);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('overlay', instance.overlay);
  val['type'] = instance.$type;
  return val;
}

_$CustomMessageImpl _$$CustomMessageImplFromJson(Map<String, dynamic> json) =>
    _$CustomMessageImpl(
      id: json['id'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: const EpochDateTimeConverter()
          .fromJson((json['createdAt'] as num).toInt()),
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CustomMessageImplToJson(_$CustomMessageImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'author': instance.author.toJson(),
    'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  val['type'] = instance.$type;
  return val;
}

_$UnsupportedMessageImpl _$$UnsupportedMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$UnsupportedMessageImpl(
      id: json['id'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: const EpochDateTimeConverter()
          .fromJson((json['createdAt'] as num).toInt()),
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UnsupportedMessageImplToJson(
    _$UnsupportedMessageImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'author': instance.author.toJson(),
    'createdAt': const EpochDateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  val['type'] = instance.$type;
  return val;
}
