// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkPreviewData _$LinkPreviewDataFromJson(Map<String, dynamic> json) =>
    _LinkPreviewData(
      link: json['link'] as String,
      description: json['description'] as String?,
      image: json['image'] == null
          ? null
          : ImagePreviewData.fromJson(json['image'] as Map<String, dynamic>),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LinkPreviewDataToJson(_LinkPreviewData instance) =>
    <String, dynamic>{
      'link': instance.link,
      'description': ?instance.description,
      'image': ?instance.image?.toJson(),
      'title': ?instance.title,
    };

_ImagePreviewData _$ImagePreviewDataFromJson(Map<String, dynamic> json) =>
    _ImagePreviewData(
      url: json['url'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$ImagePreviewDataToJson(_ImagePreviewData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
