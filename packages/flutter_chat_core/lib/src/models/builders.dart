import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'message.dart';

part 'builders.freezed.dart';

typedef TextMessageBuilder = Widget Function(BuildContext, TextMessage);
typedef ImageMessageBuilder = Widget Function(BuildContext, ImageMessage);
typedef UnsupportedMessageBuilder = Widget Function(
  BuildContext,
  UnsupportedMessage,
);

@Freezed(fromJson: false, toJson: false)
class Builders with _$Builders {
  const factory Builders({
    TextMessageBuilder? textMessageBuilder,
    ImageMessageBuilder? imageMessageBuilder,
    UnsupportedMessageBuilder? unsupportedMessageBuilder,
  }) = _Builders;

  const Builders._();
}
