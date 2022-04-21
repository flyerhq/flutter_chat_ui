import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../util.dart';
import 'inherited_chat_theme.dart';

/// Renders user's name as a message heading according to the theme
class UserName extends StatelessWidget {
  /// Creates user name
  const UserName({
    Key? key,
    required this.author,
  }) : super(key: key);

  /// Author to show name from
  final types.User author;

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    final color = getUserAvatarNameColor(author, theme.userAvatarNameColors);
    final name = getUserName(author);

    return name.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.userNameTextStyle.copyWith(color: color),
            ),
          );
  }
}
