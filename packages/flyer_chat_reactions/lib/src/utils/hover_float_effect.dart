import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A widget that applies a floating hover effect to its child.
///
/// When the mouse hovers over this widget, it creates a subtle 3D-like effect
/// by translating and scaling the child based on mouse position.
///
/// This effect is only applied on desktop platforms (Windows, macOS, Linux) and web.
/// On mobile platforms, the child widget is returned without any hover effects.
class HoverFloatEffect extends StatefulWidget {
  /// The widget to apply the hover effect to.
  final Widget child;

  /// The scale factor applied to the child when hovering.
  /// A value of 1.0 means no scaling, 1.05 means 5% larger.
  /// Defaults to 1.05 for a subtle zoom effect.
  final double zoomScale;

  /// The translation distance in pixels for the hover effect.
  /// Controls how far the widget moves from its center position.
  /// Defaults to 20 pixels for a subtle floating effect.
  final double translationDistance;

  const HoverFloatEffect({
    super.key,
    required this.child,
    this.zoomScale = 1.05,
    this.translationDistance = 20,
  });

  @override
  State<HoverFloatEffect> createState() => _HoverFloatEffectState();
}

class _HoverFloatEffectState extends State<HoverFloatEffect> {
  Offset _offset = Offset.zero;

  /// Returns true if the current platform supports mouse hover effects.
  bool get _supportsHover =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  @override
  Widget build(BuildContext context) {
    // On mobile platforms, just return the child without hover effects
    if (!_supportsHover) {
      return widget.child;
    }

    final size = MediaQuery.of(context).size;
    return MouseRegion(
      onHover: (event) {
        // Calculate normalized position (-0.5 to 0.5) and apply translation distance
        final dx =
            (event.position.dx / size.width - 0.5) * widget.translationDistance;
        final dy =
            (event.position.dy / size.height - 0.5) *
            widget.translationDistance;
        setState(() => _offset = Offset(dx, dy));
      },
      onExit: (_) => setState(() => _offset = Offset.zero),
      child: TweenAnimationBuilder(
        tween: Tween<Offset>(begin: Offset.zero, end: _offset),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Transform.scale(scale: widget.zoomScale, child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}
