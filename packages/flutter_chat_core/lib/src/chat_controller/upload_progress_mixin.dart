import 'dart:async';

mixin UploadProgressMixin {
  final _progressControllers = <String, StreamController<double>>{};

  Stream<double> getUploadProgress(String id) {
    if (_progressControllers.containsKey(id)) {
      return _progressControllers[id]!.stream;
    }

    final controller = StreamController<double>.broadcast();
    controller.add(0);
    _progressControllers[id] = controller;
    return controller.stream;
  }

  void updateUploadProgress(String id, double progress) {
    final controller = _progressControllers[id];
    if (controller == null || controller.isClosed) return;

    final validProgress = progress.clamp(0.0, 1.0);

    if (validProgress < 0.01) {
      final roundedProgress = (validProgress * 100).ceil() / 100;
      controller.add(roundedProgress);
    } else if (progress > 0.99) {
      controller.add(1);
      clearUploadProgress(id);
    } else {
      final roundedProgress = (validProgress * 100).round() / 100;
      controller.add(roundedProgress);
    }
  }

  void clearUploadProgress(String id) {
    final controller = _progressControllers[id];
    if (controller != null && !controller.isClosed) {
      controller.close();
    }
    _progressControllers.remove(id);
  }

  void disposeUploadProgress() {
    for (final controller in _progressControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _progressControllers.clear();
  }
}
