import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/audio_button.dart';
import 'attachment_button.dart';
import 'audio_recorder.dart';
import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';
import 'send_button.dart';

/// A class that represents bottom bar widget with a text field, attachment and
/// send buttons inside. Hides send button when text field is empty.
class Input extends StatefulWidget {
  /// Creates [Input] widget
  const Input({
    Key? key,
    this.isAttachmentUploading,
    this.onAttachmentPressed,
    required this.onSendPressed,
    this.isAudioUploading,
    this.onAudioRecorded,
  }) : super(key: key);

  /// See [AttachmentButton.onPressed]
  final void Function()? onAttachmentPressed;

  /// Whether attachment is uploading. Will replace attachment button with a
  /// [CircularProgressIndicator]. Since we don't have libraries for
  /// managing media in dependencies we have no way of knowing if
  /// something is uploading so you need to set this manually.
  final bool? isAttachmentUploading;

  /// Will be called on [SendButton] tap. Has [types.PartialText] which can
  /// be transformed to [types.TextMessage] and added to the messages list.
  final void Function(types.PartialText) onSendPressed;

  /// See [AudioButton.onPressed]
  final Future<bool> Function({
    required Duration length,
    required String filePath,
    required List<double> waveForm,
  })? onAudioRecorded;

  /// Whether audio recording is uploading. Will replace audio button with a
  /// [CircularProgressIndicator]. Since we don't handle the upload of the audio
  /// we have no way of knowing if something is uploading so you need to set
  /// this manually.
  final bool? isAudioUploading;

  @override
  _InputState createState() => _InputState();
}

/// [Input] widget state
class _InputState extends State<Input> {
  final _audioRecorderKey = GlobalKey<AudioRecorderState>();
  final _textController = TextEditingController();
  bool _sendButtonVisible = false;
  bool _recordingAudio = false;

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

  Widget _leftWidget() {
    if (widget.isAttachmentUploading == true) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            InheritedChatTheme.of(context).theme.inputTextColor,
          ),
        ),
      );
    } else {
      return AttachmentButton(onPressed: widget.onAttachmentPressed);
    }
  }

  Widget _audioWidget() {
    if (widget.isAudioUploading == true) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            InheritedChatTheme.of(context).theme.inputTextColor,
          ),
        ),
      );
    } else {
      return AudioButton(
        onPressed: _toggleRecording,
        recordingAudio: _recordingAudio,
      );
    }
  }

  Future<void> _toggleRecording() async {
    if (!_recordingAudio) {
      setState(() {
        _recordingAudio = true;
      });
    } else {
      final audioRecording =
          await _audioRecorderKey.currentState!.stopRecording();
      if (audioRecording != null) {
        final success = await widget.onAudioRecorded!(
          length: audioRecording.duration,
          filePath: audioRecording.filePath,
          waveForm: audioRecording.decibelLevels,
        );
        if (success) {
          setState(() {
            _recordingAudio = false;
          });
        }
      }
    }
  }

  void _cancelRecording() async {
    setState(() {
      _recordingAudio = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Material(
      borderRadius: InheritedChatTheme.of(context).theme.inputBorderRadius,
      color: InheritedChatTheme.of(context).theme.inputBackgroundColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          24 + _query.padding.left,
          20,
          24 + _query.padding.right,
          20 + _query.viewInsets.bottom + _query.padding.bottom,
        ),
        child: Row(
          children: [
            if (widget.onAttachmentPressed != null && !_recordingAudio)
              _leftWidget(),
            Expanded(
              child: _recordingAudio
                  ? AudioRecorder(
                      key: _audioRecorderKey,
                      onCancelRecording: _cancelRecording,
                    )
                  : TextField(
                      controller: _textController,
                      decoration: InputDecoration.collapsed(
                        hintStyle:
                            InheritedChatTheme.of(context).theme.body1.copyWith(
                                  color: InheritedChatTheme.of(context)
                                      .theme
                                      .inputTextColor
                                      .withOpacity(0.5),
                                ),
                        hintText:
                            InheritedL10n.of(context).l10n.inputPlaceholder,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      style:
                          InheritedChatTheme.of(context).theme.body1.copyWith(
                                color: InheritedChatTheme.of(context)
                                    .theme
                                    .inputTextColor,
                              ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
            ),
            Visibility(
              visible: _sendButtonVisible,
              child: SendButton(
                onPressed: _handleSendPressed,
              ),
            ),
            Visibility(
              visible: widget.onAudioRecorded != null && !_sendButtonVisible,
              child: _audioWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
