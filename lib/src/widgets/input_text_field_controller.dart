import 'dart:ui';

import 'package:flutter/material.dart';

/// Controller for the [TextField] on [Input] widget
/// To highlighting the matches for pattern
class InputTextFieldController extends TextEditingController {
  /// A map of style to apply to the text pattern
  final Map<RegExp, TextStyle> _patternStyle = {
    RegExp('(\\*\\*|\\*)(.*?)(\\*\\*|\\*)'):
        const TextStyle(fontWeight: FontWeight.bold),
    RegExp('_(.*?)_'): const TextStyle(fontStyle: FontStyle.italic),
    RegExp('~(.*?)~'): const TextStyle(decoration: TextDecoration.lineThrough),
    RegExp('`(.*?)`'):
        const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
  };

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(text: text, style: style).splitMapJoin(
      RegExp(_patternStyle.keys.map((it) => it.pattern).join('|')),
      onMatch: (match) {
        final text = match[0]!;
        final key = _patternStyle.keys.firstWhere((it) => it.hasMatch(text));
        return TextSpan(text: text, style: _patternStyle[key]);
      },
    );
  }
}

extension _TextSpanX on TextSpan {
  TextSpan splitMapJoin(
    Pattern pattern, {
    TextSpan Function(Match)? onMatch,
    TextSpan Function(TextSpan)? onNonMatch,
  }) {
    final children = <TextSpan>[];

    toPlainText().splitMapJoin(
      pattern,
      onMatch: (match) {
        final span = TextSpan(text: match.group(0), style: style);
        final updated = onMatch?.call(match);
        children.add(updated ?? span);
        return span.toPlainText();
      },
      onNonMatch: (text) {
        final span = TextSpan(text: text, style: style);
        final updatedSpan = onNonMatch?.call(span);
        children.add(updatedSpan ?? span);
        return span.toPlainText();
      },
    );

    return TextSpan(style: style, children: children);
  }
}
