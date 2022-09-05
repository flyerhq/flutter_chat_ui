---
id: basic-usage
title: Basic Usage
---

You start with a `Chat` widget that will render a chat. It has 3 required properties:

* `messages` - an array of messages to be rendered. Accepts abstract message, see [types](types). If you have your message types you will need to map those to any of the defined ones. Let us know if we need to add more message types or add more fields to the existing ones.
* `onSendPressed` - a function that will have a partial text message as a parameter. See [types](types) for more info on how types are structured. From the partial text message you need to create a text message which will at least have `author`, `id` and `text`, this is done by you because we wanted to give you more control over those values.
* `user` - a [User](types#user) class, that has only one required field - an `id`, used to determine the message author.

Below you will find a drop-in example of the chat with only text messages.

:::note

Try to write any URL, for example, `flyer.chat`, it should be unwrapped in a rich preview.

:::

```dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
```

To check all supported parameters see [API reference](https://pub.dev/documentation/flutter_chat_ui/latest/flutter_chat_ui/Chat-class.html).
