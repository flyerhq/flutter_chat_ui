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