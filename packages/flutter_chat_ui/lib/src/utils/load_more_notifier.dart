import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] used to track the height and loading state
/// of the "Load More" indicator widget.
class LoadMoreNotifier extends ChangeNotifier {
  double _height = 0;
  bool _isLoading = false;

  /// The current measured height of the LoadMore widget.
  double get height => _height;

  /// Whether the LoadMore widget is currently indicating a loading state.
  bool get isLoading => _isLoading;

  /// Sets the height of the LoadMore widget and notifies listeners if it changes.
  void setHeight(double newHeight) {
    if (_height != newHeight) {
      _height = newHeight;
      notifyListeners();
    }
  }

  /// Sets the loading state and notifies listeners if it changes.
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
}
