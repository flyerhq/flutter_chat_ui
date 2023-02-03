import 'package:flutter/material.dart';

import '../../../flutter_chat_ui.dart';
import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents attachment button widget.
class PenButton extends StatelessWidget {
  /// Creates attachment button widget.
  const PenButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Show a loading indicator instead of the button.
  final bool isLoading;

  /// Callback for attachment button tap event.
  final VoidCallback? onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: InheritedChatTheme.of(context).theme.attachmentButtonMargin ??
            const EdgeInsetsDirectional.fromSTEB(
              0,
              0,
              0,
              0,
            ),
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          icon: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.inputTextColor,
                    ),
                  ),
                )
              : InheritedChatTheme.of(context).theme.attachmentButtonIcon ??
                  Image.asset('icon-pen.png'),
          // Image.asset(
          //   'assets/icon-document.png',
          //   color: InheritedChatTheme.of(context).theme.inputTextColor,
          //   package: 'flutter_chat_ui',
          // ),
          // Image(
          //   image: AssetImage('assets/icon-document.png'),
          // ),
          onPressed: isLoading ? null : onPressed,
          padding: padding,
          splashRadius: 24,
          tooltip:
              InheritedL10n.of(context).l10n.attachmentButtonAccessibilityLabel,
        ),
      );
}
