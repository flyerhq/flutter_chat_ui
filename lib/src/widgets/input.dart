import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(
        24 + query.padding.left,
        20,
        24 + query.padding.right,
        20 + query.viewInsets.bottom + query.padding.bottom,
      ),
      child: const TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration.collapsed(
          hintStyle: TextStyle(color: Colors.white60),
          hintText: 'Message',
        ),
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
