
import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'audio_message_binding.dart';

/// Theme values for [FlyerChatAudioMessage].
typedef _LocalTheme = ({
      TextStyle bodyMedium,
      TextStyle bodySmall,
      TextStyle labelSmall,
      Color onPrimary,
      Color onSurface,
      Color primary,
      BorderRadiusGeometry shape,
      Color surfaceContainer,
    });

/// The widget that show audio message
///
/// * Show audio's duration and a play animation
class FlyerChatAudioMessage extends StatefulWidget {

  /// The audio message data model.
  final AudioMessage message;

  /// Padding around the message bubble content.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the message bubble.
  final BorderRadiusGeometry? borderRadius;

  /// Gap between the audio-wave and the duration text.
  final double gap;

  /// Background color for messages sent by the current user.
  final Color? sentBackgroundColor;

  /// Background color for messages received from other users.
  final Color? receivedBackgroundColor;

  /// Text style for the audio duration in messages sent by the current user.
  final TextStyle? sentDurationTextStyle;

  /// Text style for the audio duration in messages received from other users.
  final TextStyle? receivedDurationTextStyle;

  /// Text style for the message timestamp and status.
  final TextStyle? timeStyle;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the text content.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// The widget to display on top of the message.
  final Widget? topWidget;

  /// The audio waveform's area size
  /// * These are the dimensions of the rectangle, one-fourth of which will be used to draw the sector.
  final Size? waveRectSize;

  /// The audio waveform color
  final Color waveColor;

  /// The audio waveform width
  final double waveWidth;

  /// The audio wave one,two,three's animation duration
  final int audioWaveAnimationDuration;

  const FlyerChatAudioMessage({super.key, required this.message,
    this.padding,
    this.borderRadius,
    this.gap = 0,
    this.sentBackgroundColor,
    this.receivedBackgroundColor,
    this.sentDurationTextStyle,
    this.receivedDurationTextStyle,
    this.timeStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.topWidget,
    this.waveRectSize,
    this.waveColor = Colors.black,
    this.waveWidth = 1.5,
    this.audioWaveAnimationDuration = 1500
  });

  @override
  State<StatefulWidget> createState() => _FlyerChatAudioMessageState();
}

const _showAllWave = 0.8;


class _FlyerChatAudioMessageState extends State<FlyerChatAudioMessage> with SingleTickerProviderStateMixin {

  late final ChatController _chatController;

  AudioMessageBinding get _audioBinding => _chatController as AudioMessageBinding;

  bool get showTime => widget.showTime;

  bool get showStatus => widget.showTime;

  AudioMessage get message => widget.message;

  StreamSubscription? _audioEventSubscription;

  late final AnimationController _animationController;

  void _listenAnimationStatus(AnimationStatus status) {
    if(!mounted) return;
    if(status == AnimationStatus.completed) {
      if(_audioBinding.isPlaying) {
        _animationController.repeat();
      } else {
        _stopWaveAnimation();
      }
    }
  }

  void _stopWaveAnimation() {
    _animationController.stop();
    _animationController.value = _showAllWave;
  }

  void _msgPlayEventListener(AudioMessageEvent event) {
    if(event.messageId != message.id) return;
    switch(event) {
      case AudioPlayerStateEvent():
        if(event.state == PlayerState.playing) {
          if(!_animationController.isAnimating) {
            _animationController.forward(from: 0);
          }
        } else {
          _stopWaveAnimation();
        }
    }
  }

  @override
  void initState() {
    super.initState();
    _chatController = context.read<ChatController>();
    assert(_chatController is AudioMessageBinding, 'FlyerChatAudioMessage need ChatController had with AudioMessageBinding');
    _audioEventSubscription = _audioBinding.msgAudioEventStream.listen(_msgPlayEventListener);

    _animationController = AnimationController(vsync: this,
      duration: Duration(milliseconds: widget.audioWaveAnimationDuration),
      value: _showAllWave,
    );
    _animationController.addStatusListener(_listenAnimationStatus);
  }


  @override
  void dispose() {
    unawaited(_audioEventSubscription?.cancel());
    _animationController.removeStatusListener(_listenAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final theme = context.select(
          (ChatTheme t) => (
      bodyMedium: t.typography.bodyMedium,
      bodySmall: t.typography.bodySmall,
      labelSmall: t.typography.labelSmall,
      onPrimary: t.colors.onPrimary,
      onSurface: t.colors.onSurface,
      primary: t.colors.primary,
      shape: t.shape,
      surfaceContainer: t.colors.surfaceContainer,
      ),
    );
    final isSentByMe = context.read<UserID>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final durationTextStyle = _resolveDurationTextStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus =
    showTime || (isSentByMe && showStatus)
        ? TimeAndStatus(
      time: message.resolvedTime,
      status: message.resolvedStatus,
      showTime: showTime,
      showStatus: isSentByMe && showStatus,
      textStyle: timeStyle,
    )
        : null;

    final durationContent = Text(
      _formatAudioDuration(message.duration),
      style: durationTextStyle,
    );

    final waveSize = widget.waveRectSize ?? Size(24, 24);

    var audioContentChildren = <Widget>[
      Transform.rotate(
        angle: isSentByMe ? pi : 0,
        child: SizedBox(
          width: waveSize.width, height: waveSize.height,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, child) {
                final progress = _animationController.value * 3;
                return CustomPaint(
                  painter: _WavePainter(waveNumbers: progress.toInt(), waveColor: widget.waveColor, waveWidth: widget.waveWidth),
                );
              }),
        ),
      ),
      durationContent
    ];

