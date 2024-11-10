import 'package:flutter/material.dart';

/// A widget that displays bars based on audio input level.
///
/// This widget is used to indicate ongoing processes like recording by
/// adjusting the height of bars according to the audio input level.
class BarAnimation extends StatelessWidget {
  /// The color of the bars in the animation.
  final Color color;

  /// The audio input level that affects the bar height.
  final double audioLevel;

  /// Creates a [BarAnimation] widget.
  const BarAnimation(
      {super.key, required this.color, required this.audioLevel,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(32, (index) {
        final barHeight = audioLevel * 16.0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Container(
            width: 4.0,
            height: barHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        );
      }),
    );
  }
}
