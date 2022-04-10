import 'package:flutter/material.dart';

import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';

/// A class that represents send button widget
class SendButton extends StatelessWidget {
  /// Creates send button widget
  const SendButton({
    Key? key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  /// Callback for send button tap event
  final void Function() onPressed;

  /// Padding around the icon button
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: InheritedChatTheme.of(context).theme.sendButtonMargin ??
          const EdgeInsets.only(left: 16),
      child: IconButton(
        splashRadius: 24,
        constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
        icon: InheritedChatTheme.of(context).theme.sendButtonIcon ??
            Image.asset(
              'assets/icon-send.png',
              color: InheritedChatTheme.of(context).theme.inputTextColor,
              package: 'flutter_chat_ui',
            ),
        onPressed: onPressed,
        padding: padding,
        tooltip: InheritedL10n.of(context).l10n.sendButtonAccessibilityLabel,
      ),
    );
  }
}
