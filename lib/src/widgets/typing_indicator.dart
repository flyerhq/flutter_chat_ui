import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../flutter_chat_ui.dart';
import 'inherited_chat_theme.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    required this.author,
    required this.bubbleAlignment,
  });

  /// Author(s) which will be showed for typing in chat. See [types.User].
  final List<types.User> author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment bubbleAlignment;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late AnimationController _animatedCirclesController;
  late Animation<double> _indicatorSpaceAnimation;
  late Animation<Offset> _firstCircleOffsetAnimation;
  late Animation<Offset> _secondCircleOffsetAnimation;
  late Animation<Offset> _thirdCircleOffsetAnimation;
  @override
  void initState() {
    super.initState();
    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        // Safe check.
        if (mounted) {
          setState(() {});
        }
      });
    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));
    _animatedCirclesController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 500),
    )
      ..repeat()
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _firstCircleOffsetAnimation = _firstCircleOffset();
    _secondCircleOffsetAnimation = _secondCircleOffset();
    _thirdCircleOffsetAnimation = _thirdCircleOffset();
    if (mounted) {
      _showIndicator();
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _animatedCirclesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _indicatorSpaceAnimation,
        builder: (context, child) => SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        ),
        child: Row(
          mainAxisAlignment: widget.bubbleAlignment == BubbleRtlAlignment.right
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            widget.bubbleAlignment == BubbleRtlAlignment.left
                ? Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      _multiUserTextBuilder(widget.author),
                      style: InheritedChatTheme.of(context)
                          .theme
                          .typingIndicatorTheme
                          .multipleUserTextStyle,
                    ),
                  )
                : Container(),
            Container(
              margin: widget.bubbleAlignment == BubbleRtlAlignment.right
                  ? const EdgeInsets.fromLTRB(24.0, 24.0, 0.0, 24.0)
                  : const EdgeInsets.fromLTRB(0.0, 24.0, 24.0, 24.0),
              decoration: BoxDecoration(
                borderRadius: InheritedChatTheme.of(context)
                    .theme
                    .typingIndicatorTheme
                    .bubbleBorder,
                color: InheritedChatTheme.of(context)
                    .theme
                    .typingIndicatorTheme
                    .bubbleColor,
              ),
              child: Wrap(
                spacing: 3.0,
                children: <Widget>[
                  AnimatedCircles(
                    circlesColor: InheritedChatTheme.of(context)
                        .theme
                        .typingIndicatorTheme
                        .animatedCirclesColor,
                    animationOffset: _firstCircleOffsetAnimation,
                  ),
                  AnimatedCircles(
                    circlesColor: InheritedChatTheme.of(context)
                        .theme
                        .typingIndicatorTheme
                        .animatedCirclesColor,
                    animationOffset: _secondCircleOffsetAnimation,
                  ),
                  AnimatedCircles(
                    circlesColor: InheritedChatTheme.of(context)
                        .theme
                        .typingIndicatorTheme
                        .animatedCirclesColor,
                    animationOffset: _thirdCircleOffsetAnimation,
                  ),
                ],
              ),
            ),
            widget.bubbleAlignment == BubbleRtlAlignment.right
                ? Container(
                    margin: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      _multiUserTextBuilder(widget.author),
                      style: InheritedChatTheme.of(context)
                          .theme
                          .typingIndicatorTheme
                          .multipleUserTextStyle,
                    ),
                  )
                : Container(),
          ],
        ),
      );

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 500)
      ..forward(from: 0.0);
  }

  Animation<Offset> _firstCircleOffset() => TweenSequence<Offset>(
        <TweenSequenceItem<Offset>>[
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -0.90),
            ),
            weight: 50.0,
          ),
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: const Offset(0.0, -0.90),
              end: Offset.zero,
            ),
            weight: 50.0,
          ),
        ],
      ).animate(CurvedAnimation(
        parent: _animatedCirclesController,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
        reverseCurve: const Interval(0.0, 1.0, curve: Curves.linear),
      ));

  Animation<Offset> _secondCircleOffset() => TweenSequence<Offset>(
        <TweenSequenceItem<Offset>>[
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -0.80),
            ),
            weight: 50.0,
          ),
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: const Offset(0.0, -0.80),
              end: Offset.zero,
            ),
            weight: 50.0,
          ),
        ],
      ).animate(CurvedAnimation(
        parent: _animatedCirclesController,
        curve: const Interval(0.30, 1.0, curve: Curves.linear),
        reverseCurve: const Interval(0.30, 1.0, curve: Curves.linear),
      ));

  Animation<Offset> _thirdCircleOffset() => TweenSequence<Offset>(
        <TweenSequenceItem<Offset>>[
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -0.90),
            ),
            weight: 50.0,
          ),
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: const Offset(0.0, -0.90),
              end: Offset.zero,
            ),
            weight: 50.0,
          ),
        ],
      ).animate(CurvedAnimation(
        parent: _animatedCirclesController,
        curve: const Interval(0.45, 1.0, curve: Curves.linear),
        reverseCurve: const Interval(0.45, 1.0, curve: Curves.linear),
      ));

  /// Handler for multi user typing.
  String _multiUserTextBuilder(List<types.User> author) {
    if (author.isEmpty) {
      return '';
    } else if (author.length == 1) {
      return '${author.first.firstName} is typing';
    } else if (author.length == 2) {
      return '${author.first.firstName} and ${author[1].firstName}';
    } else {
      return '${author.first.firstName} and ${author.length - 1} others';
    }
  }
}

class AnimatedCircles extends StatelessWidget {
  const AnimatedCircles({
    super.key,
    required this.circlesColor,
    required this.animationOffset,
  });

  final Color circlesColor;
  final Animation<Offset> animationOffset;
  @override
  Widget build(BuildContext context) => SlideTransition(
        position: animationOffset,
        child: Container(
          height: InheritedChatTheme.of(context)
              .theme
              .typingIndicatorTheme
              .animatedCircleSize,
          width: InheritedChatTheme.of(context)
              .theme
              .typingIndicatorTheme
              .animatedCircleSize,
          decoration: BoxDecoration(
            color: circlesColor,
            shape: BoxShape.circle,
          ),
        ),
      );
}

@immutable
class TypingIndicatorTheme {
  /// Defaults according to [DefaultChatTheme] and [DarkChatTheme].
  /// See [ChatTheme.typingIndicatorTheme] to customize your own.
  const TypingIndicatorTheme({
    required this.bubbleColor,
    required this.animatedCirclesColor,
    required this.bubbleBorder,
    required this.multipleUserTextStyle,
    required this.animatedCircleSize,
  });

  /// Bubble color for [TypingIndicator].
  final Color bubbleColor;

  /// Three Animated dots color for [TypingIndicator].
  final Color animatedCirclesColor;

  /// Bubble border for [TypingIndicator].
  final BorderRadius bubbleBorder;

  /// Multiple users text style for [TypingIndicator].
  final TextStyle multipleUserTextStyle;

  /// Animated Circle Size for [TypingIndicator].
  final double animatedCircleSize;
}
