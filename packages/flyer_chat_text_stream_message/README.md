# [Flyer Chat](https://flyer.chat) 💬 Text Stream Message Widget

[![Pub Version](https://img.shields.io/pub/v/flyer_chat_text_stream_message?logo=flutter&color=orange)](https://pub.dev/packages/flyer_chat_text_stream_message) [![Stars](https://img.shields.io/github/stars/flyerhq/flutter_chat_ui?style=flat&color=orange&logo=github)](https://github.com/flyerhq/flutter_chat_ui/stargazers) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

This package provides an opinionated text stream message widget for use with the [`flutter_chat_ui`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_ui) package. It's designed to display text content that arrives in chunks over time, often seen in interactions with AI assistants or other streaming data sources.

## Purpose

This widget is designed specifically to render text stream messages within a `flutter_chat_ui` implementation. It relies on models and themes provided by [`flutter_chat_core`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_core) and is not intended for standalone use outside the [Flyer Chat](https://flyer.chat) ecosystem.

## Installation

Add this package to your `pubspec.yaml` alongside `flutter_chat_ui`:

```yaml
dependencies:
  flutter_chat_ui: ^2.0.0
  flyer_chat_text_stream_message: ^2.0.0
```

Then run `flutter pub get`.

## Usage

```dart
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';
import 'your_stream_state_manager.dart'; // Example import

Chat(
    builders: Builders(
        textStreamMessageBuilder: (context, message, index, {
          required bool isSentByMe,
          MessageGroupStatus? groupStatus,
        }) {
            final streamState = YourStreamStateManager.getState(message.streamId);

            return FlyerChatTextStreamMessage(
                message: message,
                index: index,
                streamState: streamState,
            );
        }
    ),
);
```

> **Note:** This widget only handles the UI display. You are responsible for:
>
> 1.  Creating and managing the actual text stream (fetching data, handling chunks).
> 2.  Implementing a state management solution (like `YourStreamStateManager` in the example above) to track the state (`Loading`, `Streaming`, `Completed`, `Error`) for each stream ID.
> 3.  Passing the correct `StreamState` to the `FlyerChatTextStreamMessage` widget.
> 4.  Updating your `ChatController` to replace the `TextStreamMessage` with a final `TextMessage` once the stream completes or errors.
>
> For a complete example of how to manage stream state and integrate this widget, see the `gemini.dart` and `gemini_stream_manager.dart` files within the example application.

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/flyerhq/flutter_chat_ui/blob/main/packages/flyer_chat_text_stream_message/LICENSE) file for details.
