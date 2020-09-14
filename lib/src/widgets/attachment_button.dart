import 'package:flutter/material.dart';

class AttachmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      width: 22,
      child: IconButton(
        iconSize: 22,
        padding: EdgeInsets.zero,
        splashRadius: 22,
        icon: Image.asset(
          'assets/icon-attachment.png',
          package: 'flutter_chat_ui',
        ),
        onPressed: () {},
      ),
    );
  }
}
