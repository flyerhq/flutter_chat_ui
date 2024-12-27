import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

class ChatInput extends StatefulWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? sigmaX;
  final double? sigmaY;
  final EdgeInsetsGeometry? padding;
  final Widget? attachmentIcon;
  final Widget? sendIcon;
  final double? gap;
  final InputBorder? inputBorder;
  final bool? filled;
  final Widget? topWidget;
  final bool? handleSafeArea;

  const ChatInput({
    super.key,
    this.left = 0,
    this.right = 0,
    this.top,
    this.bottom = 0,
    this.sigmaX = 20,
    this.sigmaY = 20,
    this.padding = const EdgeInsets.all(8.0),
    this.attachmentIcon = const Icon(Icons.attachment),
    this.sendIcon = const Icon(Icons.send),
    this.gap = 8,
    this.inputBorder = const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    this.filled = true,
    this.topWidget,
    this.handleSafeArea = true,
  });

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
  void didUpdateWidget(covariant ChatInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateInputHeight());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = widget.handleSafeArea == true
        ? MediaQuery.of(context).padding.bottom
        : 0.0;
    final inputTheme = context.select((ChatTheme theme) => theme.inputTheme);
    final onAttachmentTap = context.read<OnAttachmentTapCallback?>();

    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            // TODO: remove backdrop filter if both are 0
            sigmaX: widget.sigmaX ?? 0,
            sigmaY: widget.sigmaY ?? 0,
          ),
          child: Container(
            key: _inputKey,
            color: inputTheme.backgroundColor,
            child: Column(
              children: [
                if (widget.topWidget != null) widget.topWidget!,
                Padding(
                  padding: widget.handleSafeArea == true
                      ? (widget.padding
                              ?.add(EdgeInsets.only(bottom: bottomSafeArea)) ??
                          EdgeInsets.only(bottom: bottomSafeArea))
                      : (widget.padding ?? EdgeInsets.zero),
                  child: Row(
                    children: [
                      widget.attachmentIcon != null
                          ? IconButton(
                              icon: widget.attachmentIcon!,
                              color: inputTheme.hintStyle?.color,
                              onPressed: onAttachmentTap,
                            )
                          : const SizedBox.shrink(),
                      SizedBox(width: widget.gap),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            hintStyle: inputTheme.hintStyle,
                            border: widget.inputBorder,
                            filled: widget.filled,
                            fillColor: inputTheme.textFieldColor,
                            hoverColor: Colors.transparent,
                          ),
                          style: inputTheme.textStyle,
                          onSubmitted: _handleSubmitted,
                          textInputAction: TextInputAction.send,
                        ),
                      ),
                      SizedBox(width: widget.gap),
                      widget.sendIcon != null
                          ? IconButton(
                              icon: widget.sendIcon!,
                              color: inputTheme.hintStyle?.color,
                              onPressed: () =>
                                  _handleSubmitted(_textController.text),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateInputHeight() {
    if (!mounted) return;

    final renderBox =
        _inputKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      final bottomSafeArea = MediaQuery.of(context).padding.bottom;

      context.read<ChatInputHeightNotifier>().updateHeight(
            // only set real height of the input, ignoring safe area
            widget.handleSafeArea == true ? height - bottomSafeArea : height,
          );
    }
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      context.read<OnMessageSendCallback?>()?.call(text);
      _textController.clear();
    }
  }
}
