/// Represents the state of a streaming text message.
///
/// This state should be managed externally (e.g., using a dedicated manager
/// like [GeminiStreamManager] in the example app) and provided to the
/// [FlyerChatTextStreamMessage] widget.
sealed class StreamState {
  /// Creates a constant [StreamState].
  const StreamState();
}

/// Initial state before any data arrives or completion/error occurs.
///
/// The UI typically shows a loading indicator in this state.
class StreamStateLoading extends StreamState {
  /// Creates a constant [StreamStateLoading].
  const StreamStateLoading();
}

/// State while the stream is actively receiving chunks.
class StreamStateStreaming extends StreamState {
  /// The full text accumulated so far, including all received chunks.
  final String accumulatedText;

  /// Creates a [StreamStateStreaming] with the current accumulated text.
  const StreamStateStreaming(this.accumulatedText);
}

/// State when the stream has finished successfully.
///
/// The UI might display the final text or transition to a regular
/// `TextMessage` depending on the external manager's implementation.
class StreamStateCompleted extends StreamState {
  /// The final, complete text content received from the stream.
  final String finalText;

  /// Creates a [StreamStateCompleted] with the final text.
  const StreamStateCompleted(this.finalText);
}

/// State when the stream encountered an error during generation.
///
/// The UI might display the partial text along with an error indicator,
/// or transition to a `TextMessage` indicating the error.
class StreamStateError extends StreamState {
  /// The error object that caused the stream to fail.
  final Object error;

  /// Text accumulated before the error occurred (optional).
  ///
  /// This can be useful for displaying partial results.
  final String? accumulatedText;

  /// Creates a [StreamStateError].
  const StreamStateError(this.error, {this.accumulatedText});
}
