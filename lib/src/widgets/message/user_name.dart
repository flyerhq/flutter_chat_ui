import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../util.dart';
import '../state/inherited_chat_theme.dart';

/// Renders user's name as a message heading according to the theme.
class UserName extends StatelessWidget {
  /// Creates user name.
  const UserName({
    super.key,
    required this.author,
    required this.verified,
    this.onUserNameTap,
  });

  /// Author to show name from.
  final types.User author;
  final bool verified;
  final void Function(types.User)? onUserNameTap;

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    final color = getUserAvatarNameColor(author, theme.userAvatarNameColors);
    final name = getUserName(author);

    return name.isEmpty
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              onUserNameTap?.call(author);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.userNameTextStyle
                        .copyWith(color: color, fontSize: 12),
                  ),
                  if (verified)
                       SizedBox(
                        width: 14.0,
                        height: 18.0,
                        child: Stack(children: [
                          Center(
                            child: Icon(
                              FontAwesomeIcons.certificate,
                              color: Colors.blue,
                              size: 12,
                            ),
                          ),
                          Center(
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 7,
                            ),
                          ),
                        ]),
                      ),
                    
                ],
              ),
            ),
          );
  }
}
