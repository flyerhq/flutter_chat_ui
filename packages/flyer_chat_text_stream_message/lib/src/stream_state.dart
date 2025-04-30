/// Represents the state of a streaming text message.
/// This state should be managed externally and provided to the widget.
sealed class StreamState {
  const StreamState();
}

/// Initial state before any data arrives or completion/error occurs.
class StreamStateLoading extends StreamState {
  const StreamStateLoading();
}

/// State while the stream is actively receiving chunks.
class StreamStateStreaming extends StreamState {
  /// The full text accumulated so far.
  final String accumulatedText;

  const StreamStateStreaming(this.accumulatedText);
}

/// State when the stream has finished successfully.
class StreamStateCompleted extends StreamState {
  /// The final, complete text content.
  final String finalText;

  const StreamStateCompleted(this.finalText);
}

/// State when the stream encountered an error.
class StreamStateError extends StreamState {
  /// The error object.
  final Object error;

  /// Text accumulated before the error occurred (optional).
  final String? accumulatedText;

  const StreamStateError(this.error, {this.accumulatedText});
}
