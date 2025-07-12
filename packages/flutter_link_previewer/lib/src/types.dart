import 'package:flutter/material.dart';

/// Represents the size object.
@immutable
class Size {
  /// Creates [Size] from width and height.
  const Size({required this.height, required this.width});

  /// Height.
  final double height;

  /// Width.
  final double width;
}
