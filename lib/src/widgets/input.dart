import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/widgets/attachment_button.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/send_button.dart';
import 'package:uuid/uuid.dart';

class Input extends StatefulWidget {
  Input({
    Key key,
    @required this.onSendPressed,
  })  : assert(onSendPressed != null),
        super(key: key);

  final void Function(TextMessageModel) onSendPressed;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final _textController = TextEditingController();
  bool _sendButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextControllerChange);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSendPressed() {
    final message = TextMessageModel(
      authorId: InheritedUser.of(context).user.id,
      id: Uuid().v4(),
      text: _textController.text.trim(),
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );
    widget.onSendPressed(message);
    _textController.clear();
  }

  void _handleTextControllerChange() {
    setState(() {
      _sendButtonVisible = _textController.text != '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          24 + query.padding.left,
          20,
          24 + query.padding.right,
          20 + query.viewInsets.bottom + query.padding.bottom,
        ),
        child: Row(
          children: [
            AttachmentButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration.collapsed(
                    hintStyle: TextStyle(color: Color(0xccffffff)),
                    hintText: 'Your message here',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            Visibility(
              visible: _sendButtonVisible,
              child: SendButton(
                onPressed: _handleSendPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
