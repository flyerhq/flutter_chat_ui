import 'dart:math';

import 'package:flutter/material.dart';

class WaveForm extends StatefulWidget {
  const WaveForm({
    Key? key,
    required this.waveForm,
    required this.color,
    required this.duration,
    required this.position,
    this.onSeek,
    this.onTap,
    this.onStartSeeking,
    this.accessibilityLabel,
  }) : super(key: key);

  final List<double>? waveForm;
  final Color color;
  final Duration duration;
  final Duration position;
  final void Function(Duration)? onSeek;
  final void Function()? onTap;
  final void Function()? onStartSeeking;
  final String? accessibilityLabel;

  @override
  _WaveFormState createState() => _WaveFormState();
}

class _WaveFormState extends State<WaveForm> {
  late Duration _position;
  late double _dragChange;

  @override
  void initState() {
    _position = widget.position;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WaveForm oldWidget) {
    _position = widget.position;
    super.didUpdateWidget(oldWidget);
  }

  List<double> _reduceSamples(List<double> inputs, int maxSamples) {
    if (inputs.length < maxSamples) {
      return [...inputs];
    } else {
      final reductionFactor = (inputs.length / maxSamples).ceil();
      final result = <double>[];
      for (var i = 0; i < inputs.length; i += reductionFactor) {
        result.add(inputs[i]);
      }
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final levels = widget.waveForm != null
            ? _reduceSamples(widget.waveForm!, constraints.maxWidth.round())
            : List.filled(constraints.maxWidth.round(), 1.0);

        var maxLevel = 1.0;
        if (widget.waveForm != null) {
          final sortedLevels = [...levels];
          sortedLevels.sort((level1, level2) => level1.compareTo(level2));
          maxLevel = sortedLevels.last;
        }
        if (maxLevel < 1.0) {
          maxLevel = 1.0;
        }

        final barWidth = constraints.maxWidth / levels.length;

        return GestureDetector(
          onTap: widget.onTap,
          onHorizontalDragStart: widget.onSeek != null
              ? (details) {
                  if (widget.onStartSeeking != null) {
                    widget.onStartSeeking!();
                  }
                  _dragChange = 0.0;
                }
              : null,
          onHorizontalDragUpdate: widget.onSeek != null
              ? (dragUpdateDetail) {
                  _dragChange += dragUpdateDetail.delta.dx;
                  setState(() {
                    _position = Duration(
                      milliseconds: widget.position.inMilliseconds +
                          (widget.duration.inMilliseconds *
                                  _dragChange /
                                  constraints.maxWidth)
                              .round(),
                    );
                  });
                }
              : null,
          onHorizontalDragEnd: widget.onSeek != null
              ? (dragEndDetails) {
                  widget.onSeek!(_position);
                  _dragChange = 0.0;
                }
              : null,
          child: Semantics(
            label: widget.accessibilityLabel,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: levels.asMap().entries.map(
                (entry) {
                  final height = widget.waveForm != null
                      ? max(
                          (entry.value == double.nan ? 0.0 : entry.value) *
                              constraints.maxHeight /
                              maxLevel,
                          2.0)
                      : 2.0;
                  return Container(
                    constraints: BoxConstraints(
                      minHeight: height,
                      maxHeight: height,
                      minWidth: barWidth,
                      maxWidth: barWidth,
                    ),
                    color: widget.color.withOpacity(
                        (entry.key / levels.length) <
                                (_position.inMilliseconds /
                                    widget.duration.inMilliseconds)
                            ? 1.0
                            : 0.4),
                    height: height,
                    width: barWidth,
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
