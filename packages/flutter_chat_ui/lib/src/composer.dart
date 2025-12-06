import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/composer_height_notifier.dart';
import 'utils/typedefs.dart';

/// The message composer widget positioned at the bottom of the chat screen.
///
/// Includes a text input field, an optional attachment button, and a send button.
class Composer extends StatefulWidget {
  /// Optional controller for the text input field.
  final TextEditingController? textEditingController;

  /// Optional left position.
  final double? left;

  /// Optional right position.
  final double? right;

  /// Optional top position.
  final double? top;

  /// Optional bottom position.
  final double? bottom;

  /// Optional X blur value for the background (if using glassmorphism).
  final double? sigmaX;

  /// Optional Y blur value for the background (if using glassmorphism).
  final double? sigmaY;

  /// Padding around the composer content.
  final EdgeInsetsGeometry? padding;

  /// Icon for the attachment button. Defaults to [Icons.attachment].
  final Widget? attachmentIcon;

  /// Icon for the send button. Defaults to [Icons.send].
  final Widget? sendIcon;

  /// Horizontal gap between elements (attachment icon, text field, send icon).
  final double? gap;

  /// Border style for the text input field.
  final InputBorder? inputBorder;

  /// Whether the text input field should be filled.
  final bool? filled;

  /// Optional widget to display above the main composer row.
  final Widget? topWidget;

  /// Whether to adjust padding for the bottom safe area.
  final bool? handleSafeArea;

  /// Background color of the composer container.
  final Color? backgroundColor;

  /// Color of the attachment icon.
  final Color? attachmentIconColor;

  /// Color of the send icon.
  final Color? sendIconColor;

  /// Color of the send icon when the text is empty.
  final Color? emptyFieldSendIconColor;

  /// Color of the hint text in the input field.
  final Color? hintColor;

  /// Color of the text entered in the input field.
  final Color? textColor;

  /// Fill color for the text input field when [filled] is true.
  final Color? inputFillColor;

  /// Placeholder text for the input field.
  final String? hintText;

  /// Appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// Whether to enable autocorrect for the input field.
  final bool? autocorrect;

  /// Whether the input field should autofocus.
  final bool autofocus;

  /// Capitalization behavior for the input field.
  final TextCapitalization textCapitalization;

  /// Type of keyboard to display.
  final TextInputType? keyboardType;

  /// Action button type for the keyboard (e.g., newline, send).
  final TextInputAction? textInputAction;

  /// Focus node for the text input field.
  final FocusNode? focusNode;

  /// Maximum character length for the input field.
  final int? maxLength;

  /// Minimum number of lines for the input field.
  final int? minLines;

  /// Maximum number of lines the input field can expand to.
  final int? maxLines;

  /// Controls the visibility behavior of the send button.
  /// Defaults to [SendButtonVisibilityMode.disabled].
  final SendButtonVisibilityMode sendButtonVisibilityMode;

  /// Whether to allow sending empty messages. Defaults to `false`.
  /// This is only considered when the button is pressed, which for `hidden` and
  /// `disabled` modes still requires text to be present.
  final bool allowEmptyMessage;

  /// Whether to disable the send button.
  ///
  /// If `true`, this will override [sendButtonVisibilityMode] and show a
  /// disabled button. Defaults to `false`.
  final bool sendButtonDisabled;

  /// Whether to always hide the send button.
  ///
  /// If `true`, this will override all other send button-related properties
  /// and hide the button. Defaults to `false`.
  final bool sendButtonHidden;

  /// Controls the behavior of the text input field after a message is sent.
  /// Defaults to [InputClearMode.always].
  final InputClearMode inputClearMode;

  /// Configuration for content insertion (e.g., images, gifs, stickers) into the text field.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// Controls how the Enter key behaves.
  ///
  /// When `true`: pressing Enter sends the message, and Shift+Enter inserts a newline.
  /// When `false`: pressing Shift+Enter sends the message, and Enter inserts a newline.
  /// Defaults to `false`.
  final bool sendOnEnter;

  /// Creates a message composer widget.
  const Composer({
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
    this.backgroundColor,
    this.attachmentIconColor,
    this.sendIconColor,
    this.emptyFieldSendIconColor,
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
    this.sendButtonVisibilityMode = SendButtonVisibilityMode.disabled,
    this.allowEmptyMessage = false,
    this.sendButtonDisabled = false,
    this.sendButtonHidden = false,
    this.inputClearMode = InputClearMode.always,
    this.contentInsertionConfiguration,
    this.sendOnEnter = false,
  });

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final _key = GlobalKey();
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _hasTextNotifier;

