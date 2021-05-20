---
id: advanced-usage
title: Advanced Usage
---

We didn't add any dependencies for working with files and images, since there are a couple of them and you might want to use different ones.

## Images

In this example, we will use [image_picker](https://pub.dev/packages/image_picker), follow the instructions there to install it. After it is done we can use the image picker to select an image and send it as a message (full example with images and files can be found [here](#putting-it-all-together)):

```dart
// ...
import 'package:image_picker/image_picker.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  void _handleImageSelection() async {
    final result = await ImagePicker().getImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = result.path.split('/').last;

      final message = types.ImageMessage(
        authorId: _user.id,
        height: image.height.toDouble(),
        id: randomString(),
        imageName: imageName,
        size: bytes.length,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        // ...
        onAttachmentPressed: _handleImageSelection,
      ),
    );
  }
}
```

Similar to the text message, you will need to create an image message using data from the image picker. In this example, we use local path just for demo purposes, but for the backend service, you will upload the image first and then send the received URL using the `uri` parameter.

To keep the UI clean, the image message renders in two different ways, if the aspect ratio is too low or too high it renders like a file message, so you don't see a narrow line on the UI. The second way is a classic image in the chat. Go give it a try.

:::tip

You can use this URL https://bit.ly/2P0cn2g to test the file message presentation, remove height and width from the `message` so the library will calculate it automatically and replace `uri`'s data with this URL.

:::

On tap, images will be previewed inside an interactive image gallery. To disable the image gallery pass `disableImageGallery` parameter to the Chat widget.

## Files

In this example, we will use [file_picker](https://pub.dev/packages/file_picker), follow the instructions there to install it. After it is done we can use the file picker to select a file and send it as a message (full example with images and files can be found [here](#putting-it-all-together)):

```dart
// ...
import 'package:file_picker/file_picker.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        authorId: _user.id,
        fileName: result.files.single.name ?? '',
        id: randomString(),
        size: result.files.single.size ?? 0,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.files.single.path ?? '',
      );

      _addMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        // ...
        onAttachmentPressed: _handleFileSelection,
      ),
    );
  }
}
```

Similar to the text message, you will need to create a file message using data from the document picker. In this example, `uri` will point to the local filesystem just for demo purposes, but for the backend service, you will upload the file first and then send the received URL using the `uri` parameter.

### Opening a file

Right now, nothing will happen when a user taps on a file message, we will need to add another dependency. In this case, let's add [open_file](https://pub.dev/packages/open_file). As usual, follow the instructions there to install it. Now we can open a file:

```dart
// ...
import 'package:open_file/open_file.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        // ...
        onMessageTap: _handleMessageTap,
      ),
    );
  }
}
```

## Link preview

Link preview works automatically, we created a separate package for that, you can found it [here](https://pub.dev/packages/flutter_link_previewer). If you want, it can be disabled by setting `usePreviewData` to false. Usually, however, you'll want to save the preview data so it stays the same, you can do that using `onPreviewDataFetched` callback:

```dart
class _MyHomePageState extends State<MyHomePage> {
  // ...
  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final currentMessage = _messages[index] as types.TextMessage;
    final updatedMessage = currentMessage.copyWith(previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        // ...
        onPreviewDataFetched: _handlePreviewDataFetched,
      ),
    );
  }
}
```

## Putting it all together

Now to choose between images and files from a single button we will use `showModalBottomSheet`. If you skipped previous sections and want to use this example, remember to install - [image_picker](https://pub.dev/packages/image_picker), [file_picker](https://pub.dev/packages/file_picker) and [open_file](https://pub.dev/packages/open_file). This is a drop-in example, everything should work if you had installed all the dependencies.

```dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid
String randomString() {
  var random = Random.secure();
  var values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        authorId: _user.id,
        fileName: result.files.single.name ?? '',
        id: randomString(),
        size: result.files.single.size ?? 0,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.files.single.path ?? '',
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().getImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = result.path.split('/').last;

      final message = types.ImageMessage(
        authorId: _user.id,
        height: image.height.toDouble(),
        id: randomString(),
        imageName: imageName,
        size: bytes.length,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final currentMessage = _messages[index] as types.TextMessage;
    final updatedMessage = currentMessage.copyWith(previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      authorId: _user.id,
      id: randomString(),
      text: message.text,
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onAttachmentPressed: _handleAtachmentPressed,
        onMessageTap: _handleMessageTap,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
```
