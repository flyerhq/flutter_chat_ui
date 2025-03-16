import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

class ChatInput extends StatefulWidget {
  static const Color _sentinelColor = Colors.transparent;

  final TextEditingController? textEditingController;
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
  final Color? backgroundColor;
  final Color? attachmentIconColor;
  final Color? sendIconColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? inputFillColor;
  final String? hintText;
  final Brightness? keyboardAppearance;
  final bool? autocorrect;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  const ChatInput({
    super.key,
    this.textEditingController,
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
    this.backgroundColor = _sentinelColor,
    this.attachmentIconColor,
    this.sendIconColor,
    this.hintColor,
    this.textColor,
    this.inputFillColor,
    this.hintText = 'Type a message',
    this.keyboardAppearance,
    this.autocorrect,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
    this.textInputAction = TextInputAction.newline,
    this.focusNode,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 3,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _key = GlobalKey();
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = widget.textEditingController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.onKeyEvent = _handleKeyEvent;
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    // Check for Shift+Enter
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter &&
        HardwareKeyboard.instance.isShiftPressed) {
      _handleSubmitted(_textController.text);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void didUpdateWidget(covariant ChatInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void dispose() {
    // Only try to dispose text controller if it's not provided, let
    // user handle disposing it how they want.
    if (widget.textEditingController == null) {
      _textController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea =
        widget.handleSafeArea == true
            ? MediaQuery.of(context).padding.bottom
            : 0.0;
    final theme = context.watch<ChatTheme>();
    final onAttachmentTap = context.read<OnAttachmentTapCallback?>();

    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: ClipRect(
        child: Container(
          key: _key,
          color:
              widget.backgroundColor == ChatInput._sentinelColor
                  ? theme.colors.surfaceContainerLow
                  : widget.backgroundColor,
          child: Column(
            children: [
              if (widget.topWidget != null) widget.topWidget!,
              Padding(
                padding:
                    widget.handleSafeArea == true
                        ? (widget.padding?.add(
                              EdgeInsets.only(bottom: bottomSafeArea),
                            ) ??
                            EdgeInsets.only(bottom: bottomSafeArea))
                        : (widget.padding ?? EdgeInsets.zero),
                child: Row(
                  children: [
                    widget.attachmentIcon != null
                        ? IconButton(
                          icon: widget.attachmentIcon!,
                          color:
                              widget.attachmentIconColor ??
                              theme.colors.onSurface.withValues(alpha: 0.5),
                          onPressed: onAttachmentTap,
                        )
                        : const SizedBox.shrink(),
                    SizedBox(width: widget.gap),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: theme.typography.bodyMedium.copyWith(
                            color:
                                widget.hintColor ??
                                theme.colors.onSurface.withValues(alpha: 0.5),
                          ),
                          border: widget.inputBorder,
                          filled: widget.filled,
                          fillColor:
                              widget.inputFillColor ??
                              theme.colors.surfaceContainerHigh.withValues(
                                alpha: 0.8,
                              ),
                          hoverColor: Colors.transparent,
                        ),
                        style: theme.typography.bodyMedium.copyWith(
                          color: widget.textColor ?? theme.colors.onSurface,
                        ),
                        onSubmitted: _handleSubmitted,
                        textInputAction: widget.textInputAction,
                        keyboardAppearance: widget.keyboardAppearance,
                        autocorrect: widget.autocorrect ?? true,
                        autofocus: widget.autofocus,
                        textCapitalization: widget.textCapitalization,
                        keyboardType: widget.keyboardType,
                        focusNode: _focusNode,
                        maxLength: widget.maxLength,
                        minLines: widget.minLines,
                        maxLines: widget.maxLines,
                      ),
                    ),
                    SizedBox(width: widget.gap),
                    widget.sendIcon != null
                        ? IconButton(
                          icon: widget.sendIcon!,
                          color:
                              widget.sendIconColor ??
                              theme.colors.onSurface.withValues(alpha: 0.5),
                          onPressed:
                              () => _handleSubmitted(_textController.text),
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _measure() {
    if (!mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      final bottomSafeArea = MediaQuery.of(context).padding.bottom;

      context.read<ChatInputHeightNotifier>().setHeight(
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
