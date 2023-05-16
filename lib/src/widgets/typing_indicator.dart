import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../flutter_chat_ui.dart';
import '../util.dart';
import 'state/inherited_chat_theme.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    required this.bubbleAlignment,
    this.options = const TypingIndicatorOptions(),
    required this.showIndicator,
  });

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment bubbleAlignment;

  /// See [TypingIndicatorOptions].
  final TypingIndicatorOptions options;

  /// Used to hide indicator when the [options.typingUsers] is empty.
  final bool showIndicator;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late double stackingWidth;
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
      duration: const Duration(milliseconds: 500),
    );

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
      duration: widget.options.animationSpeed,
    )..repeat();

    _firstCircleOffsetAnimation = _circleOffset(
      Offset.zero,
      const Offset(0.0, -0.9),
      const Interval(0.0, 1.0, curve: Curves.linear),
    );
    _secondCircleOffsetAnimation = _circleOffset(
      Offset.zero,
      const Offset(0.0, -0.8),
      const Interval(0.3, 1.0, curve: Curves.linear),
    );
    _thirdCircleOffsetAnimation = _circleOffset(
      Offset.zero,
      const Offset(0.0, -0.9),
      const Interval(0.45, 1.0, curve: Curves.linear),
    );

    if (widget.showIndicator) {
      _appearanceController.forward();
    }
  }

  /// Handler for circles offset.
  Animation<Offset> _circleOffset(
    Offset? start,
    Offset? end,
    Interval animationInterval,
  ) =>
      TweenSequence<Offset>(
        <TweenSequenceItem<Offset>>[
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: start,
              end: end,
            ),
            weight: 50.0,
          ),
          TweenSequenceItem<Offset>(
            tween: Tween<Offset>(
              begin: end,
              end: start,
            ),
            weight: 50.0,
          ),
        ],
      ).animate(CurvedAnimation(
        parent: _animatedCirclesController,
        curve: animationInterval,
        reverseCurve: animationInterval,
      ));

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _appearanceController.forward();
      } else {
        _appearanceController.reverse();
      }
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
          children: <Widget>[
            widget.bubbleAlignment == BubbleRtlAlignment.left
                ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: TypingWidget(
                      widget: widget,
                      context: context,
                      mode: widget.options.typingMode,
                    ),
                  )
                : const SizedBox(),
            Container(
              margin: widget.bubbleAlignment == BubbleRtlAlignment.right
                  ? const EdgeInsets.fromLTRB(24, 24, 0, 24)
                  : const EdgeInsets.fromLTRB(0, 24, 24, 24),
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
                    margin: const EdgeInsets.only(left: 12),
                    child: TypingWidget(
                      widget: widget,
                      context: context,
                      mode: widget.options.typingMode,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );
}

/// Typing Widget.
class TypingWidget extends StatelessWidget {
  const TypingWidget({
    super.key,
    required this.widget,
    required this.context,
    required this.mode,
  });

  final TypingIndicator widget;
  final BuildContext context;
  final TypingIndicatorMode mode;

  /// Handler for multi user typing text.
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