  @override
  void initState() {
    super.initState();
    _textController = widget.textEditingController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _hasTextNotifier = ValueNotifier(_textController.text.trim().isNotEmpty);
    _focusNode.onKeyEvent = _handleKeyEvent;
    _textController.addListener(_handleTextControllerChange);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    // Check for Shift+Enter
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter &&
        widget.sendOnEnter ^ HardwareKeyboard.instance.isShiftPressed) {
      _handleSubmitted(_textController.text);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void didUpdateWidget(covariant Composer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textEditingController != oldWidget.textEditingController) {
      _textController.removeListener(_handleTextControllerChange);
      _textController = widget.textEditingController ?? TextEditingController();
      _textController.addListener(_handleTextControllerChange);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void dispose() {
    _hasTextNotifier.dispose();
    _textController.removeListener(_handleTextControllerChange);
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
    final bottomSafeArea = widget.handleSafeArea == true
        ? MediaQuery.of(context).padding.bottom
        : 0.0;
    final onAttachmentTap = context.read<OnAttachmentTapCallback?>();
    final theme = context.select(
      (ChatTheme t) => (
        bodyMedium: t.typography.bodyMedium,
        onSurface: t.colors.onSurface,
        primary: t.colors.primary,
        surfaceContainerHigh: t.colors.surfaceContainerHigh,
        surfaceContainerLow: t.colors.surfaceContainerLow,
      ),
    );

    final sigmaX = widget.sigmaX ?? 0;
    final sigmaY = widget.sigmaY ?? 0;
    final shouldUseBackdropFilter = sigmaX > 0 || sigmaY > 0;

    final content = Container(
      key: _key,
      color:
          widget.backgroundColor ??
          (shouldUseBackdropFilter
              ? theme.surfaceContainerLow.withValues(alpha: 0.8)
              : theme.surfaceContainerLow),
      child: Column(
        children: [
          if (widget.topWidget != null) widget.topWidget!,
          Padding(
            padding: widget.handleSafeArea == true
                ? (widget.padding?.add(
                        EdgeInsets.only(bottom: bottomSafeArea),
                      ) ??
                      EdgeInsets.only(bottom: bottomSafeArea))
                : (widget.padding ?? EdgeInsets.zero),
            child: Row(
              children: [
                widget.attachmentIcon != null && onAttachmentTap != null
                    ? IconButton(
                        icon: widget.attachmentIcon!,
                        color:
                            widget.attachmentIconColor ??
                            theme.onSurface.withValues(alpha: 0.5),
                        onPressed: onAttachmentTap,
                      )
                    : const SizedBox.shrink(),
                SizedBox(width: widget.gap),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    contentInsertionConfiguration:
                        widget.contentInsertionConfiguration,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: theme.bodyMedium.copyWith(
                        color:
                            widget.hintColor ??
                            theme.onSurface.withValues(alpha: 0.5),
                      ),
                      border: widget.inputBorder,
                      filled: widget.filled,
                      fillColor:
                          widget.inputFillColor ??
                          theme.surfaceContainerHigh.withValues(alpha: 0.8),
                      hoverColor: Colors.transparent,
                    ),
                    style: theme.bodyMedium.copyWith(
                      color: widget.textColor ?? theme.onSurface,
                    ),
                    onSubmitted: _handleSubmitted,
                    onChanged: (value) {
                      _hasTextNotifier.value = value.trim().isNotEmpty;
                    },
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
                if (widget.sendIcon != null && !widget.sendButtonHidden)
                  ValueListenableBuilder<bool>(
                    valueListenable: _hasTextNotifier,
                    builder: (context, hasText, child) {
                      if (widget.sendButtonVisibilityMode ==
                              SendButtonVisibilityMode.hidden &&
                          !hasText) {
                        return const SizedBox.shrink();
                      }

                      final isActive =
                          (hasText ||
                              widget.sendButtonVisibilityMode ==
                                  SendButtonVisibilityMode.always) &&
                          !widget.sendButtonDisabled;

                      return IconButton(
                        icon: widget.sendIcon!,
                        color: isActive
                            ? (widget.sendIconColor ??
                                  theme.onSurface.withValues(alpha: 0.5))
                            : (widget.emptyFieldSendIconColor ??
                                  widget.sendIconColor ??
                                  theme.onSurface.withValues(alpha: 0.5)),
                        onPressed:
                            (widget.sendButtonVisibilityMode ==
                                        SendButtonVisibilityMode.disabled &&
                                    !hasText) ||
                                widget.sendButtonDisabled
                            ? null
                            : () => _handleSubmitted(_textController.text),
                      );
                    },
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );

    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: ClipRect(
        child: shouldUseBackdropFilter
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                child: content,
              )
            : content,
      ),
    );
  }

  void _measure() {
    if (!mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      final bottomSafeArea = MediaQuery.of(context).padding.bottom;

      context.read<ComposerHeightNotifier>().setHeight(
        // only set real height of the composer, ignoring safe area
        widget.handleSafeArea == true ? height - bottomSafeArea : height,
      );
    }
  }

  void _handleTextControllerChange() {
    _hasTextNotifier.value = _textController.text.trim().isNotEmpty;
  }

  void _handleSubmitted(String text) {
    if (widget.allowEmptyMessage == false && text.trim().isEmpty) return;
    context.read<OnMessageSendCallback?>()?.call(text.trim());
    if (widget.inputClearMode == InputClearMode.always) {
      _textController.clear();
    }
  }
}
