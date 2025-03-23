import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart' show MessageStatus;
import 'epoch_date_time_converter.dart';
import 'link_preview.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
sealed class Message with _$Message {
  const factory Message.text({
    required String id,
    required String authorId,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
    required String text,
    LinkPreview? linkPreview,
    bool? isOnlyEmoji,
  }) = TextMessage;

  const factory Message.image({
    required String id,
    required String authorId,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
    required String source,
    String? thumbhash,
    String? blurhash,
    double? width,
    double? height,
    bool? overlay,
  }) = ImageMessage;

  const factory Message.system({
    required String id,
    required String authorId,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
    required String text,
  }) = SystemMessage;

  const factory Message.custom({
    required String id,
    required String authorId,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
  }) = CustomMessage;

  const factory Message.unsupported({
    required String id,
    required String authorId,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
  }) = UnsupportedMessage;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
