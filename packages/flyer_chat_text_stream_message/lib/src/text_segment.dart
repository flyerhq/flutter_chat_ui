import 'package:flutter/animation.dart';

sealed class TextSegment {
  final String text;
  const TextSegment(this.text);
}

class StaticSegment extends TextSegment {
  StaticSegment(super.text);
}

class AnimatingSegment extends TextSegment {
  final AnimationController controller;
  final Animation<double> fadeAnimation;
  AnimatingSegment(super.text, this.controller, this.fadeAnimation);

  void dispose() {
    controller.dispose();
  }
}
