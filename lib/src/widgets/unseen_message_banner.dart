import 'package:flutter/material.dart';

import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';

class UnseenMessageBanner extends StatelessWidget {
  const UnseenMessageBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: InheritedChatTheme.of(context)
            .theme
            .unseenMessagesBannerTheme
            .color,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(bottom: 24, top: 8),
        child: Text(
          InheritedL10n.of(context).l10n.unseenMessagesBannerLabel,
          style: InheritedChatTheme.of(context)
              .theme
              .unseenMessagesBannerTheme
              .textStyle,
        ),
      );
}

@immutable
class ScrollToUnseenOptions {
  const ScrollToUnseenOptions({
    this.lastSeenMessageID,
    this.scrollDelay = const Duration(milliseconds: 150),
    this.scrollDuration = const Duration(milliseconds: 250),
    this.scrollOnOpen = false,
  });

  /// Will show an unseen messages banner after this message if there are more
  /// messages to come and will scroll to this banner on
  /// [ChatState.scrollToFirstUnseen].
  final String? lastSeenMessageID;

  /// Duration to wait after open until the scrolling starts.
  final Duration scrollDelay;

  /// Duration for the animation of the scrolling.
  final Duration scrollDuration;

  /// Whether to scroll to the first unseen message on open.
  final bool scrollOnOpen;
}
