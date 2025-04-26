# [Flyer Chat](https://flyer.chat) 💬 Core Package

[![Pub Version](https://img.shields.io/pub/v/flutter_chat_core?logo=flutter&color=orange)](https://pub.dev/packages/flutter_chat_core) [![Stars](https://img.shields.io/github/stars/flyerhq/flutter_chat_ui?style=flat&color=orange&logo=github)](https://github.com/flyerhq/flutter_chat_ui/stargazers) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

This package contains the core foundation for the [Flyer Chat](https://flyer.chat) ecosystem, including data models, controllers, theming, and utilities.

## Purpose

This package provides the essential building blocks (like message models, `ChatTheme`, `ChatController` interfaces) required by [`flutter_chat_ui`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_ui) and other `flyer_chat_*` message widget packages.

It is **not** intended for standalone use outside the Flyer Chat ecosystem. Its components are designed to work together with the main UI package.

## Installation

To use Flutter chat UI, you need to add both `flutter_chat_ui` and the core package `flutter_chat_core` (which contains necessary data models and types) to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_chat_core: ^2.0.0
  flutter_chat_ui: ^2.0.0
```

Then run `flutter pub get`.

## Usage

The classes and utilities within this package are used implicitly when you configure and use the `Chat` widget from `flutter_chat_ui`. You will interact with its models (like text message, image message, etc.) when managing chat data and potentially use its `ChatTheme` and `Builders` for customization.

For detailed usage, customization options, different message types, controllers, and more complex scenarios, please refer to the **full documentation**:

➡️ **[flyer.chat/introduction](https://flyer.chat/introduction)** ⬅️

Explore the comprehensive [example application](https://github.com/flyerhq/flutter_chat_ui/tree/main/examples/flyer_chat) to see various features and customizations in action.

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/flyerhq/flutter_chat_ui/blob/main/packages/flutter_chat_core/LICENSE) file for details.
