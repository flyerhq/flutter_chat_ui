// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkPreviewData _$LinkPreviewDataFromJson(Map<String, dynamic> json) =>
    _LinkPreviewData(
      link: json['link'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      imageWidth: (json['imageWidth'] as num?)?.toInt(),
      imageHeight: (json['imageHeight'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LinkPreviewDataToJson(_LinkPreviewData instance) =>
    <String, dynamic>{
      'link': instance.link,
      if (instance.description case final value?) 'description': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.imageWidth case final value?) 'imageWidth': value,
      if (instance.imageHeight case final value?) 'imageHeight': value,
      if (instance.title case final value?) 'title': value,
    };
