import 'dart:async';

/// A mixin for [ChatController] implementations that need to handle
/// upload progress tracking for messages (e.g., images, files).
///
/// It provides methods to get a progress stream, update progress, and clean up.
mixin UploadProgressMixin {
  final _progressControllers = <String, StreamController<double>>{};

  /// Gets a stream that emits upload progress updates (0.0 to 1.0) for a given message ID.
  ///
  /// Creates a new stream if one doesn't exist for the [id].
  /// The stream starts with an initial value of 0.
  Stream<double> getUploadProgress(String id) {
    if (_progressControllers.containsKey(id)) {
      return _progressControllers[id]!.stream;
    }

    final controller = StreamController<double>.broadcast();
    controller.add(0);
    _progressControllers[id] = controller;
    return controller.stream;
  }

  /// Updates the upload progress for a specific message ID.
  ///
  /// Clamps the [progress] value between 0.0 and 1.0.
  /// Rounds progress to the nearest percentage point (except for very small or near-complete values).
  /// Automatically clears the progress stream when progress reaches 1.0.
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

  /// Closes and removes the progress stream for the given message ID.
  /// Typically called when the upload is complete or cancelled.
  void clearUploadProgress(String id) {
    final controller = _progressControllers[id];
    if (controller != null && !controller.isClosed) {
      controller.close();
    }
    _progressControllers.remove(id);
  }

  /// Disposes all active upload progress controllers.
  /// Should be called in the [ChatController.dispose] method.
  void disposeUploadProgress() {
    for (final controller in _progressControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _progressControllers.clear();
  }
}
