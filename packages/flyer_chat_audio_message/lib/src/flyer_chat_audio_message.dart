import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_core/flutter_chat_core.dart';

class FlyerChatAudioMessage extends StatefulWidget {
  final AudioMessage message;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.message.audioFile));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
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
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _togglePlayPause,
            ),
            const Expanded(
              child: Text(
                'Audio Message',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
