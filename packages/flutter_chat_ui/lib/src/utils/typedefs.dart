import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

/// Callback signature for when a message is tapped.
/// Provides the tapped [message], its [index], and [TapUpDetails].
typedef OnMessageTapCallback =
    void Function(Message message, {int index, TapUpDetails details});

/// Callback signature for when a message is long-pressed.
/// Provides the long-pressed [message], its [index], and [LongPressStartDetails].
typedef OnMessageLongPressCallback =
    void Function(Message message, {int index, LongPressStartDetails details});

/// Callback signature for when the user attempts to send a message.
/// Provides the [text] entered by the user.
typedef OnMessageSendCallback = void Function(String text);

/// Callback signature for when the attachment button in the composer is tapped.
typedef OnAttachmentTapCallback = VoidCallback;

/// Callback signature for requesting pagination (loading more messages).
/// Should return a [Future] that completes when the loading is finished.
typedef PaginationCallback = Future<void> Function();

/// Signature for a function that resolves the animation duration for a specific message.
/// Used for customizing insert/remove animations in the chat list.
typedef MessageAnimationDurationResolver = Duration? Function(Message message);
