// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinkPreviewImpl _$$LinkPreviewImplFromJson(Map<String, dynamic> json) =>
    _$LinkPreviewImpl(
      link: json['link'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$LinkPreviewImplToJson(_$LinkPreviewImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      if (instance.description case final value?) 'description': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.title case final value?) 'title': value,
    };
