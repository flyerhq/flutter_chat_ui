import 'package:flutter/material.dart';

import 'pattern_style.dart';

/// Controller for the [TextField] on [Input] widget
/// To highlighting the matches for pattern
class InputTextFieldController extends TextEditingController {
  /// A map of style to apply to the text pattern
  final List<PatternStyle> _listPatternStyle = [
    PatternStyle.bold,
    PatternStyle.italic,
    PatternStyle.lineThrough,
    PatternStyle.code,
  ];

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(text: text, style: style).splitMapJoin(
      RegExp(_listPatternStyle.map((it) => it.regExp.pattern).join('|')),
      onMatch: (match) {
        final text = match[0]!;
        final style = _listPatternStyle
            .firstWhere((element) => element.regExp.hasMatch(text))
            .textStyle;
        return TextSpan(text: text, style: style);
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
