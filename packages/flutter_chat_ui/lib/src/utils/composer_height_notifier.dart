import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] used to track the height of the message composer.
///
/// Allows other widgets (like the chat list) to react to composer height changes,
/// for example, by adjusting padding.
class ComposerHeightNotifier extends ChangeNotifier {
  double _height = 0;

  /// The current measured height of the composer.
  double get height => _height;

  /// Sets the composer height and notifies listeners if it changes.
  void setHeight(double newHeight) {
    if (_height != newHeight) {
      _height = newHeight;
      notifyListeners();
    }
  }
}
