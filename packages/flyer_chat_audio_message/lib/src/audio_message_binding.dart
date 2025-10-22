
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'utils_repo.dart';

Source _getAudioSource(String audioUri) => isNetworkSource(audioUri) ? UrlSource(audioUri) : DeviceFileSource(audioUri);

/// The audio source model to related [AudioMessage] with messageId
class AudioMessageSourceModel {

  /// The audio related msg's id
  final String messageId;

  /// Audio source
  final Source audioSource;

  AudioMessageSourceModel({required this.messageId, required this.audioSource});

  factory AudioMessageSourceModel.fromMsg(AudioMessage msg) {
    final audioSource = _getAudioSource(msg.source);
    return AudioMessageSourceModel(messageId: msg.id, audioSource: audioSource);
  }

}

/// AudioMessage's event baseclass
/// * All event will relate with message through [messageId]
sealed class AudioMessageEvent {

  final String messageId;

  AudioMessageEvent({required this.messageId});
}

/// Audio player state event.
class AudioPlayerStateEvent extends AudioMessageEvent {

  /// The state of [AudioPlayer]
  final PlayerState state;

  AudioPlayerStateEvent({required super.messageId, required this.state});

}

/// A binding-class that help handle [AudioMessage]
mixin AudioMessageBinding on ChatController {

  /// Dispatch the [AudioMessageBinding]'s event
  /// * also see [AudioMessageEvent]
  final _msgAudioEventStreamController = StreamController<AudioMessageEvent>.broadcast();

  /// Listen [AudioMessageBinding]'s event by this stream.
  /// * also see [AudioMessageEvent]
  Stream<AudioMessageEvent> get msgAudioEventStream => _msgAudioEventStreamController.stream;

  /// For play audio from [AudioMessage]
  late final AudioPlayer _audioPlayer = AudioPlayer()..onPlayerStateChanged.listen((state) {
    final msgId = _currentPlayingSourceModel?.messageId ?? '';
    if(msgId.isNotEmpty) {
      _msgAudioEventStreamController.add(AudioPlayerStateEvent(messageId: msgId, state: state));
    }
    if(state == PlayerState.completed || state == PlayerState.stopped) {
      _currentPlayingSourceModel = null;
    }
  });

  bool get isPlaying => _audioPlayer.state == PlayerState.playing;

  /// The message that current handling.
  AudioMessageSourceModel? _currentPlayingSourceModel;
  AudioMessageSourceModel? get currentPlayingSourceModel => _currentPlayingSourceModel;

  bool isHandleCurrentMsg(AudioMessage msg) => currentPlayingSourceModel?.messageId == msg.id;

  /// Play a audio message
  /// * Only play one audio message in one time. It will stop play first when some other message are playing.
  /// * Other params see [AudioPlayer]
  Future<void> playAudioMsg(AudioMessage msg, {
    double? volume,
    double? balance,
    AudioContext? ctx,
    Duration? position,
    PlayerMode? mode,
  }) async {
    if(_currentPlayingSourceModel != null) {
      await stopAudioMsg();
    }
    _currentPlayingSourceModel = AudioMessageSourceModel.fromMsg(msg);
    await _audioPlayer.play(_currentPlayingSourceModel!.audioSource,
      volume: volume, balance: balance, ctx: ctx, position: position, mode: mode);
  }

  /// Stop current played message
  Future<void> stopAudioMsg() async {
    await _audioPlayer.stop();
    _currentPlayingSourceModel = null;
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _msgAudioEventStreamController.close();
    super.dispose();
  }

}







