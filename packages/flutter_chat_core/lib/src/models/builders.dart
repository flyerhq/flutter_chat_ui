import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/typedefs.dart';
import 'message.dart';

part 'builders.freezed.dart';

typedef TextMessageBuilder = Widget Function(BuildContext, TextMessage);
typedef ImageMessageBuilder = Widget Function(BuildContext, ImageMessage);
typedef UnsupportedMessageBuilder = Widget Function(
  BuildContext,
  UnsupportedMessage,
);
typedef InputBuilder = Widget Function(BuildContext);
typedef ChatMessageBuilder = Widget Function(
  BuildContext,
  Message message,
  Animation<double> animation,
  Widget child,
);
typedef ChatAnimatedListBuilder = Widget Function(
  BuildContext,
  ScrollController scrollController,
  ChatItem itemBuilder,
);
typedef ScrollToBottomBuilder = Widget Function(
  BuildContext,
  Animation<double> animation,
  VoidCallback onPressed,
);

@Freezed(fromJson: false, toJson: false)
class Builders with _$Builders {
  const factory Builders({
    TextMessageBuilder? textMessageBuilder,
    ImageMessageBuilder? imageMessageBuilder,
    UnsupportedMessageBuilder? unsupportedMessageBuilder,
    InputBuilder? inputBuilder,
    ChatMessageBuilder? chatMessageBuilder,
    ChatAnimatedListBuilder? chatAnimatedListBuilder,
    ScrollToBottomBuilder? scrollToBottomBuilder,
  }) = _Builders;

  const Builders._();
}
