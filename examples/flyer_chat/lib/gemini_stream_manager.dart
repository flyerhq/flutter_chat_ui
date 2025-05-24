import 'package:flutter/foundation.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';

class GeminiStreamManager extends ChangeNotifier {
  final ChatController _chatController;
  final Duration _chunkAnimationDuration;

  // State storage for stream messages
  final Map<String, StreamState> _streamStates = {};
  // Store the original TextStreamMessage to allow updating it later
  final Map<String, TextStreamMessage> _originalMessages = {};
  // Store accumulated text separately for easier updates
  final Map<String, String> _accumulatedTexts = {};

  GeminiStreamManager({
    required ChatController chatController,
    required Duration chunkAnimationDuration,
  }) : _chatController = chatController,
       _chunkAnimationDuration = chunkAnimationDuration;

  /// Gets the current state for a given stream ID.
  StreamState getState(String streamId) {
    return _streamStates[streamId] ?? const StreamStateLoading();
  }

  /// Initializes the stream state for a new message.
  void startStream(String streamId, TextStreamMessage originalMessage) {
    _originalMessages[streamId] = originalMessage;
    _streamStates[streamId] = const StreamStateLoading();
    _accumulatedTexts[streamId] = '';
    // Initial state might not need immediate notification unless UI shows loading
    // differently based on presence in the map vs. not.
    // Let's notify just in case.
    notifyListeners();
  }

  /// Adds a text chunk to the stream.
  void addChunk(String streamId, String chunk) {
    if (!_streamStates.containsKey(streamId)) {
      return; // Stream might have finished
    }

    // Trim single trailing newline from the incoming chunk if present.
    var processedChunk = chunk;
    if (processedChunk.endsWith('\n') && !processedChunk.endsWith('\n\n')) {
      processedChunk = processedChunk.substring(0, processedChunk.length - 1);
    }

    // Use the potentially processed chunk
    _accumulatedTexts[streamId] =
        (_accumulatedTexts[streamId] ?? '') + processedChunk;

    _streamStates[streamId] = StreamStateStreaming(
      _accumulatedTexts[streamId]!,
    );
    notifyListeners();
  }

  /// Finalizes the stream with the complete text and updates the controller.
  Future<void> completeStream(String streamId) async {
    // Get accumulated text BEFORE the delay (it won't change during delay)
    final finalText = _accumulatedTexts[streamId];

    // If finalText is null here, something went wrong before even delaying.
    if (finalText == null) {
      debugPrint(
        'GeminiStreamManager: Cannot complete stream, missing accumulated text for $streamId',
      );
      _cleanupStream(streamId); // Clean up manager state
      return;
    }

    // Allow time for the last chunk animation to complete in the UI
    await Future.delayed(_chunkAnimationDuration);

    // Check if the stream state is still being tracked by the manager.
    // Re-fetch the original message using the streamId.
    final originalMessage = _originalMessages[streamId];
    if (originalMessage == null) {
      // This implies _cleanupStream was called during the delay (e.g., by an error)
      debugPrint(
        'GeminiStreamManager: State for $streamId was cleaned up during delay. Skipping update.',
      );
      // No need to call _cleanupStream again, it was already done.
      return;
    }

    // Create the final message content
    final finalTextMessage = TextMessage(
      id: originalMessage.id,
      authorId: originalMessage.authorId,
      createdAt: originalMessage.createdAt,
      text: finalText,
    );

    try {
      // Attempt to update the message. The controller should handle
      // cases where the original message might have been removed.
      await _chatController.updateMessage(originalMessage, finalTextMessage);
    } catch (e) {
      // Log potential errors during update (e.g., message not found, controller disposed)
      debugPrint(
        'GeminiStreamManager: Failed to update message $streamId after delay: $e',
      );
    } finally {
      // Always clean up manager state after attempting update (success or fail)
      _cleanupStream(streamId);
    }
  }

  /// Finalizes the stream with an error and updates the controller.
  Future<void> errorStream(String streamId, Object error) async {
    final originalMessage = _originalMessages[streamId];
    final currentText = _accumulatedTexts[streamId] ?? '';

    if (originalMessage == null) {
      debugPrint(
        'GeminiStreamManager: Cannot error stream, missing original message for $streamId',
      );
      _cleanupStream(streamId);
      return;
    }

    // Create a final TextMessage indicating the error
    final errorTextMessage = TextMessage(
      id: originalMessage.id,
      authorId: originalMessage.authorId,
      createdAt: originalMessage.createdAt,
      text: '$currentText\n\n[${error.toString()}]',
    );

    try {
      await _chatController.updateMessage(originalMessage, errorTextMessage);
    } catch (e) {
      debugPrint(
        'GeminiStreamManager: Failed to update message $streamId after error: $e',
      );
    }

    _cleanupStream(streamId);
  }

  /// Removes state associated with a stream ID.
  void _cleanupStream(String streamId) {
    _streamStates.remove(streamId);
    _originalMessages.remove(streamId);
    _accumulatedTexts.remove(streamId);
    // Notify listeners in case the UI needs to react to the stream disappearing
    // from the manager (though usually the controller update is sufficient).
    notifyListeners();
  }
}
