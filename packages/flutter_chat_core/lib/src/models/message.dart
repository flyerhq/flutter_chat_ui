import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';
import 'duration_converter.dart';
import 'epoch_date_time_converter.dart';
import 'link_preview_data.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// Base class for all message types.
///
/// Uses a sealed class hierarchy with Freezed for immutability and union types.
/// The `type` field serves as the discriminator for JSON serialization/deserialization.
@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
sealed class Message with _$Message {
  /// Creates a text message.
  const factory Message.text({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Timestamp when the message was last edited.
    @EpochDateTimeConverter() DateTime? editedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// The text content of the message.
    required String text,

    /// Optional preview data for a link found in the [text].
    LinkPreviewData? linkPreviewData,
  }) = TextMessage;

  /// Creates a streaming text message placeholder.
  /// Used while the text content is being streamed.
  const factory Message.textStream({
    /// Unique identifier for the message.
    required String id,

    /// ID of the user (typically the AI) sending the message.
    required String authorId,

    /// ID of the message this one is replying to.
    String? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message sending failed (e.g., network error during stream).
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent (e.g., stream completed).
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was fully delivered (stream completed).
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<String>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// Identifier for the stream this message belongs to.
    required String streamId,
  }) = TextStreamMessage;

  /// Creates an image message.
  const factory Message.image({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// Source URL or path of the image.
    required String source,

    /// Optional text caption accompanying the image.
    String? text,

    /// ThumbHash string for a low-resolution placeholder.
    String? thumbhash,

    /// BlurHash string for a low-resolution placeholder.
    String? blurhash,

    /// Width of the image in pixels.
    double? width,

    /// Height of the image in pixels.
    double? height,

    /// Size of the image in bytes.
    int? size,

    /// Indicates if an overlay should be shown (e.g., for NSFW content).
    bool? hasOverlay,
  }) = ImageMessage;

  /// Creates a file message.
  const factory Message.file({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// Source URL or path of the file.
    required String source,

    /// Name of the file.
    required String name,

    /// Size of the file in bytes.
    int? size,

    /// MIME type of the file.
    String? mimeType,
  }) = FileMessage;

  /// Creates a video message.
  const factory Message.video({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// Source URL or path of the video.
    required String source,

    /// Optional text caption accompanying the video.
    String? text,

    /// Name of the video.
    String? name,

    /// Size of the video in bytes.
    int? size,

    /// Width of the video in pixels.
    double? width,

    /// Height of the video in pixels.
    double? height,
  }) = VideoMessage;

  /// Creates an audio message.
  const factory Message.audio({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// Source URL or path of the audio.
    required String source,

    /// Duration of the audio.
    @DurationConverter() required Duration duration,

    /// Optional text caption accompanying the audio.
    String? text,

    /// Size of the audio in bytes.
    int? size,

    /// Waveform data for the audio.
    List<double>? waveform,
  }) = AudioMessage;

  /// Creates a system message (e.g., "User joined the chat").
  const factory Message.system({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user associated with the system event (often a system ID).
    required UserID authorId,

    /// ID of the message this one is replying to (usually null for system messages).
    MessageID? replyToMessageId,

    /// Timestamp when the system event occurred.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send (usually null for system messages).
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent (usually null for system messages).
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered (usually null for system messages).
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen (usually null for system messages).
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,

    /// The text content of the system message.
    required String text,
  }) = SystemMessage;

  /// Creates a custom message with application-specific data.
  const factory Message.custom({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Application-specific custom metadata.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,
  }) = CustomMessage;

  /// Represents a message type that is not recognized or supported by the current version.
  /// Used as a fallback during JSON deserialization.
  const factory Message.unsupported({
    /// Unique identifier for the message.
    required MessageID id,

    /// ID of the user who sent the message.
    required UserID authorId,

    /// ID of the message this one is replying to.
    MessageID? replyToMessageId,

    /// Timestamp when the message was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Timestamp when the message was marked as deleted.
    @EpochDateTimeConverter() DateTime? deletedAt,

    /// Timestamp when the message failed to send.
    @EpochDateTimeConverter() DateTime? failedAt,

    /// Timestamp when the message was successfully sent.
    @EpochDateTimeConverter() DateTime? sentAt,

    /// Timestamp when the message was delivered to the recipient.
    @EpochDateTimeConverter() DateTime? deliveredAt,

    /// Timestamp when the message was seen by the recipient.
    @EpochDateTimeConverter() DateTime? seenAt,

    /// Timestamp when the message was last updated.
    @EpochDateTimeConverter() DateTime? updatedAt,

    /// Map of reaction keys to lists of user IDs who reacted.
    Map<String, List<UserID>>? reactions,

    /// Indicates if the message is pinned.
    bool? pinned,

    /// Additional custom metadata associated with the message.
    Map<String, dynamic>? metadata,

    /// Status of the message. Takes precedence over the timestamp based status.
    /// If not provided, the status is determined by createdAt, sentAt, seenAt etc.
    MessageStatus? status,
  }) = UnsupportedMessage;

  const Message._();

  /// Calculates the current status of the message based on its timestamps or [status] field.
  /// Returns `null` if the message has no specific status yet (only `createdAt`).
  MessageStatus? get resolvedStatus {
    if (status != null) return status;
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

  /// Returns the primary time associated with the message, used for display.
  ///
  /// This is typically the time the message was successfully sent ([sentAt]).
  /// If [sentAt] is null (e.g., message is sending or failed), it falls back to [createdAt].
  DateTime? get resolvedTime {
    return sentAt ?? createdAt;
  }

  /// Creates a [Message] instance from a JSON map.
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
