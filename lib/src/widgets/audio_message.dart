import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/wave_form.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';
import 'inherited_user.dart';

/// A class that represents audio message widget
class AudioMessage extends StatefulWidget {
  /// Creates an audio message widget based on a [types.AudioMessage]
  const AudioMessage({
    Key? key,
    required this.message,
    required this.messageWidth,
  }) : super(key: key);

  static final durationFormat = DateFormat('m:ss', 'en_US');

  /// [types.AudioMessage]
  final types.AudioMessage message;

  /// Maximum message width
  final int messageWidth;

  @override
  _AudioMessageState createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  final _audioPlayer = FlutterSoundPlayer();

  bool _playing = false;
  bool _audioPlayerReady = false;
  bool _wasPlayingBeforeSeeking = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.close();
    super.dispose();
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.openPlayer();
    setState(() {
      _audioPlayerReady = true;
    });
  }

  Future<void> _togglePlaying() async {
    if (!_audioPlayerReady) return;
    if (_playing) {
      await _audioPlayer.pausePlayer();
      setState(() {
        _playing = false;
      });
    } else if (_audioPlayer.isPaused) {
      await _audioPlayer.resumePlayer();
      setState(() {
        _playing = true;
      });
    } else {
      await _audioPlayer.setSubscriptionDuration(
        const Duration(milliseconds: 10),
      );
      await _audioPlayer.startPlayer(
          fromURI: widget.message.uri,
          whenFinished: () {
            setState(() {
              _playing = false;
            });
          });
      setState(() {
        _playing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _color = _user.id == widget.message.authorId
        ? InheritedChatTheme.of(context).theme.primaryTextColor
        : InheritedChatTheme.of(context).theme.primaryColor;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            tooltip: _audioPlayer.isPlaying
                ? InheritedL10n.of(context).l10n.pauseButtonAccessibilityLabel
                : InheritedL10n.of(context).l10n.playButtonAccessibilityLabel,
            padding: EdgeInsets.zero,
            onPressed: _audioPlayerReady ? _togglePlaying : null,
            icon: _playing
                ? (InheritedChatTheme.of(context).theme.pauseButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.pauseButtonIcon!,
                        color: _color,
                      )
                    : Icon(
                        Icons.pause_circle_filled,
                        color: _color,
                        size: 44,
                      ))
                : (InheritedChatTheme.of(context).theme.playButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.playButtonIcon!,
                        color: _color,
                      )
                    : Icon(
                        Icons.play_circle_fill,
                        color: _color,
                        size: 44,
                      )),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: widget.messageWidth.toDouble(),
                    height: 20,
                    child: _audioPlayer.isPlaying || _audioPlayer.isPaused
                        ? StreamBuilder<PlaybackDisposition>(
                            stream: _audioPlayer.onProgress,
                            builder: (context, snapshot) {
                              return WaveForm(
                                accessibilityLabel: InheritedL10n.of(context)
                                    .l10n
                                    .audioTrackAccessibilityLabel,
                                onTap: _togglePlaying,
                                onStartSeeking: () async {
                                  _wasPlayingBeforeSeeking =
                                      _audioPlayer.isPlaying;
                                  if (_audioPlayer.isPlaying) {
                                    await _audioPlayer.pausePlayer();
                                  }
                                },
                                onSeek: snapshot.hasData
                                    ? (newPosition) async {
                                        print(newPosition.toString());
                                        await _audioPlayer
                                            .seekToPlayer(newPosition);
                                        if (_wasPlayingBeforeSeeking) {
                                          await _audioPlayer.resumePlayer();
                                          _wasPlayingBeforeSeeking = false;
                                        }
                                      }
                                    : null,
                                waveForm: widget.message.waveForm,
                                color: _user.id == widget.message.authorId
                                    ? InheritedChatTheme.of(context)
                                        .theme
                                        .primaryTextColor
                                    : InheritedChatTheme.of(context)
                                        .theme
                                        .secondaryTextColor,
                                duration: snapshot.hasData
                                    ? snapshot.data!.duration
                                    : widget.message.length,
                                position: snapshot.hasData
                                    ? snapshot.data!.position
                                    : const Duration(),
                              );
                            })
                        : WaveForm(
                            accessibilityLabel: InheritedL10n.of(context)
                                .l10n
                                .audioTrackAccessibilityLabel,
                            onTap: _togglePlaying,
                            waveForm: widget.message.waveForm,
                            color: _user.id == widget.message.authorId
                                ? InheritedChatTheme.of(context)
                                    .theme
                                    .primaryTextColor
                                : InheritedChatTheme.of(context)
                                    .theme
                                    .secondaryTextColor,
                            duration: widget.message.length,
                            position: const Duration(),
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (_audioPlayer.isPlaying || _audioPlayer.isPaused)
                    StreamBuilder<PlaybackDisposition>(
                        stream: _audioPlayer.onProgress,
                        builder: (context, snapshot) {
                          return Text(
                            AudioMessage.durationFormat.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                snapshot.hasData
                                    ? snapshot.data!.duration.inMilliseconds -
                                        snapshot.data!.position.inMilliseconds
                                    : widget.message.length.inMilliseconds,
                                isUtc: true,
                              ),
                            ),
                            style: InheritedChatTheme.of(context)
                                .theme
                                .caption
                                .copyWith(
                                  color: _user.id == widget.message.authorId
                                      ? InheritedChatTheme.of(context)
                                          .theme
                                          .primaryTextColor
                                      : InheritedChatTheme.of(context)
                                          .theme
                                          .secondaryTextColor,
                                ),
                            textWidthBasis: TextWidthBasis.longestLine,
                          );
                        })
                  else
                    Text(
                      AudioMessage.durationFormat.format(
                        DateTime.fromMillisecondsSinceEpoch(
                          widget.message.length.inMilliseconds,
                          isUtc: true,
                        ),
                      ),
                      style:
                          InheritedChatTheme.of(context).theme.caption.copyWith(
                                color: _user.id == widget.message.authorId
                                    ? InheritedChatTheme.of(context)
                                        .theme
                                        .primaryTextColor
                                    : InheritedChatTheme.of(context)
                                        .theme
                                        .secondaryTextColor,
                              ),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
