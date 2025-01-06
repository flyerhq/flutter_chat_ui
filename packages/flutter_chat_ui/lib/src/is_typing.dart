import 'package:flutter/material.dart';

class IsTypingIndicator extends StatefulWidget {
  final double size;
  final Color? color;
  final Duration duration;
  final double spacing;

  const IsTypingIndicator({
    super.key,
    this.size = 8,
    this.color,
    this.duration = const Duration(milliseconds: 150),
    this.spacing = 2,
  });

  @override
  State<IsTypingIndicator> createState() => _IsTypingIndicatorState();
}

class _IsTypingIndicatorState extends State<IsTypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration: widget.duration,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: -2,
        end: 2,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // for (var i = 0; i < _controllers.length; i++) {
    //   Future.delayed(Duration(milliseconds: i * 100), () {
    //     _controllers[i].repeat(reverse: true);
    //   });
    // }

    // Start the first dot
    _controllers[0].forward();

    // Chain the animations
    _controllers[0].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[0].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[1].forward();
      }
    });

    _controllers[1].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[1].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[2].forward();
      }
    });

    _controllers[2].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllers[2].reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllers[0].forward();
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.spacing),
            child: AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_animations[index].value),
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
