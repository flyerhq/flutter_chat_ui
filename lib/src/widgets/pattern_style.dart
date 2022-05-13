import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PatternStyle {
  final RegExp regExp;
  final Pattern from;
  final String replace;
  final TextStyle textStyle;

  PatternStyle(this.regExp, this.from, this.replace, this.textStyle);

  String get pattern => regExp.pattern;

  static PatternStyle get bold => PatternStyle(
        RegExp('(\\*\\*|\\*)(.*?)(\\*\\*|\\*)'),
        RegExp('(\\*\\*|\\*)'),
        '',
        const TextStyle(fontWeight: FontWeight.bold),
      );

  static PatternStyle get italic => PatternStyle(
        RegExp('_(.*?)_'),
        '_',
        '',
        const TextStyle(fontStyle: FontStyle.italic),
      );

  static PatternStyle get lineThrough => PatternStyle(
        RegExp('~(.*?)~'),
        '~',
        '',
        const TextStyle(decoration: TextDecoration.lineThrough),
      );

  static PatternStyle get code => PatternStyle(
        RegExp('`(.*?)`'),
        '`',
        '',
        TextStyle(fontFamily: Platform.isIOS ? 'Courier' : 'monospace'),
      );
}
