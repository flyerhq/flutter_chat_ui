import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key key,
    @required this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

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
          color: const Color(0xffffffff),
          package: 'flutter_chat_ui',
        ),
        onPressed: onPressed,
      ),
    );
  }
}
