import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// A widget to display when the chat list is empty.
class EmptyChatList extends StatefulWidget {
  /// Creates an empty chat list widget.
  const EmptyChatList({
    super.key,
    this.text = 'No messages yet',
    this.textStyle,
    this.padding,
    this.fadeInDuration = const Duration(milliseconds: 250),
    this.fadeInDelay = const Duration(milliseconds: 50),
    this.curve = Curves.linearToEaseOut,
  });

  /// The text to display.
  final String text;

  /// The style to use for the text.
  final TextStyle? textStyle;

  /// The padding to use for the text.
  final EdgeInsetsGeometry? padding;

  /// The duration of the fade-in animation.
  final Duration fadeInDuration;

  /// The delay before the fade-in animation starts.
  final Duration fadeInDelay;

  /// The curve for the fade-in animation.
  final Curve curve;

  @override
  State<EmptyChatList> createState() => _EmptyChatListState();
}

class _EmptyChatListState extends State<EmptyChatList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    Future.delayed(widget.fadeInDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) =>
          (bodyLarge: t.typography.bodyLarge, onSurface: t.colors.onSurface),
    );

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.only(bottom: 120),
        child: Center(
          child: Text(
            widget.text,
            style:
                widget.textStyle ??
                theme.bodyLarge.copyWith(color: theme.onSurface),
          ),
        ),
      ),
    );
  }
}
