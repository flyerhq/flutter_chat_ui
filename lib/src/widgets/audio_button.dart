import 'package:flutter/material.dart';

import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';

class AudioButton extends StatelessWidget {
  /// Creates audio button widget
  const AudioButton({
    Key? key,
    required this.onPressed,
    required this.recordingAudio,
  }) : super(key: key);

  /// Callback for audio button tap event
  final void Function() onPressed;

  final bool recordingAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(left: 16),
      child: IconButton(
        icon: InheritedChatTheme.of(context).theme.audioButtonIcon != null
            ? Image.asset(
                InheritedChatTheme.of(context).theme.audioButtonIcon!,
                color: InheritedChatTheme.of(context).theme.inputTextColor,
              )
            : recordingAudio
                ? (InheritedChatTheme.of(context).theme.sendButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.sendButtonIcon!,
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                      )
                    : Image.asset(
                        'assets/icon-send.png',
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                        package: 'flutter_chat_ui',
                      ))
                : (InheritedChatTheme.of(context).theme.audioButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.audioButtonIcon!,
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                      )
                    : Icon(
                        Icons.mic_none,
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                      )),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        tooltip: recordingAudio
            ? InheritedL10n.of(context).l10n.sendButtonAccessibilityLabel
            : InheritedL10n.of(context).l10n.audioButtonAccessibilityLabel,
      ),
    );
  }
}
