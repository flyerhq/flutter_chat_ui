import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../models/bubble_rtl_alignment.dart';
import '../../util.dart';
import '../state/inherited_chat_theme.dart';

/// Renders user's avatar or initials next to a message.
class UserAvatar extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatar({
    super.key,
    required this.author,
    this.bubbleRtlAlignment,
    this.imageHeaders,
    this.onAvatarTap,
  });

  /// Author to show image and name initials from.
  final types.User author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Called when user taps on an avatar.
  final void Function(types.User, Offset position)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);

    return Container(
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? const EdgeInsetsDirectional.only(end: 0)
          : const EdgeInsets.only(right: 0),
      child: GestureDetector(
          onTapDown: (TapDownDetails details){
          onAvatarTap?.call(author, details.globalPosition);
        },
        child: CircleAvatar(
          backgroundColor: hasImage
              ? InheritedChatTheme.of(context)
                  .theme
                  .userAvatarImageBackgroundColor
              : color,
          backgroundImage: hasImage
              ? NetworkImage(author.imageUrl!, headers: imageHeaders)
              : null,
          radius: 16,
          child: !hasImage
              ? Text(
                  initials,
                  style:
                      InheritedChatTheme.of(context).theme.userAvatarTextStyle,
                )
              : null,
        ),
      ),
    );
  }
}
