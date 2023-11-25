// ignore_for_file: invalid_annotation_target

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@immutable
@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    @JsonKey(name: '_id') required final String id,
    required String authorId,
    final ChatMessageModel? repliedMessage,
    required final String roomId,
    required final String message,
    final List<String>? attachments,
    required final String status,
    final String? deletedAt,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final PreviewData? previewData,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}
