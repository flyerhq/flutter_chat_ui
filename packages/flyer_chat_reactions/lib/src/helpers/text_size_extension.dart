import 'package:flutter/material.dart';

extension TextSize on String {
  Size getPaintedSize(BuildContext context, TextStyle textStyle) {
    return (TextPainter(
      text: TextSpan(text: this, style: textStyle),
      maxLines: 1,
      textScaler: MediaQuery.of(context).textScaler,
      textDirection: TextDirection.ltr,
    )..layout()).size;
  }
}
