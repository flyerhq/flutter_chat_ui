import 'package:freezed_annotation/freezed_annotation.dart';

import 'epoch_date_time_converter.dart';
import 'link_preview.dart';
import 'user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
sealed class Message with _$Message {
  const factory Message.text({
    required String id,
    required User author,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    required String text,
    LinkPreview? linkPreview,
  }) = TextMessage;

  const factory Message.image({
    required String id,
    required User author,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
    required String source,
    String? thumbhash,
    String? blurhash,
    double? width,
    double? height,
  }) = ImageMessage;

  const factory Message.unsupported({
    required String id,
    required User author,
    @EpochDateTimeConverter() required DateTime createdAt,
    Map<String, dynamic>? metadata,
  }) = UnsupportedMessage;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
