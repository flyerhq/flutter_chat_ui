# [Flyer Chat](https://flyer.chat) 💬 Image Message Widget

[![Pub Version](https://img.shields.io/pub/v/flyer_chat_image_message?logo=flutter&color=orange)](https://pub.dev/packages/flyer_chat_image_message) [![Stars](https://img.shields.io/github/stars/flyerhq/flutter_chat_ui?style=flat&color=orange&logo=github)](https://github.com/flyerhq/flutter_chat_ui/stargazers) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

This package provides an opinionated image message widget for use with the [`flutter_chat_ui`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_ui) package.

## ✨ Features

- 🖼️ **Cross-Platform Caching:** Caches images on all platforms (including web) using [`cross_cache`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/cross_cache).
- ⏳ **Progress Indicators:** Displays built-in indicators for image upload and download progress.
- 🎨 **Loading Placeholders:** Shows Blurhash or Thumbhash placeholders while the full image loads for a better user experience.
- 📐 **Aspect Ratio Preservation:** Maintains correct image dimensions during loading for smoother layout transitions (relies on width/height in the message).
- ➕ **Optional Overlay:** Supports adding an optional overlay (NSFW content, hidden messsage, etc.)

## Purpose

This widget is designed specifically to render image messages within a `flutter_chat_ui` implementation. It relies on models and themes provided by [`flutter_chat_core`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_core) and is not intended for standalone use outside the [Flyer Chat](https://flyer.chat) ecosystem.

## Installation

Add this package to your `pubspec.yaml` alongside `flutter_chat_ui`:

```yaml
dependencies:
  flutter_chat_ui: ^2.0.0
  flyer_chat_image_message: ^2.0.0
```

Then run `flutter pub get`.

## Usage

```dart
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';

Chat(
    builders: Builders(
        imageMessageBuilder: (context, message, index, {
          required bool isSentByMe,
          MessageGroupStatus? groupStatus,
        }) =>
            FlyerChatImageMessage(message: message, index: index),
    ),
);
```

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/flyerhq/flutter_chat_ui/blob/main/packages/flyer_chat_image_message/LICENSE) file for details.
