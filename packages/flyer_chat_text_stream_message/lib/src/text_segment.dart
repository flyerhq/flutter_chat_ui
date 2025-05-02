import 'package:flutter/animation.dart';

/// Represents a segment of text within the streaming message display.
/// Used internally by [FlyerChatTextStreamMessage] when using the
/// [TextStreamMessageMode.animatedOpacity] mode.
sealed class TextSegment {
  /// The text content of this segment.
  final String text;

  /// Creates a constant text segment.
  const TextSegment(this.text);
}

/// A segment of text that is static and fully visible.
class StaticSegment extends TextSegment {
  /// Creates a static text segment with the given [text].
  StaticSegment(super.text);
}

/// A segment of text that is currently animating (fading in).
class AnimatingSegment extends TextSegment {
  /// The animation controller driving the fade-in effect.
  final AnimationController controller;

  /// The fade animation, typically ranging from 0.0 to 1.0.
  final Animation<double> fadeAnimation;

  /// Creates an animating text segment.
  AnimatingSegment(super.text, this.controller, this.fadeAnimation);

  /// Disposes the associated animation controller.
  void dispose() {
    controller.dispose();
  }
}
