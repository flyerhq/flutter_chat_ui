import 'package:flutter/material.dart';
import 'inherited_chat_theme.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Image.asset(
          'assets/icon-send.png',
          color: InheritedChatTheme.of(context).theme.inputTextColor,
          package: 'flutter_chat_ui',
        ),
        onPressed: onPressed,
      ),
    );
  }
}
