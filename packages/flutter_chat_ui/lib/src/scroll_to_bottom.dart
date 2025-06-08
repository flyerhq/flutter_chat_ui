import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'utils/composer_height_notifier.dart';

/// A floating action button typically displayed near the composer
/// that scrolls the chat list to the bottom when pressed.
///
/// Animates its appearance/disappearance based on the provided [animation].
class ScrollToBottom extends StatelessWidget {
  /// Animation controlling the visibility and scale of the button.
  final Animation<double> animation;

  /// Callback triggered when the button is pressed.
  final VoidCallback onPressed;

  /// Optional left position.
  final double? left;

  /// Optional right position.
  final double? right;

  /// Optional top position.
  final double? top;

  /// Optional bottom position.
  final double? bottom;

  /// Whether to offset the button's bottom position by the composer's height.
  final bool? useComposerHeightForBottomOffset;

  /// Whether to use the smaller mini FAB size.
  final bool? mini;

  /// The shape of the button.
  final ShapeBorder? shape;

  /// The icon displayed inside the button.
  final Widget? icon;

  /// Whether to adjust the bottom position for the bottom safe area.
  final bool? handleSafeArea;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Foreground color (icon color) of the button.
  final Color? foregroundColor;

  /// Creates a scroll-to-bottom button.
  const ScrollToBottom({
    super.key,
    required this.animation,
    required this.onPressed,
    this.left,
    this.right = 16,
    this.top,
    this.bottom = 20,
    this.useComposerHeightForBottomOffset = true,
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
    final theme = context.select(
      (ChatTheme t) => (
        onSurface: t.colors.onSurface,
        surfaceContainer: t.colors.surfaceContainer,
      ),
    );

    return Consumer<ComposerHeightNotifier>(
      builder: (context, heightNotifier, child) {
        return Positioned(
          left: left,
          right: right,
          top: top,
          bottom:
              useComposerHeightForBottomOffset == true
                  ? heightNotifier.height +
                      (bottom ?? 0) +
                      (handleSafeArea == true ? bottomSafeArea : 0)
                  : bottom,
          child: ScaleTransition(
            scale: animation,
            child: FloatingActionButton(
              backgroundColor: backgroundColor ?? theme.surfaceContainer,
              foregroundColor: foregroundColor ?? theme.onSurface,
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
