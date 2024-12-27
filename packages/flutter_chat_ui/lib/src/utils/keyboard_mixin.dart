import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

mixin KeyboardMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  Timer? _keyboardDebounceTimer;
  double _previousKeyboardHeight = 0;
  double _initialSafeArea = 0;
  bool _initialized = false;

  /// Override this method to handle keyboard height changes
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
