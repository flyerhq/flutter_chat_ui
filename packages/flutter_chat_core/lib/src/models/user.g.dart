// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String?,
  imageSource: json['imageSource'] as String?,
  createdAt: _$JsonConverterFromJson<int, DateTime>(
    json['createdAt'],
    const EpochDateTimeConverter().fromJson,
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': ?instance.name,
  'imageSource': ?instance.imageSource,
  'createdAt': ?_$JsonConverterToJson<int, DateTime>(
    instance.createdAt,
    const EpochDateTimeConverter().toJson,
  ),
  'metadata': ?instance.metadata,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
