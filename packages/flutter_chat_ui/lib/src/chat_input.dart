import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import './wave_animation.dart';
import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

/// A widget that provides a chat input interface with text, attachment, and audio recording capabilities.
class ChatInput extends StatefulWidget {
  /// The left position of the chat input.
  final double? left;

  /// The right position of the chat input.
  final double? right;

  /// The top position of the chat input.
  final double? top;

  /// The bottom position of the chat input.
  final double? bottom;

  /// The horizontal blur radius for the backdrop filter.
  final double? sigmaX;

  /// The vertical blur radius for the backdrop filter.
  final double? sigmaY;

  /// The padding around the chat input.
  final EdgeInsetsGeometry? padding;

  /// The icon for attachments.
  final Widget? attachmentIcon;

  /// The icon for sending messages.
  final Widget? sendIcon;

  /// The icon for audio recording.
  final Widget? audioIcon;

  /// The gap between elements in the chat input.
  final double? gap;

  /// The border for the text input field.
  final InputBorder? inputBorder;

  /// Whether the text input field is filled.
  final bool? filled;

  /// Creates a [ChatInput] widget.
  const ChatInput({
    super.key,
    this.left = 0,
    this.right = 0,
    this.top,
    this.bottom = 0,
    this.sigmaX = 20,
    this.sigmaY = 20,
    this.padding = const EdgeInsets.all(8.0),
    this.attachmentIcon = const Icon(Icons.attachment),
    this.sendIcon = const Icon(Icons.send),
    this.audioIcon = const Icon(Icons.mic),
    this.gap = 8,
    this.inputBorder = const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    this.filled = true,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final GlobalKey _inputKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordedAudioPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateInputHeight());
  }

  @override
  void dispose() {
    _textController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.select((ChatTheme theme) => theme.backgroundColor);
    final inputTheme = context.select((ChatTheme theme) => theme.inputTheme);

    final onAttachmentTap = context.read<OnAttachmentTapCallback?>();

    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.sigmaX ?? 0,
            sigmaY: widget.sigmaY ?? 0,
          ),
          child: Container(
            key: _inputKey,
            color: backgroundColor.withOpacity(0.8),
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  if (widget.attachmentIcon != null && !_isRecording)
                    IconButton(
                      icon: widget.attachmentIcon!,
                      color: inputTheme.hintStyle?.color,
                      onPressed: onAttachmentTap,
                    ),
                  if (!_isRecording) SizedBox(width: widget.gap),
                  Expanded(
                    child: _isRecording
                        ? _buildRecordingIndicator()
                        : TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              hintStyle: inputTheme.hintStyle,
                              border: widget.inputBorder,
                              filled: widget.filled,
                              fillColor: inputTheme.backgroundColor,
                              hoverColor: Colors.transparent,
                            ),
                            style: inputTheme.textStyle,
                            onSubmitted: _handleSubmitted,
                            textInputAction: TextInputAction.send,
                          ),
                  ),
                  SizedBox(width: widget.gap),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _textController,
                    builder: (context, value, child) {
                      return widget.sendIcon != null
                          ? Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: value.text.isNotEmpty || _isRecording ? widget.sendIcon! : widget.audioIcon!,
                                color: inputTheme.hintStyle?.color,
                                onPressed: () async {
                                  if (_isRecording) {
                                    _handleAudioSubmitted();
                                  } else if (value.text.isEmpty) {
                                    await _handleRecordAudio();
                                  } else {
                                    _handleSubmitted(value.text);
                                  }
                                },
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    final streamAmplitude = _audioRecorder.onAmplitudeChanged(const Duration(seconds: 1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.circle, color: Colors.red),
        const SizedBox(width: 8),
        StreamBuilder<Duration>(
          stream: Stream.periodic(
            const Duration(seconds: 1),
            (count) => Duration(seconds: count),
          ),
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
            final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
            return Row(
              children: [
                Text(
                  '$minutes:$seconds',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                StreamBuilder<Amplitude>(
                  stream: streamAmplitude,
                  builder: (context, snapshot) {
                    final current = snapshot.data?.current ?? 0.0;
                    final max = snapshot.data?.max ?? 0.0;
                    final audioLevel = (current / max).clamp(0.0, 1.0);

                    developer.log('current: $current', name: 'ChatInput');
                    developer.log('max: $max', name: 'ChatInput');
                    developer.log('audioLevel: $audioLevel', name: 'ChatInput');

                    return BarAnimation(
                      color: Colors.red,
                      audioLevel: audioLevel,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _updateInputHeight() {
    final renderBox = _inputKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      context.read<ChatInputHeightNotifier>().updateHeight(renderBox.size.height);
    }
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      context.read<OnMessageSendCallback?>()?.call(text);
      _textController.clear();
    }
  }

  void _handleAudioSubmitted() {
    _audioRecorder.stop();
    setState(() {
      _isRecording = false;
    });

    if (_recordedAudioPath!.isNotEmpty) {
      final audioFile = File(_recordedAudioPath!);
      context.read<OnAudioSendCallback?>()?.call(audioFile);
      _resetAudioState();
    }
  }

  Future<void> _handleRecordAudio() async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();

      if (hasPermission) {
        setState(() {
          _isRecording = true;
        });

        _recordedAudioPath = 'audio.m4a';

        await _audioRecorder.start(
          const RecordConfig(),
          path: _recordedAudioPath!,
        );
      }
    } catch (e) {
      debugPrint('Error during audio recording: $e');
    }
  }

  void _resetAudioState() {
    setState(() {
      _recordedAudioPath = null;
    });
  }
}
