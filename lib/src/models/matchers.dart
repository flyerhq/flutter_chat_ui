import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show regexEmail, regexLink;
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flutter_chat_ui.dart';

MatchText mailToMatcher({
  final TextStyle? style,
}) =>
    MatchText(
      onTap: (mail) async {
        final url = Uri(scheme: 'mailto', path: mail);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      pattern: regexEmail,
      style: style,
    );

MatchText urlMatcher({
  final TextStyle? style,
  final Function(String url)? onLinkPressed,
}) =>
    MatchText(
      onTap: (urlText) async {
        final protocolIdentifierRegex = RegExp(
          r'^((http|ftp|https):\/\/)',
          caseSensitive: false,
        );
        if (!urlText.startsWith(protocolIdentifierRegex)) {
          urlText = 'https://$urlText';
        }
        if (onLinkPressed != null) {
          onLinkPressed(urlText);
        } else {
          final url = Uri.tryParse(urlText);
          if (url != null && await canLaunchUrl(url)) {
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      },
      pattern: regexLink,
      style: style,
    );

MatchText _patternStyleMatcher({
  required final PatternStyle patternStyle,
  final TextStyle? style,
}) =>
    MatchText(
      pattern: patternStyle.pattern,
      style: style,
      renderText: ({required String str, required String pattern}) => {
        'display': str.replaceAll(
          patternStyle.from,
          patternStyle.replace,
        ),
      },
    );

MatchText boldMatcher({
  final TextStyle? style,
}) =>
    _patternStyleMatcher(
      patternStyle: PatternStyle.bold,
      style: style,
    );

MatchText italicMatcher({
  final TextStyle? style,
}) =>
    _patternStyleMatcher(
      patternStyle: PatternStyle.italic,
      style: style,
    );

MatchText lineThroughMatcher({
  final TextStyle? style,
}) =>
    _patternStyleMatcher(
      patternStyle: PatternStyle.lineThrough,
      style: style,
    );

MatchText codeMatcher({
  final TextStyle? style,
}) =>
    _patternStyleMatcher(
      patternStyle: PatternStyle.code,
      style: style,
    );
