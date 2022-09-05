import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart'
    show scrollAnimationDuration;

import 'state/inherited_chat_theme.dart';
import 'state/inherited_l10n.dart';

class UnreadHeader extends StatelessWidget {
  const UnreadHeader({super.key, this.marginTop});

  /// Top margin of the header.
  final double? marginTop;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: InheritedChatTheme.of(context).theme.unreadHeaderTheme.color,
        margin: EdgeInsets.only(bottom: 24, top: marginTop ?? 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          InheritedL10n.of(context).l10n.unreadMessagesLabel,
          style:
              InheritedChatTheme.of(context).theme.unreadHeaderTheme.textStyle,
          textAlign: TextAlign.center,
        ),
      );
}

@immutable
class ScrollToUnreadOptions {
  const ScrollToUnreadOptions({
    this.lastReadMessageId,
    this.scrollDelay = const Duration(milliseconds: 150),
    this.scrollDuration = scrollAnimationDuration,
    this.scrollOnOpen = false,
  });

  /// Will show an unread messages header after this message if there are more
  /// messages to come and will scroll to this header on
  /// [ChatState.scrollToUnreadHeader].
  final String? lastReadMessageId;

  /// Duration to wait after open until the scrolling starts.
  final Duration scrollDelay;

  /// Duration for the animation of the scrolling.
  final Duration scrollDuration;

  /// Whether to scroll to the first unread message on open.
  final bool scrollOnOpen;
}

@immutable
class UnreadHeaderTheme {
  const UnreadHeaderTheme({
    required this.color,
    required this.textStyle,
  });

  /// Background color of the header.
  final Color color;

  /// Text style for the unread message header text.
  final TextStyle textStyle;
}
