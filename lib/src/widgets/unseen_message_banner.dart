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
