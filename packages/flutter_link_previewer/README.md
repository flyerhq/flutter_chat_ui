# Flutter Link Previewer 🔗

[![Pub Version](https://img.shields.io/pub/v/flutter_link_previewer?logo=flutter&color=orange)](https://pub.dev/packages/flutter_link_previewer) [![melos](https://img.shields.io/badge/maintained%20with-melos-ffffff.svg?color=orange)](https://github.com/invertase/melos)

A highly customizable Flutter widget for rendering a preview of a URL. It automatically fetches metadata (title, description, image) and displays it in a clean, animated card. It is a part of the [Flyer Chat](https://flyer.chat) ecosystem.

![Screenshot](https://github.com/user-attachments/assets/d9b02238-7820-44ad-880d-cf7e9870f57a)

## ✨ Features

- 🪄 **Automatic Preview Generation:** Fetches preview data (title, description, image) from the first URL found in a given text.
- 🎨 **Highly Customizable:** Control colors, padding, border radius, text styles, and more.
- 🖼️ **Smart Image Layout:** Automatically displays images on the side (for square images) or at the bottom (for rectangular images).
- 📐 **Sophisticated Width Calculation:** Aligns with parent content (like chat bubbles) for a visually consistent layout.
- 🚀 **Smooth Animations:** Built-in fade and size transitions, which can be disabled if not needed.
- 👆 **Custom Tap Handling:** Override the default behavior of opening the link in a browser.

## 🚀 Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_link_previewer: ^4.0.0
```

Then run `flutter pub get`.

## 📖 Usage

### Standalone Usage

Here is a basic example of how to use the `LinkPreview` widget within a stateful widget. It's important to store the fetched `LinkPreviewData` in your state to avoid re-fetching on rebuilds. It is also recommended to cache it to avoid re-fetching across app restarts.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' show LinkPreviewData;

class MyChatBubble extends StatefulWidget {
  const MyChatBubble({super.key, required this.message});

  final String message;

  @override
  State<MyChatBubble> createState() => _MyChatBubbleState();
}

class _MyChatBubbleState extends State<MyChatBubble> {
  LinkPreviewData? _linkPreviewData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message),
          LinkPreview(
            // The text that should be parsed to find the first URL
            text: widget.message,
            // Pass the cached preview data to avoid re-fetching
            linkPreviewData: _linkPreviewData,
            // Callback to store the fetched preview data
            onLinkPreviewDataFetched: (data) {
              setState(() {
                _linkPreviewData = data;
              });
            },
            // For a chat bubble, you would pass the message text here
            // to align the preview with the text bubble.
            parentContent: widget.message,
            // Customization example
            borderRadius: 4,
            sideBorderColor: Colors.white,
            sideBorderWidth: 4,
            insidePadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            outsidePadding: const EdgeInsets.symmetric(vertical: 4),
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Integration with Flyer Chat

If you are using [`flutter_chat_ui`](https://pub.dev/packages/flutter_chat_ui), you can easily add link previews by providing the `linkPreviewBuilder` in the `Chat` widget's `builders` parameter.

This builder works seamlessly with text messages provided by Flyer Chat. The `Chat` widget automatically calls this builder for text messages that contain a link. When preview data is fetched, you should update the message using your `ChatController` to cache the data within the message itself.

```dart
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

Chat(
  // ... other Chat properties
  builders: Builders(
    linkPreviewBuilder: (context, message, isSentByMe) {
      return LinkPreview(
        text: message.text,
        linkPreviewData: message.linkPreviewData,
        onLinkPreviewDataFetched: (linkPreviewData) {
          // Use the chat controller to update the message with the fetched data.
          // This will automatically save it in the message's metadata.
          _chatController.updateMessage(
            message,
            message.copyWith(linkPreviewData: linkPreviewData),
          );
        },
        // You can still customize the appearance
        parentContent: message.text,
      );
    },
    // ... other builders
  ),
)
```

## 🤝 Contributing

Contributions are welcome! Please see the main project's [Contributing Guide](https://github.com/flyerhq/flutter_chat_ui/blob/main/CONTRIBUTING.md).

## 📜 License

Licensed under the MIT License. See the [LICENSE](https://github.com/flyerhq/flutter_chat_ui/blob/main/packages/flutter_link_previewer/LICENSE) file for details.