    if(isSentByMe) {
      audioContentChildren = audioContentChildren.reversed.toList();
    }

    if(!(timeAndStatus == null || widget.timeAndStatusPosition != TimeAndStatusPosition.inline)) {
      audioContentChildren.addAll([const SizedBox(width: 4), timeAndStatus]);
    }

    final audioContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: audioContentChildren,
    );

    return GestureDetector(
      onTap: () {
        if(_audioBinding.isHandleCurrentMsg(message)) {
          if(_audioBinding.isPlaying) {
            _audioBinding.stopAudioMsg();
          }
        } else {
          _audioBinding.playAudioMsg(message);
        }
      },
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: widget.borderRadius ?? theme.shape,
        ),
        child: _buildContentBasedOnPosition(
          context: context,
          audioContent: audioContent,
          timeAndStatus: timeAndStatus,
          textStyle: durationTextStyle,
        ),
      ),
    );
  }

  Widget _buildContentBasedOnPosition({
    required BuildContext context,
    required Widget audioContent,
    required TimeAndStatus? timeAndStatus,
    required TextStyle? textStyle,
  }) {
    final textDirection = Directionality.of(context);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.topWidget != null) widget.topWidget!,
            // In comparison to other messages types, if timeAndStatusPosition is inline,
            // the audioContent is already a Row with the timeAndStatus widget inside it.
            audioContent,
            if (widget.timeAndStatusPosition != TimeAndStatusPosition.inline)
            // Ensure the width is not smaller than the timeAndStatus widget
            // Ensure the height accounts for it's height
              Opacity(opacity: 0, child: timeAndStatus),
          ],
        ),
        if (widget.timeAndStatusPosition != TimeAndStatusPosition.inline &&
            timeAndStatus != null)
          Positioned.directional(
            textDirection: textDirection,
            end: widget.timeAndStatusPosition == TimeAndStatusPosition.end ? 0 : null,
            start: widget.timeAndStatusPosition == TimeAndStatusPosition.start ? 0 : null,
            bottom: 0,
            child: timeAndStatus,
          ),
      ],
    );
  }

  String _formatAudioDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    final buffer = StringBuffer();

    if (h > 0) buffer.write('$h°');
    if (m > 0) buffer.write('$m′');
    if (s > 0 || buffer.isEmpty) buffer.write('$s″');

    return buffer.toString();
  }


  Color? _resolveBackgroundColor(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return widget.sentBackgroundColor ?? theme.primary;
    }
    return widget.receivedBackgroundColor ?? theme.surfaceContainer;
  }

  TextStyle? _resolveDurationTextStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return widget.sentDurationTextStyle ??
          theme.bodySmall.copyWith(
            color: theme.onPrimary.withValues(alpha: 0.8),
          );
    }
    return widget.receivedDurationTextStyle ??
        theme.bodySmall.copyWith(color: theme.onSurface.withValues(alpha: 0.8));
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, _LocalTheme theme) {
    final color = isSentByMe ? theme.onPrimary : theme.onSurface;

    return widget.timeStyle ?? theme.labelSmall.copyWith(color: color);
  }

}


class _WavePainter extends CustomPainter {

  final int waveNumbers;

  final Color waveColor;
  
  final double waveWidth;

  _WavePainter({super.repaint, required this.waveNumbers, required this.waveColor, required this.waveWidth});

  @override
  void paint(Canvas canvas, Size size) {

    final wavePaint = Paint()
      ..color = waveColor
      ..strokeWidth = waveWidth
      ..style = PaintingStyle.stroke;

    final sectorLeftTop = Offset(-size.width / 2, 0);
    final outerRect = Rect.fromLTWH(sectorLeftTop.dx, sectorLeftTop.dy, size.width, size.height);

    const startAngle = -pi / 4;
    const sweepAngle = pi / 2;

    if(waveNumbers > 1) {
      canvas.drawArc(outerRect, startAngle, sweepAngle, false, wavePaint);
    }

    final middleRect = outerRect.deflate(4);
    if(waveNumbers > 0) {
      canvas.drawArc(middleRect, startAngle, sweepAngle, false, wavePaint);
    }

    final innerRect = middleRect.deflate(3.5);
    wavePaint.style = PaintingStyle.fill;
    canvas.drawArc(innerRect, startAngle, sweepAngle, true, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !(oldDelegate is _WavePainter 
        && oldDelegate.waveNumbers == waveNumbers 
        && oldDelegate.waveColor == waveColor);
  }

}



/// A widget to display the message timestamp and status indicator.
class TimeAndStatus extends StatelessWidget {
  /// The time the message was created.
  final DateTime? time;

  /// The status of the message.
  final MessageStatus? status;

  /// Whether to display the timestamp.
  final bool showTime;

  /// Whether to display the status indicator.
  final bool showStatus;

  /// The text style for the time and status.
  final TextStyle? textStyle;

  /// Creates a widget for displaying time and status.
  const TimeAndStatus({
    super.key,
    required this.time,
    this.status,
    this.showTime = true,
    this.showStatus = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = context.watch<DateFormat>();

    return Row(
      spacing: 2,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTime && time != null)
          Text(timeFormat.format(time!.toLocal()), style: textStyle),
        if (showStatus && status != null)
          if (status == MessageStatus.sending)
            SizedBox(
              width: 6,
              height: 6,
              child: CircularProgressIndicator(
                color: textStyle?.color,
                strokeWidth: 2,
              ),
            )
          else
            Icon(getIconForStatus(status!), color: textStyle?.color, size: 12),
      ],
    );
  }
}

















