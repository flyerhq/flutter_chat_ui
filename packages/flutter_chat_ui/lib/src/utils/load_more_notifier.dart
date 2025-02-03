import 'package:flutter/foundation.dart';

class LoadMoreNotifier extends ChangeNotifier {
  double _height = 0;
  bool _isLoading = false;

  double get height => _height;
  bool get isLoading => _isLoading;

  void setHeight(double newHeight) {
    if (_height != newHeight) {
      _height = newHeight;
      notifyListeners();
    }
  }

  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
}
