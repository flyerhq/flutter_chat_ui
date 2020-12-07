import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/util.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';

class FileMessage extends StatelessWidget {
  const FileMessage({
    Key key,
    @required this.message,
    this.onPressed,
  })  : assert(message != null),
        super(key: key);

  final types.FileMessage message;
  final void Function(types.FileMessage message) onPressed;

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;

    return GestureDetector(
      onTap: () => onPressed(message),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _user.id == message.authorId
                    ? const Color(0x33ffffff)
                    : const Color(0x336f61e8),
                borderRadius: BorderRadius.circular(21),
              ),
              height: 42,
              width: 42,
              child: Image.asset(
                'assets/icon-document.png',
                color: _user.id == message.authorId
                    ? const Color(0xffffffff)
                    : const Color(0xff6f61e8),
                package: 'flutter_chat_ui',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.fileName,
                    style: TextStyle(
                      color: _user.id == message.authorId
                          ? const Color(0xffffffff)
                          : const Color(0xff1d1d21),
                      fontFamily: 'Avenir',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.375,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      formatBytes(message.size),
                      style: TextStyle(
                        color: _user.id == message.authorId
                            ? const Color(0x80ffffff)
                            : const Color(0xff9e9cab),
                        fontFamily: 'Avenir',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.375,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
