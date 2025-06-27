import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

/// Callback signature for when a message is tapped.
/// [context] is the BuildContext from the widget tree where the tap occurs.
/// Provides the tapped [message], its [index], and [TapUpDetails].
typedef OnMessageTapCallback =
    void Function(
      BuildContext context,
      Message message, {
      int index,
      TapUpDetails details,
    });

/// Callback signature for when a message is double tapped.
/// [context] is the BuildContext from the widget tree where the tap occurs.
/// Provides the tapped [message], its [index]
typedef OnMessageDoubleTapCallback =
    void Function(BuildContext context, Message message, {int index});

/// Callback signature for when a message is long-pressed.
/// [context] is the BuildContext from the widget tree where the long press occurs.
/// Provides the long-pressed [message], its [index], and [LongPressStartDetails].
typedef OnMessageLongPressCallback =
    void Function(
      BuildContext context,
      Message message, {
      int index,
      LongPressStartDetails details,
    });

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

/// Enum to control the visibility of the send button.
enum SendButtonVisibilityMode {
  /// The send button is always visible and enabled.
  always,

  /// The send button is only visible when the input field is not empty.
  hidden,

  /// The send button is disabled when the input field is empty. This is the default.
  disabled,
}
