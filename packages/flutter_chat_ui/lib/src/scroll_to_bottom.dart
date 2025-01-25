import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/chat_input_height_notifier.dart';

class ScrollToBottom extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onPressed;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final bool? useChatInputHeightForBottomOffset;
  final bool? mini;
  final ShapeBorder? shape;
  final Widget? icon;
  final bool? handleSafeArea;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ScrollToBottom({
    super.key,
    required this.animation,
    required this.onPressed,
    this.left,
    this.right = 16,
    this.top,
    this.bottom = 20,
    this.useChatInputHeightForBottomOffset = true,
    this.mini = true,
    this.shape = const CircleBorder(),
    this.icon = const Icon(Icons.keyboard_arrow_down),
    this.handleSafeArea = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final colors = context.select(
      (ChatTheme theme) => (
        onSurface: theme.colors.onSurface,
        surfaceContainer: theme.colors.surfaceContainer,
      ),
    );

    return Consumer<ChatInputHeightNotifier>(
      builder: (context, heightNotifier, child) {
        return Positioned(
          left: left,
          right: right,
          top: top,
          bottom: useChatInputHeightForBottomOffset == true
              ? heightNotifier.height +
                  (bottom ?? 0) +
                  (handleSafeArea == true ? bottomSafeArea : 0)
              : bottom,
          child: ScaleTransition(
            scale: animation,
            child: FloatingActionButton(
              backgroundColor: backgroundColor ?? colors.surfaceContainer,
              foregroundColor: foregroundColor ?? colors.onSurface,
              heroTag: null,
              mini: mini ?? false,
              shape: shape,
              onPressed: onPressed,
              child: icon,
            ),
          ),
        );
      },
    );
  }
}
