import 'package:flutter/material.dart';

import '../../../flutter_chat_ui.dart';
import '../state/inherited_chat_theme.dart';

/// A class that represents system message widget.
class SystemMessage extends StatelessWidget {
  const SystemMessage({
    required this.message,
    this.options = const TextMessageOptions(),
    super.key,
  });

  /// System message.
  final String message;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: InheritedChatTheme.of(context).theme.systemMessageTheme.margin,
        child: TextMessageText(
          bodyLinkTextStyle: InheritedChatTheme.of(context)
              .theme
              .systemMessageTheme
              .linkTextStyle,
          bodyTextStyle:
              InheritedChatTheme.of(context).theme.systemMessageTheme.textStyle,
          boldTextStyle: InheritedChatTheme.of(context)
              .theme
              .systemMessageTheme
              .boldTextStyle,
          codeTextStyle: InheritedChatTheme.of(context)
              .theme
              .systemMessageTheme
              .codeTextStyle,
          options: options,
          text: message,
        ),
      );
}

@immutable
class SystemMessageTheme {
  const SystemMessageTheme({
    required this.margin,
    this.linkTextStyle,
    required this.textStyle,
    this.boldTextStyle,
    this.codeTextStyle,
  });

  /// Margin around the system message.
  final EdgeInsets margin;

  /// Style to apply to anything that matches a link.
  final TextStyle? linkTextStyle;

  /// Regular style to use for any unmatched text. Also used as basis for the fallback options.
  final TextStyle textStyle;

  /// Style to apply to anything that matches bold markdown.
  final TextStyle? boldTextStyle;

  /// Style to apply to anything that matches code markdown.
  final TextStyle? codeTextStyle;
}
