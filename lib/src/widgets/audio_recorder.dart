import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'inherited_chat_theme.dart';

const maxSamples = 100;

class AudioRecording {
  const AudioRecording({
    required this.filePath,
    required this.duration,
    required this.decibelLevels,
  });

  final String filePath;
  final Duration duration;
  final List<double> decibelLevels;
}

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({
    Key? key,
    required this.onCancelRecording,
  }) : super(key: key);

  final void Function() onCancelRecording;

  @override
  AudioRecorderState createState() => AudioRecorderState();
}

class AudioRecorderState extends State<AudioRecorder> {
  final _audioRecorder = FlutterSoundRecorder();
  final _audioRecorderDurationFormat = DateFormat('mm:ss:SS', 'en_US');

  bool _audioRecorderReady = false;
  Duration _recordingDuration = const Duration();
  final List<double> _levels = [];

  @override
  void initState() {
    super.initState();
    _initAudioRecorder();
  }

  @override
  void dispose() async {
    super.dispose();
    if (_audioRecorder.isRecording) {
      await _audioRecorder.stopRecorder();
    }
    await _audioRecorder.closeAudioSession();
  }

  Future<void> _initAudioRecorder() async {
    await _audioRecorder.openAudioSession();
    await _audioRecorder.setSubscriptionDuration(
      const Duration(milliseconds: 10),
    );
    setState(() {
      _audioRecorderReady = true;
    });
    _startRecording();
  }

  /// Creates an path to a temporary file.
  Future<String> _tempFile({String? suffix}) async {
    suffix ??= 'tmp';

    if (!suffix.startsWith('.')) {
      suffix = '.$suffix';
    }

    const uuid = Uuid();
    String path;
    if (!kIsWeb) {
      final tmpDir = await getTemporaryDirectory();
      path = '${join(tmpDir.path, uuid.v4())}$suffix';
      final parent = dirname(path);
      await Directory(parent).create(recursive: true);
    } else {
      path = 'uuid.v4()}$suffix';
    }

    return path;
  }

  void _startRecording() async {
    final path = await _tempFile(suffix: '.aac');
    await _audioRecorder.startRecorder(
      toFile: path,
      bitRate: 32000,
      sampleRate: 32000,
    );
  }

  void _toggleRecording() async {
    if (_audioRecorder.isRecording) {
      await _audioRecorder.pauseRecorder();
      setState(() {});
    } else if (_audioRecorder.isPaused) {
      await _audioRecorder.resumeRecorder();
      setState(() {});
    }
  }

  Future<AudioRecording?> stopRecording() async {
    final fileName = await _audioRecorder.stopRecorder();
    if (fileName != null) {
      var groupedLevels = [..._levels];
      /*if (_levels.length > maxSamples) {
        groupedLevels = <double>[];
        final groupLevelsBy = (1.0 * _levels.length / maxSamples).ceil();
        for (var i = 0; i < _levels.length; i += groupLevelsBy) {
          var total = 0.0;
          var countSamples = 0;
          for (var j = i; j < _levels.length; j++) {
            total += _levels[j];
            countSamples++;
          }
          final average = total / countSamples;
          groupedLevels.add(average);
        }
      }*/

      return AudioRecording(
        filePath: fileName,
        duration: _recordingDuration,
        decibelLevels: groupedLevels,
      );
    } else {
      return null;
    }
  }

  Future<void> _cancelRecording() async {
    await _audioRecorder.stopRecorder();
    widget.onCancelRecording();
  }

  @override
  Widget build(BuildContext context) {
    return _audioRecorderReady
        ? StreamBuilder<RecordingDisposition>(
            stream: _audioRecorder.onProgress,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                const min = 24.0;
                final disposition = snapshot.data!;
                _recordingDuration = disposition.duration;
                _levels.add(disposition.decibels ?? 0.0);
                return Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          margin: const EdgeInsets.only(right: 16),
                          duration: const Duration(milliseconds: 10),
                          width: min + disposition.decibels! * 0.3,
                          height: min + disposition.decibels! * 0.3,
                          constraints: const BoxConstraints(
                            maxHeight: 40.0,
                            maxWidth: 40.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: InheritedChatTheme.of(context)
                                .theme
                                .recordColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 16),
                            child: IconButton(
                              icon: _audioRecorder.isRecording
                                  ? Icon(
                                      Icons.pause,
                                      color: InheritedChatTheme.of(context)
                                          .theme
                                          .inputTextColor,
                                    )
                                  : Icon(
                                      Icons.fiber_manual_record,
                                      color: InheritedChatTheme.of(context)
                                          .theme
                                          .recordColor,
                                    ),
                              onPressed: _toggleRecording,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                      ),
                      onPressed: _cancelRecording,
                      padding: EdgeInsets.zero,
                    ),
                    Expanded(
                      child: Text(
                        _audioRecorderDurationFormat.format(
                          DateTime.fromMillisecondsSinceEpoch(
                            snapshot.data!.duration.inMilliseconds,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style:
                            InheritedChatTheme.of(context).theme.body1.copyWith(
                                  color: InheritedChatTheme.of(context)
                                      .theme
                                      .inputTextColor,
                                ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        : Container();
  }
}
