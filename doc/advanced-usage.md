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
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onAttachmentPressed: _handleImageSelection,
      ),
    );

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }
}
```

Similar to the text message, you will need to create an image message using data from the image picker. In this example, we use local path just for demo purposes, but for the backend service, you will upload the image first and then send the received URL using the `uri` property.

To keep the UI clean, the image message renders in two different ways, if the aspect ratio is too low or too high it renders like a file message, so you don't see a narrow line on the UI. The second way is a classic image in the chat. Go give it a try.

:::tip

You can use this URL https://bit.ly/2P0cn2g to test the file message presentation, remove height and width from the `message` so the library will calculate it automatically and replace `uri`'s data with this URL.

:::

On tap, images will be previewed inside an interactive image gallery. To disable the image gallery pass `disableImageGallery` property to the `Chat` widget.

## Files

In this example, we will use [file_picker](https://pub.dev/packages/file_picker), follow the instructions there to install it. After it is done we can use the file picker to select a file and send it as a message (full example with images and files can be found [here](#putting-it-all-together)):

```dart
// ...
import 'package:file_picker/file_picker.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onAttachmentPressed: _handleFileSelection,
      ),
    );

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }
}
```

Similar to the text message, you will need to create a file message using data from the document picker. In this example, `uri` will point to the local filesystem just for demo purposes, but for the backend service, you will upload the file first and then send the received URL using the `uri` property.

### Opening a file

Right now, nothing will happen when a user taps on a file message, we will need to add another dependency. In this case, let's add [open_file](https://pub.dev/packages/open_file). As usual, follow the instructions there to install it. Now we can open a file:

```dart
// ...
import 'package:open_file/open_file.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onMessageTap: _handleMessageTap,
      ),
    );

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }
}
```

### Opening a file from a remote URL

In the previous example, only local files on the device can be opened. If we want to support opening a file from the remote URL, we need to download it first. To do that, we'd need [http](https://pub.dev/packages/http) and [path_provider](https://pub.dev/packages/path_provider). Please keep in mind, that this is just an example, and there are other, maybe better ways to download files, like [dio](https://pub.dev/packages/dio). Let's modify our `_handleMessageTap` function:

```dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class _MyHomePageState extends State<MyHomePage> {
  // ...
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onMessageTap: _handleMessageTap,
      ),
    );

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          // Update tapped file message to show loading spinner
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          // In case of error or success, reset loading spinner
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFile.open(localPath);
    }
  }
}
```

## Link preview

Link preview works automatically, we created a separate package for that, you can found it [here](https://pub.dev/packages/flutter_link_previewer). It can be disabled by setting `usePreviewData` to false. Usually, however, you'll want to save the preview data so it stays the same, you can do that using `onPreviewDataFetched` callback:

```dart
class _MyHomePageState extends State<MyHomePage> {
  // ...
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onPreviewDataFetched: _handlePreviewDataFetched,
      ),
    );

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }
}
```

## Putting it all together

Now to choose between images and files from a single button we will use `showModalBottomSheet`. If you skipped previous sections and want to use this example, remember to install - [image_picker](https://pub.dev/packages/image_picker), [file_picker](https://pub.dev/packages/file_picker) and [open_file](https://pub.dev/packages/open_file). This is a drop-in example, everything should work if you had installed all the dependencies.

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
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
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
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

## Custom chat bubbles

Let's use the [bubble](https://pub.dev/packages/bubble) package as an example (version `1.2.1` at the point of writing, example might not work as it is if the new version is released). Just pass the `_bubbleBuilder` function to the `Chat` widget. `child` parameter of the `_bubbleBuilder` function is a default message content (which you can further customize using `customMessageBuilder`, `fileMessageBuilder`, `imageMessageBuilder`, `textMessageBuilder` etc.). `message` parameter gives you the actual message to work with, where you can see whether the current user is author, message type, or anything you'd like to customize the bubble. `nextMessageInGroup` parameter gives you a hint about message groups and if you want to add a nip only for the last message in the group, you can do that (messages are grouped when written in quick succession by the same author).

```dart
import 'package:bubble/bubble.dart';

