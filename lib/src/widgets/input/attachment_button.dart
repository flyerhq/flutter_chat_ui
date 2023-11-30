import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents attachment button widget.
class AttachmentButton extends StatelessWidget {
  /// Creates attachment button widget.
  const AttachmentButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.padding = const EdgeInsets.all(10),
  });

  /// Show a loading indicator instead of the button.
  final bool isLoading;

  /// Callback for attachment button tap event.
  final VoidCallback? onPressed;

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
                    'packages/flutter_chat_ui/assets/chat/gallery.svg',
                    color: InheritedChatTheme.of(context)
                        .theme
                        .attachmentButtonColor),
          ),
        ),
      );
}
