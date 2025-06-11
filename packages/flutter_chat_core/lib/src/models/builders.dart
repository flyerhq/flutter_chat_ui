import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/typedefs.dart';
import 'message.dart';
import 'message_group_status.dart';

part 'builders.freezed.dart';

/// Signature for building a text message widget.
typedef TextMessageBuilder =
    Widget Function(
      BuildContext,
      TextMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building a streaming text message widget.
typedef TextStreamMessageBuilder =
    Widget Function(
      BuildContext,
      TextStreamMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building an image message widget.
typedef ImageMessageBuilder =
    Widget Function(
      BuildContext,
      ImageMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building a file message widget.
typedef FileMessageBuilder =
    Widget Function(
      BuildContext,
      FileMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building a video message widget.
typedef VideoMessageBuilder =
    Widget Function(
      BuildContext,
      VideoMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building an audio message widget.
typedef AudioMessageBuilder =
    Widget Function(
      BuildContext,
      AudioMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building a system message widget.
typedef SystemMessageBuilder =
    Widget Function(
      BuildContext,
      SystemMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building a custom message widget.
typedef CustomMessageBuilder =
    Widget Function(
      BuildContext,
      CustomMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building an unsupported message widget.
typedef UnsupportedMessageBuilder =
    Widget Function(
      BuildContext,
      UnsupportedMessage,
      int index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building the message composer widget.
typedef ComposerBuilder = Widget Function(BuildContext);

/// Signature for building the wrapper around each chat message item.
typedef ChatMessageBuilder =
    Widget Function(
      BuildContext,
      Message message,
      int index,
      Animation<double> animation,
      Widget child, {
      bool? isRemoved,
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    });

/// Signature for building the main chat list widget (e.g., `ChatAnimatedList`).
typedef ChatAnimatedListBuilder =
    Widget Function(BuildContext, ChatItem itemBuilder);

/// Signature for building the "scroll to bottom" button.
typedef ScrollToBottomBuilder =
    Widget Function(
      BuildContext,
      Animation<double> animation,
      VoidCallback onPressed,
    );

/// Signature for building the loading indicator shown when fetching more messages.
typedef LoadMoreBuilder = Widget Function(BuildContext);

/// Signature for building the empty chat list widget.
typedef EmptyChatListBuilder = Widget Function(BuildContext);

/// Signature for building the link preview widget.
typedef LinkPreviewBuilder =
    Widget? Function(BuildContext, TextMessage, bool isSendByMe);

/// A collection of builder functions used to customize the UI components
/// of the chat interface.
@Freezed(fromJson: false, toJson: false)
abstract class Builders with _$Builders {
  /// Creates a [Builders] instance.
  ///
  /// Provide specific builder functions to override the default widgets
  /// for different message types or UI elements.
  const factory Builders({
    /// Custom builder for text messages.
    TextMessageBuilder? textMessageBuilder,

    /// Custom builder for streaming text messages.
    TextStreamMessageBuilder? textStreamMessageBuilder,

    /// Custom builder for image messages.
    ImageMessageBuilder? imageMessageBuilder,

    /// Custom builder for file messages.
    FileMessageBuilder? fileMessageBuilder,

    /// Custom builder for video messages.
    VideoMessageBuilder? videoMessageBuilder,

    /// Custom builder for audio messages.
    AudioMessageBuilder? audioMessageBuilder,

    /// Custom builder for system messages.
    SystemMessageBuilder? systemMessageBuilder,

    /// Custom builder for custom message types.
    CustomMessageBuilder? customMessageBuilder,

    /// Custom builder for unsupported message types.
    UnsupportedMessageBuilder? unsupportedMessageBuilder,

    /// Custom builder for the message composer.
    ComposerBuilder? composerBuilder,

    /// Custom builder for the wrapper around each chat message.
    ChatMessageBuilder? chatMessageBuilder,

    /// Custom builder for the main chat list.
    ChatAnimatedListBuilder? chatAnimatedListBuilder,

    /// Custom builder for the "scroll to bottom" button.
    ScrollToBottomBuilder? scrollToBottomBuilder,

    /// Custom builder for the load more indicator.
    LoadMoreBuilder? loadMoreBuilder,

    /// Custom builder for the empty chat list.
    EmptyChatListBuilder? emptyChatListBuilder,

    /// Custom builder for the link preview widget.
    LinkPreviewBuilder? linkPreviewBuilder,
  }) = _Builders;

  const Builders._();
}
