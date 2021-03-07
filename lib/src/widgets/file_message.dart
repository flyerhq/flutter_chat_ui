import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../util.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

class FileMessage extends StatelessWidget {
  const FileMessage({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  final types.FileMessage message;
  final void Function(types.FileMessage)? onPressed;

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;

    return GestureDetector(
      onTap: () => onPressed?.call(message),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _user.id == message.authorId
                    ? InheritedChatTheme.of(context)
                        .theme
                        .primaryTextColor
                        .withOpacity(0.2)
                    : InheritedChatTheme.of(context)
                        .theme
                        .primaryColor
                        .withOpacity(0.2),
                borderRadius: BorderRadius.circular(21),
              ),
              height: 42,
              width: 42,
              child: Image.asset(
                'assets/icon-document.png',
                color: _user.id == message.authorId
                    ? InheritedChatTheme.of(context).theme.primaryTextColor
                    : InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.fileName,
                      style:
                          InheritedChatTheme.of(context).theme.body1.copyWith(
                                color: _user.id == message.authorId
                                    ? InheritedChatTheme.of(context)
                                        .theme
                                        .primaryTextColor
                                    : InheritedChatTheme.of(context)
                                        .theme
                                        .secondaryTextColor,
                              ),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        formatBytes(message.size),
                        style: InheritedChatTheme.of(context)
                            .theme
                            .caption
                            .copyWith(
                              color: _user.id == message.authorId
                                  ? InheritedChatTheme.of(context)
                                      .theme
                                      .primaryTextColor
                                      .withOpacity(0.5)
                                  : InheritedChatTheme.of(context)
                                      .theme
                                      .captionColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
