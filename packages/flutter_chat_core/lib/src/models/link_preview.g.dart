// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkPreview _$LinkPreviewFromJson(Map<String, dynamic> json) => _LinkPreview(
  link: json['link'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  title: json['title'] as String?,
);

Map<String, dynamic> _$LinkPreviewToJson(_LinkPreview instance) =>
    <String, dynamic>{
      'link': instance.link,
      if (instance.description case final value?) 'description': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.title case final value?) 'title': value,
    };
