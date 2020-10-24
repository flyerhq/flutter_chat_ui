import 'package:flutter/material.dart';

class AttachmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Image.asset(
          'assets/icon-attachment.png',
          package: 'flutter_chat_ui',
        ),
        onPressed: () {},
      ),
    );
  }
}
