import 'package:flutter/material.dart';

class ScrollToBottom extends StatelessWidget {
  final Animation<double> animation;
  final double bottomPosition;
  final VoidCallback onPressed;

  const ScrollToBottom({
    super.key,
    required this.animation,
    required this.bottomPosition,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: bottomPosition,
      child: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          heroTag: null,
          mini: true,
          shape: const CircleBorder(),
          onPressed: onPressed,
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }
}
