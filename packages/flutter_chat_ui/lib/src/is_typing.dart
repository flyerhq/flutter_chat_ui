import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class IsTypingIndicator extends StatefulWidget {
  final double size;
  final Color? color;
  final Duration? duration;
  final double spacing;

  const IsTypingIndicator({
    super.key,
    this.size = 6,
    this.color,
    this.duration = const Duration(milliseconds: 150),
    this.spacing = 3,
  });

  @override
  State<IsTypingIndicator> createState() => _IsTypingIndicatorState();
}

class _IsTypingIndicatorState extends State<IsTypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration: widget.duration,
      ),
    );

    _controllers[0].forward();

    _controllers[0].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[0].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[1].forward();
      }
    });

    _controllers[1].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[1].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[2].forward();
      }
    });

    _controllers[2].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[2].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[0].forward();
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = _getDotColor(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.size / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: widget.spacing,
        children: List.generate(3, (index) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 0),
              end: Offset(0, -0.5),
            ).animate(
              CurvedAnimation(
                parent: _controllers[index],
                curve: Curves.easeOut,
              ),
            ),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }

  Color? _getDotColor(BuildContext context) {
    if (widget.color != null) return widget.color;

    try {
      return context.select((ChatTheme theme) => theme.isTypingTheme).color;
    } catch (_) {
      return null;
    }
  }
}
