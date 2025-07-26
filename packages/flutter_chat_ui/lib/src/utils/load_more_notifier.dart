import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] used to track the height and loading state
/// of the "Load More" indicator widget.
class LoadMoreNotifier extends ChangeNotifier {
  bool _isLoadingOlder = false;
  bool _isLoadingNewer = false;

  /// Whether the LoadMore widget is currently indicating a
  /// loading state for older messages.
  bool get isLoadingOlder => _isLoadingOlder;

  /// Whether the LoadMore widget is currently indicating a
  /// loading state for newer messages.
  bool get isLoadingNewer => _isLoadingNewer;

  /// Sets the loading state for older messages and notifies listeners if it changes.
  void setLoadingOlder(bool loading) {
    if (_isLoadingOlder != loading) {
      _isLoadingOlder = loading;
      notifyListeners();
    }
  }

  /// Sets the loading state for newer messages and notifies listeners if it changes.
  void setLoadingNewer(bool loading) {
    if (_isLoadingNewer != loading) {
      _isLoadingNewer = loading;
      notifyListeners();
    }
  }
}
