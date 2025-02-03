import 'package:flutter/foundation.dart';

class ChatInputHeightNotifier extends ChangeNotifier {
  double _height = 0;

  double get height => _height;

  void setHeight(double newHeight) {
    if (_height != newHeight) {
      _height = newHeight;
      notifyListeners();
    }
  }
}
