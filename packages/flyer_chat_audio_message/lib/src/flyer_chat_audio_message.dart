import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

/// A widget that displays an audio message with play/pause functionality.
class FlyerChatAudioMessage extends StatefulWidget {
  /// The audio message to be played.
  final AudioMessage message;

  /// The border radius of the audio message container.
  final BorderRadiusGeometry? borderRadius;

  /// The constraints for the audio message container.
  final BoxConstraints? constraints;

  /// Creates a [FlyerChatAudioMessage] widget.
  const FlyerChatAudioMessage({
    super.key,
    required this.message,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.constraints = const BoxConstraints(maxWidth: 300, minHeight: 50),
  });

  @override
  FlyerChatAudioMessageState createState() => FlyerChatAudioMessageState();
}

class FlyerChatAudioMessageState extends State<FlyerChatAudioMessage> {
  late final AudioPlayer _player;
  PlayerState? _playerState;
  Duration? _currentPosition;
  Duration? _totalDuration;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setReleaseMode(ReleaseMode.stop);
    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _player.pause();
      } else {
        await _player.setSource(AssetSource(widget.message.audioFile));
        await _player.resume();
      }
    } on AudioPlayerException catch (e) {
      _showErrorDialog('Audio Player Error', e.toString());
    } catch (e) {
      _showErrorDialog('Error', 'An unexpected error occurred. $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Container(
        constraints: widget.constraints,
        color: Colors.grey[200],
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 32,
              ),
              onPressed: _togglePlayPause,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Slider(
                    value: _currentPosition?.inSeconds.toDouble() ?? 0.0,
                    max: _totalDuration?.inSeconds.toDouble() ?? 1.0,
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await _player.seek(position);
                      setState(() {
                        _currentPosition = position;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initStreams() {
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      setState(() => _totalDuration = duration);
    });

    _positionSubscription = _player.onPositionChanged.listen((position) {
      setState(() => _currentPosition = position);
    });

    _playerCompleteSubscription = _player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _currentPosition = Duration.zero;
      });
    });

    _playerStateChangeSubscription = _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }
}
