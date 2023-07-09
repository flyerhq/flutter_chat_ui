import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final GlobalKey _inputKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateInputHeight());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);
    final inputTheme = context.select((ChatTheme theme) => theme.inputTheme);

    final onAttachmentTap = context.read<OnAttachmentTapCallback>();

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            key: _inputKey,
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
                      controller: _textController,
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
                      ),
                      style: inputTheme.textStyle,
                      onSubmitted: _handleSubmitted,
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: inputTheme.hintStyle?.color,
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      context.read<OnMessageSendCallback>()?.call(text);
      _textController.clear();
    }
  }
}
