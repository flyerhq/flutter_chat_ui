import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../flutter_chat_ui.dart';
import '../utils/keyboard_mixin.dart';

/// A sliver widget that creates vertical spacing at the end of a chat list.
///
/// This widget is primarily used to account for the height of the composer,
/// optional bottom padding, and the keyboard (when visible).
/// It consumes [ComposerHeightNotifier] to dynamically adjust its spacing
/// based on the composer's height and uses [KeyboardMixin] to react to
/// keyboard visibility changes.
class SliverSpacing extends StatefulWidget {
  /// Optional padding to add below the composer area.
  final double? bottomPadding;

  /// Whether to automatically account for the bottom safe area (notch, home indicator).
  /// Defaults to true if not specified, but behavior depends on how it's used in parent.
  final bool? handleSafeArea;

  /// Callback function invoked when the detected keyboard height changes.
  ///
  /// The reported `height` is the adjusted keyboard height, considering the
  /// initial safe area.
  final void Function(double height)? onKeyboardHeightChanged;

  /// Creates a [SliverSpacing] widget.
  const SliverSpacing({
    super.key,
    this.bottomPadding,
    this.handleSafeArea,
    this.onKeyboardHeightChanged,
  });

  @override
  State<SliverSpacing> createState() => _SliverSpacingState();
}

class _SliverSpacingState extends State<SliverSpacing>
    with WidgetsBindingObserver, KeyboardMixin {
  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.bottom;
    return Consumer<ComposerHeightNotifier>(
      builder: (context, heightNotifier, child) {
        return SliverPadding(
          padding: EdgeInsets.only(
            bottom:
                heightNotifier.height +
                (widget.bottomPadding ?? 0) +
                (widget.handleSafeArea == true ? safeArea : 0),
          ),
        );
      },
    );
  }

  @override
  void onKeyboardHeightChanged(double height) {
    widget.onKeyboardHeightChanged?.call(height);
  }
}
