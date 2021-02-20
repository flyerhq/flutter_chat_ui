import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/attachment_button.dart';
import 'package:flutter_chat_ui/src/widgets/send_button.dart';

class Input extends StatefulWidget {
  const Input({
    Key key,
    this.isAttachmentUploading,
    this.onAttachmentPressed,
    @required this.onSendPressed,
  })  : assert(onSendPressed != null),
        super(key: key);

  final void Function() onAttachmentPressed;
  final bool isAttachmentUploading;
  final void Function(types.PartialText) onSendPressed;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _sendButtonVisible = false;
  final _textController = TextEditingController();

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
    final _partialText = types.PartialText(text: _textController.text.trim());
    widget.onSendPressed(_partialText);
    _textController.clear();
  }

  void _handleTextControllerChange() {
    setState(() {
      _sendButtonVisible = _textController.text != '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          24 + _query.padding.left,
          20,
          24 + _query.padding.right,
          20 + _query.viewInsets.bottom + _query.padding.bottom,
        ),
        child: Row(
          children: [
            widget.isAttachmentUploading ?? false
                ? Container(
                    height: 24,
                    width: 24,
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xffffffff),
                      ),
                    ),
                  )
                : AttachmentButton(
                    onPressed: widget.onAttachmentPressed,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration.collapsed(
                    hintStyle: TextStyle(
                      color: Color(0x80ffffff),
                    ),
                    hintText: 'Your message here',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: const TextStyle(
                    color: Color(0xffffffff),
                    fontFamily: 'Avenir',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.375,
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
