# [Flyer Chat](https://flyer.chat) 💬 Text Message Widget

[![Pub Version](https://img.shields.io/pub/v/flyer_chat_text_message?logo=flutter&color=orange)](https://pub.dev/packages/flyer_chat_text_message) [![Stars](https://img.shields.io/github/stars/flyerhq/flutter_chat_ui?style=flat&color=orange&logo=github)](https://github.com/flyerhq/flutter_chat_ui/stargazers) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

This package provides an opinionated text message widget for use with the [`flutter_chat_ui`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_ui) package. It includes support for markdown rendering.

## Purpose

This widget is designed specifically to render text messages within a `flutter_chat_ui` implementation. It relies on models and themes provided by [`flutter_chat_core`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_core) and is not intended for standalone use outside the [Flyer Chat](https://flyer.chat) ecosystem.

## Installation

Add this package to your `pubspec.yaml` alongside `flutter_chat_ui`:

```yaml
dependencies:
  flutter_chat_ui: ^2.0.0
  flyer_chat_text_message: ^2.0.0
```

Then run `flutter pub get`.

## Usage

```dart
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';

Chat(
    builders: Builders(
        textMessageBuilder: (context, message, index, {
          required bool isSentByMe,
          MessageGroupStatus? groupStatus,
        }) =>
            FlyerChatTextMessage(message: message, index: index),
    ),
);
```

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/flyerhq/flutter_chat_ui/blob/main/packages/flyer_chat_text_message/LICENSE) file for details.
