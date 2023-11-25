// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voco_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: json['_id'] as String,
      authorId: json['authorId'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : ChatMessageModel.fromJson(
              json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String,
      message: json['message'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      deletedAt: json['deletedAt'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      previewData: json['previewData'] == null
          ? null
          : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'authorId': instance.authorId,
      'repliedMessage': instance.repliedMessage,
      'roomId': instance.roomId,
      'message': instance.message,
      'attachments': instance.attachments,
      'status': instance.status,
      'deletedAt': instance.deletedAt,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'previewData': instance.previewData,
    };
