import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  SendButton({
    Key key,
    this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        iconSize: 20,
        padding: EdgeInsets.zero,
        splashRadius: 20,
        icon: Image.asset(
          'assets/icon-send.png',
          package: 'flutter_chat_ui',
        ),
        onPressed: onPressed,
      ),
    );
  }
}
