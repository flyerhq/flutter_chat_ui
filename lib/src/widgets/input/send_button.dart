import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 24,
          ),
          child: Padding(
            padding: padding,
            child: InheritedChatTheme.of(context).theme.sendButtonIcon ??
                SvgPicture.asset(
                    'packages/flutter_chat_ui/assets/chat/send.svg',
                    color:
                        InheritedChatTheme.of(context).theme.sendButtonColor),
          ),
        ),
      );
}
