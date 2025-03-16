import 'package:flutter/widgets.dart';

typedef ScrollToMessageId =
    Future<void> Function(
      String messageId, {
      Duration duration,
      Curve curve,
      double alignment,
      double offset,
    });

typedef ScrollToIndex =
    Future<void> Function(
      int index, {
      Duration duration,
      Curve curve,
      double alignment,
      double offset,
    });

mixin ScrollToMessageMixin {
  ScrollToMessageId? _scrollToMessageId;
  ScrollToIndex? _scrollToIndex;

  /// Attaches the scroll methods that will be used for scrolling operations.
  /// This is called automatically by ChatAnimatedList.
  void attachScrollMethods({
    required ScrollToMessageId scrollToMessageId,
    required ScrollToIndex scrollToIndex,
  }) {
    _scrollToMessageId = scrollToMessageId;
    _scrollToIndex = scrollToIndex;
  }

  /// Detaches the scroll methods when the widget is disposed.
  void detachScrollMethods() {
    _scrollToMessageId = null;
    _scrollToIndex = null;
  }

  /// Scrolls to a specific message by ID.
  Future<void> scrollToMessage(
    String messageId, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linearToEaseOut,

    /// Desired position of the message in viewport [0.0, 1.0].
    /// 0 = top, 0.5 = middle, 1 = bottom
    double alignment = 0,
    double offset = 0,
  }) {
    if (_scrollToMessageId == null) {
      return Future.value();
    }

    return (_scrollToMessageId as ScrollToMessageId)(
      messageId,
      duration: duration,
      curve: curve,
      alignment: alignment,
      offset: offset,
    );
  }

  /// Scrolls to a specific index in the message list.
  Future<void> scrollToIndex(
    int index, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linearToEaseOut,

    /// Desired position of the message in viewport [0.0, 1.0].
    /// 0 = top, 0.5 = middle, 1 = bottom
    double alignment = 0,
    double offset = 0,
  }) {
    if (_scrollToIndex == null) {
      return Future.value();
    }

    return (_scrollToIndex as ScrollToIndex)(
      index,
      duration: duration,
      curve: curve,
      alignment: alignment,
      offset: offset,
    );
  }

  /// Disposes scroll resources. This should be called in the ChatController's dispose method.
  void disposeScrollMethods() {
    detachScrollMethods();
  }
}