  /// Used to specify width of stacking avatars based on number of authors.
  double _getStackingWidth(List<types.User> author, double indicatorWidth) {
    if (author.length == 1) {
      return indicatorWidth * 0.06;
    } else if (author.length == 2) {
      return indicatorWidth * 0.11;
    } else {
      return indicatorWidth * 0.15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = _getStackingWidth(
      widget.options.typingUsers,
      MediaQuery.of(context).size.width,
    );
    if (mode == TypingIndicatorMode.name) {
      return SizedBox(
        child: Text(
          _multiUserTextBuilder(widget.options.typingUsers),
          style: InheritedChatTheme.of(context)
              .theme
              .typingIndicatorTheme
              .multipleUserTextStyle,
        ),
      );
    } else if (mode == TypingIndicatorMode.avatar) {
      return SizedBox(
        width: sWidth,
        child: AvatarHandler(
          context: context,
          author: widget.options.typingUsers,
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          SizedBox(
            width: sWidth,
            child: AvatarHandler(
              context: context,
              author: widget.options.typingUsers,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _multiUserTextBuilder(widget.options.typingUsers),
            style: InheritedChatTheme.of(context)
                .theme
                .typingIndicatorTheme
                .multipleUserTextStyle,
          ),
        ],
      );
    }
  }
}

/// Multi Avatar Handler Widget.
class AvatarHandler extends StatelessWidget {
  const AvatarHandler({
    super.key,
    required this.context,
    required this.author,
  });

  final BuildContext context;
  final List<types.User> author;

  @override
  Widget build(BuildContext context) {
    if (author.isEmpty) {
      return const SizedBox();
    } else if (author.length == 1) {
      return Align(
        alignment: Alignment.centerLeft,
        child: TypingAvatar(context: context, author: author.first),
      );
    } else if (author.length == 2) {
      return Stack(
        children: <Widget>[
          TypingAvatar(context: context, author: author.first),
          Positioned(
            left: 16,
            child: TypingAvatar(context: context, author: author[1]),
          ),
        ],
      );
    } else {
      return SizedBox(
        child: Stack(
          children: <Widget>[
            TypingAvatar(context: context, author: author.first),
            Positioned(
              left: 16,
              child: TypingAvatar(context: context, author: author[1]),
            ),
            Positioned(
              left: 32,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: InheritedChatTheme.of(context)
                    .theme
                    .typingIndicatorTheme
                    .countAvatarColor,
                child: Text(
                  '${author.length - 2}',
                  style: TextStyle(
                    color: InheritedChatTheme.of(context)
                        .theme
                        .typingIndicatorTheme
                        .countTextColor,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 0.7,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

// Typing avatar Widget.
class TypingAvatar extends StatelessWidget {
  const TypingAvatar({
    super.key,
    required this.context,
    required this.author,
  });

  final BuildContext context;
  final types.User author;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);

    return CircleAvatar(
      backgroundColor: hasImage
          ? InheritedChatTheme.of(context).theme.userAvatarImageBackgroundColor
          : color,
      backgroundImage: hasImage ? NetworkImage(author.imageUrl!) : null,
      radius: 13,
      child: !hasImage
          ? Text(
              initials,
              style: InheritedChatTheme.of(context).theme.userAvatarTextStyle,
              textScaleFactor: 0.7,
            )
          : null,
    );
  }
}

/// Animated Circles Widget.
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
class TypingIndicatorOptions {
  const TypingIndicatorOptions({
    this.animationSpeed = const Duration(milliseconds: 500),
    this.customTypingIndicator,
    this.typingMode = TypingIndicatorMode.name,
    this.typingUsers = const [],
  });

  /// Animation speed for circles.
  /// Defaults to 500 ms.
  final Duration animationSpeed;

  /// Allows to set custom [TypingIndicator].
  final Widget? customTypingIndicator;

  /// Typing mode for [TypingIndicator]. See [TypingIndicatorMode].
  final TypingIndicatorMode typingMode;

  /// Author(s) for [TypingIndicator].
  /// By default its empty list which hides the indicator, see [types.User].
  final List<types.User> typingUsers;
}

@immutable
class TypingIndicatorTheme {
  /// Defaults according to [DefaultChatTheme] and [DarkChatTheme].
  /// See [ChatTheme.typingIndicatorTheme] to customize your own.
  const TypingIndicatorTheme({
    required this.animatedCirclesColor,
    required this.animatedCircleSize,
    required this.bubbleBorder,
    required this.bubbleColor,
    required this.countAvatarColor,
    required this.countTextColor,
    required this.multipleUserTextStyle,
  });

  /// Three Animated dots color for [TypingIndicator].
  final Color animatedCirclesColor;

  /// Animated Circle Size for [TypingIndicator].
  final double animatedCircleSize;

  /// Bubble border for [TypingIndicator].
  final BorderRadius bubbleBorder;

  /// Bubble color for [TypingIndicator].
  final Color bubbleColor;

  /// Count Avatar color for [TypingIndicator].
  final Color countAvatarColor;

  /// Count Text color for [TypingIndicator].
  final Color countTextColor;

  /// Multiple users text style for [TypingIndicator].
  final TextStyle multipleUserTextStyle;
}
