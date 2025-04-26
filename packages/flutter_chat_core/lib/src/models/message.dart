import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';
import 'epoch_date_time_converter.dart';
import 'link_preview.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
sealed class Message with _$Message {
  const factory Message.text({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
    required String text,
    LinkPreview? linkPreview,
  }) = TextMessage;

  const factory Message.image({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
    required String source,
    String? text,
    String? thumbhash,
    String? blurhash,
    double? width,
    double? height,
    bool? hasOverlay,
  }) = ImageMessage;

  const factory Message.file({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
    required String source,
    required String name,
    int? size,
    String? mimeType,
  }) = FileMessage;

  const factory Message.system({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
    required String text,
  }) = SystemMessage;

  const factory Message.custom({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
  }) = CustomMessage;

  const factory Message.unsupported({
    required MessageID id,
    required UserID authorId,
    MessageID? replyToId,
    @EpochDateTimeConverter() DateTime? createdAt,
    @EpochDateTimeConverter() DateTime? deletedAt,
    @EpochDateTimeConverter() DateTime? failedAt,
    @EpochDateTimeConverter() DateTime? sentAt,
    @EpochDateTimeConverter() DateTime? deliveredAt,
    @EpochDateTimeConverter() DateTime? seenAt,
    @EpochDateTimeConverter() DateTime? updatedAt,
    Map<String, List<UserID>>? reactions,
    Map<String, dynamic>? metadata,
  }) = UnsupportedMessage;

  const Message._();

  MessageStatus? get status {
    // Message status is determined by the most recent state change in the message lifecycle.
    // The order of checks matters - we check from most recent to oldest state.
    // Note: createdAt, updatedAt, and deletedAt are message states rather than statuses.
    if (metadata?['sending'] == true) return MessageStatus.sending;
    if (failedAt != null) return MessageStatus.error;
    if (seenAt != null) return MessageStatus.seen;
    if (deliveredAt != null) return MessageStatus.delivered;
    if (sentAt != null) return MessageStatus.sent;
    return null;
  }

  /// Returns the time displayed for the user when the message is shown in a list.
  /// This time is determined by the `sentAt` date, which represents when the message was sent to the server.
  /// If `sentAt` is not available, it falls back to the `createdAt` date.
  /// Other timestamps like `updatedAt` may be shown in an additional history popup,
  /// but they are not displayed in the list itself (this functionality is not provided by the package and is left to the user to implement).
  DateTime? get time {
    return sentAt ?? createdAt;
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
