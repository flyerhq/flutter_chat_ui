# [Flyer Chat](https://flyer.chat) 💬 Custom Message (Placeholder)

[![Pub Version](https://img.shields.io/pub/v/flyer_chat_custom_message?logo=flutter&color=orange)](https://pub.dev/packages/flyer_chat_custom_message) [![Stars](https://img.shields.io/github/stars/flyerhq/flutter_chat_ui?style=flat&color=orange&logo=github)](https://github.com/flyerhq/flutter_chat_ui/stargazers) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

**Note:** This package has no implementation and serves as a placeholder to showcase the pattern for handling custom message types within [Flyer Chat](https://flyer.chat).

## Implementing Custom Messages

To render your own custom messages:

1.  When creating a message instance that represents your custom data, use the custom message type provided by `flutter_chat_core`. This type includes standard fields like `id`, `authorId`, `createdAt`, etc.
2.  Store your custom data within the `metadata` field (a `Map<String, dynamic>`) of the custom message. For simple cases, this might be all you need. If you intend to support several distinct types of custom messages, you could use this `metadata` to help your `customMessageBuilder` decide which widget to display, for example, by including a specific key like `'customType': 'poll'`.
3.  Use the `customMessageBuilder` provided by the main [`flutter_chat_ui`](https://github.com/flyerhq/flutter_chat_ui/tree/main/packages/flutter_chat_ui) package's `Builders` to render your widget based on the message instance passed to the builder.

```dart
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

Chat(
  builders: Builders(
    customMessageBuilder: (context, message, index, {
      required bool isSentByMe,
      MessageGroupStatus? groupStatus,
    }) =>
      const SizedBox.shrink(),
  ),
);
```
