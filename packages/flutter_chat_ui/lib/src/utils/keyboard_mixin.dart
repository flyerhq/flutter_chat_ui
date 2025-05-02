import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// A mixin for State classes that provides keyboard height detection and notification.
///
/// Automatically handles listening to `WidgetsBinding` for metrics changes
/// and debounces updates to avoid rapid firing during keyboard animations.
mixin KeyboardMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  Timer? _keyboardDebounceTimer;
  double _previousKeyboardHeight = 0;
  double _initialSafeArea = 0;
  bool _initialized = false;

  /// Abstract method to be implemented by the consuming State.
  /// Called when the keyboard height changes (after debouncing).
  /// The provided [height] is adjusted for the initial bottom safe area.
  void onKeyboardHeightChanged(double height);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialSafeArea = MediaQuery.of(context).padding.bottom;
      _initialized = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _keyboardDebounceTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;

    final keyboardHeight = View.of(context).viewInsets.bottom;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    if (keyboardHeight != _previousKeyboardHeight) {
      _previousKeyboardHeight = keyboardHeight;

      _keyboardDebounceTimer?.cancel();
      _keyboardDebounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          onKeyboardHeightChanged(
            max(keyboardHeight / pixelRatio - _initialSafeArea, 0),
          );
        }
      });
    }
  }
}
