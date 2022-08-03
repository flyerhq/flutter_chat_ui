import 'package:flutter/material.dart';

import 'inherited_chat_theme.dart';

class UnseenMessageBanner extends StatelessWidget {
  const UnseenMessageBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        child: Text(
          'Unseen messages',
          style: InheritedChatTheme.of(context)
              .theme
              .dateDividerTextStyle
              .copyWith(color: Colors.white),
        ),
      );
}

@immutable
class ScrollToUnseenOptions {
  const ScrollToUnseenOptions({
    this.lastSeenMessageID,
    this.scrollDelay = const Duration(milliseconds: 150),
    this.scrollDuration = const Duration(milliseconds: 350),
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
