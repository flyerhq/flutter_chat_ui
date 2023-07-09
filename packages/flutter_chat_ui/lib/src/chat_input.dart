import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

class ChatInput extends StatelessWidget {
  final Color backgroundColor;
  final InputTheme inputTheme;
  final OnMessageSendCallback onMessageSend;
  final OnAttachmentTapCallback onAttachmentTap;

  const ChatInput({
    super.key,
    required this.backgroundColor,
    required this.inputTheme,
    required this.onMessageSend,
    required this.onAttachmentTap,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    void handleSubmitted(String text) {
      if (text.isNotEmpty) {
        onMessageSend?.call(text);
        textController.clear();
      }
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: backgroundColor.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attachment),
                    color: inputTheme.hintStyle?.color,
                    onPressed: onAttachmentTap,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: inputTheme.hintStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: inputTheme.backgroundColor,
                        hoverColor: Colors.transparent,
                        // hoverColor:
                      ),
                      style: inputTheme.textStyle,
                      onSubmitted: handleSubmitted,
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: inputTheme.hintStyle?.color,
                    onPressed: () => handleSubmitted(textController.text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final GlobalKey _inputKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateInputHeight());
  }

  void _updateInputHeight() {
    final renderBox =
        _inputKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      context
          .read<ChatInputHeightNotifier>()
          .updateHeight(renderBox.size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);
    final inputTheme = context.select((ChatTheme theme) => theme.inputTheme);

    final onMessageSend = context.read<OnMessageSendCallback>();
    final onAttachmentTap = context.read<OnAttachmentTapCallback>();

    return ChatInput(
      key: _inputKey,
      backgroundColor: backgroundColor,
      inputTheme: inputTheme,
      onMessageSend: onMessageSend,
      onAttachmentTap: onAttachmentTap,
    );
  }
}