@override
Widget build(BuildContext context) => Scaffold(
    body: Chat(
      // ...
      bubbleBuilder: _bubbleBuilder,
    ),
  );

Widget _bubbleBuilder(
  Widget child, {
  required message,
  required nextMessageInGroup,
}) =>
    Bubble(
      child: child,
      color: _user.id != message.author.id ||
              message.type == types.MessageType.image
          ? const Color(0xfff5f5f7)
          : const Color(0xff6f61e8),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : _user.id != message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
    );
```

This is how it would look like

<img src="https://user-images.githubusercontent.com/14123304/133879196-ef3e3655-58c7-48b7-a0d6-084eb8968df9.png" width="288px" alt="Custom chat bubbles" />

## Custom messages

Use the `customMessageBuilder` function to build whatever message you want. To store the data use a `metadata` map of the `CustomMessage`. You can have multiple different custom messages, you will need to identify them based on some property inside the `metadata` and build accordingly.

## Pagination

Use `onEndReached`, `onEndReachedThreshold` and `isLastPage` parameters to control pagination. To learn more see [API reference](https://pub.dev/documentation/flutter_chat_ui/latest/flutter_chat_ui/ChatList-class.html). Here is a simple example based on a [basic usage](basic-usage):

```dart
// ...
import 'package:http/http.dart' as http;

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  // ...
  @override
  void initState() {
    super.initState();
    _handleEndReached();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Chat(
        // ...
        onEndReached: _handleEndReached,
      ),
    );

  Future<void> _handleEndReached() async {
    final uri = Uri.parse(
      'https://api.instantwebtools.net/v1/passenger?page=$_page&size=20',
    );
    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    final messages = data
        .map(
          (e) => types.TextMessage(
            author: _user,
            id: e['_id'] as String,
            text: e['name'] as String,
          ),
        )
        .toList();
    setState(() {
      _messages = [..._messages, ...messages];
      _page = _page + 1;
    });
  }
}
```

## User avatars & names

To show user avatars & names use `showUserAvatars` and `showUserNames` parameters. Can be used separately. By default, the chat will select one of 10 provided colors as an avatar background and name text color. Color is calculated based on the user's `id` hash code, so it is unique in different rooms. To modify provided colors use `userAvatarNameColors` parameter in [theme](themes). If you want to have one color for everyone, just pass this color as a single item in the `userAvatarNameColors` list.

## Scroll to the first unread

### Without pagination

Just pass this parameter to the `Chat` widget. You need to pass last read message ID (banner will be shown automatically, after the message with the same ID).

```dart
scrollToUnreadOptions: const ScrollToUnreadOptions(
  lastReadMessageId: 'lastReadMessageId',
  scrollOnOpen: true,
)
```

### With pagination

You will need to use `GlobalKey` to do this. First, create a `GlobalKey` for the `ChatState`

```dart
final GlobalKey<ChatState> _chatKey = GlobalKey();
```

and pass it to the `Chat` widget.

```dart
Chat(
  key: _chatKey,
  // ...
)
```

Now, you still need to pass `scrollToUnreadOptions` with the `lastReadMessageId`, but keep the `scrollOnOpen` parameter as a default `false`. In your pagination code (in the example I have in [pagination section](#pagination) that would be end of the `_handleEndReached` function) you need to keep fetching pages until you find a page that contains `lastReadMessageId`, then using the `_chatKey` you will be able to scroll to the first unread message.

```dart
if (_messages.where((e) => e.id == 'lastReadMessageId').isEmpty) {
  // Recursively call to fetch more pages
  await _handleEndReached();
} else {
  // Give some delay for the library to calculate correct indices
  Future.delayed(const Duration(milliseconds: 20), () {
    _chatKey.currentState?.scrollToUnreadHeader();
  });
}
```
