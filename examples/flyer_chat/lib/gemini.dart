import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import 'gemini_stream_manager.dart';
import 'sembast_chat_controller.dart';
import 'widgets/composer_action_bar.dart';

// Define the shared animation duration
const Duration _kChunkAnimationDuration = Duration(milliseconds: 350);

class Gemini extends StatefulWidget {
  final String geminiApiKey;
  final Database database;

  const Gemini({super.key, required this.geminiApiKey, required this.database});

  @override
  GeminiState createState() => GeminiState();
}

class GeminiState extends State<Gemini> {
  final _uuid = const Uuid();
  final _crossCache = CrossCache();
  final _scrollController = ScrollController();

  final _currentUser = const User(id: 'me');
  final _agent = const User(id: 'agent');

  late final ChatController _chatController;
  late final GenerativeModel _model;
  late ChatSession _chatSession;

  late final GeminiStreamManager _streamManager;

  // Store scroll state per stream ID
  final Map<String, double> _initialScrollExtents = {};
  final Map<String, bool> _reachedTargetScroll = {};

  @override
  void initState() {
    super.initState();
    _chatController = SembastChatController(widget.database);
    _streamManager = GeminiStreamManager(
      chatController: _chatController,
      chunkAnimationDuration: _kChunkAnimationDuration,
    );

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: widget.geminiApiKey,
      safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );

    _chatSession = _model.startChat(
      history:
          _chatController.messages
              .whereType<TextMessage>()
              .map((message) => Content.text(message.text))
              .toList(),
    );
  }

  @override
  void dispose() {
    _streamManager.dispose();
    _chatController.dispose();
    _scrollController.dispose();
    _crossCache.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gemini')),
      body: ChangeNotifierProvider.value(
        value: _streamManager,
        child: Chat(
          builders: Builders(
            chatAnimatedListBuilder: (context, itemBuilder) {
              return ChatAnimatedList(
                scrollController: _scrollController,
                itemBuilder: itemBuilder,
                shouldScrollToEndWhenAtBottom: false,
              );
            },
            imageMessageBuilder:
                (context, message, index) => FlyerChatImageMessage(
                  message: message,
                  index: index,
                  showTime: false,
                  showStatus: false,
                ),
            composerBuilder:
                (context) => Composer(
                  topWidget: ComposerActionBar(
                    buttons: [
                      ComposerActionButton(
                        icon: Icons.delete_sweep,
                        title: 'Clear all',
                        onPressed: () {
                          _chatController.set([]);
                          _chatSession = _model.startChat();
                        },
                        destructive: true,
                      ),
                    ],
                  ),
                ),
            textMessageBuilder:
                (context, message, index) => FlyerChatTextMessage(
                  message: message,
                  index: index,
                  showTime: false,
                  showStatus: false,
                  receivedBackgroundColor: null,
                  padding:
                      message.authorId == _agent.id
                          ? EdgeInsets.zero
                          : const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                ),
            textStreamMessageBuilder: (context, message, index) {
              // Watch the manager for state updates
              final streamState = context.watch<GeminiStreamManager>().getState(
                message.streamId,
              );
              // Return the stream message widget, passing the state
              return FlyerChatTextStreamMessage(
                message: message,
                index: index,
                streamState: streamState,
                chunkAnimationDuration: _kChunkAnimationDuration,
                showTime: false,
                showStatus: false,
                receivedBackgroundColor: null,
                padding:
                    message.authorId == _agent.id
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
              );
            },
          ),
          chatController: _chatController,
          crossCache: _crossCache,
          currentUserId: _currentUser.id,
          onAttachmentTap: _handleAttachmentTap,
          onMessageSend: _handleMessageSend,
          resolveUser:
              (id) => Future.value(switch (id) {
                'me' => _currentUser,
                'agent' => _agent,
                _ => null,
              }),
          theme: ChatTheme.fromThemeData(theme),
        ),
      ),
    );
  }

  void _handleMessageSend(String text) async {
    await _chatController.insert(
      TextMessage(
        id: _uuid.v4(),
        authorId: _currentUser.id,
        text: text,
        metadata: isOnlyEmoji(text) ? {'isOnlyEmoji': true} : null,
      ),
    );

    final content = Content.text(text);
    _sendContent(content);
  }

  void _handleAttachmentTap() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    await _crossCache.downloadAndSave(image.path);

    await _chatController.insert(
      ImageMessage(
        id: _uuid.v4(),
        authorId: _currentUser.id,
        source: image.path,
      ),
    );

    final bytes = await _crossCache.get(image.path);

    final content = Content.data('image/jpeg', bytes);
    _sendContent(content);
  }

  void _sendContent(Content content) async {
    // Generate a unique ID for the stream
    final streamId = _uuid.v4();
    TextStreamMessage? streamMessage;
    var isFirstChunk = true;

    // Store scroll state per stream ID
    _reachedTargetScroll[streamId] = false;

    try {
      final response = _chatSession.sendMessageStream(content);

      await for (final chunk in response) {
        if (chunk.text != null) {
          final textChunk = chunk.text!;
          if (textChunk.isEmpty) continue; // Skip empty chunks

          if (isFirstChunk) {
            isFirstChunk = false;

            // Create and insert the message ON the first chunk
            streamMessage = TextStreamMessage(
              id: streamId,
              authorId: _agent.id,
              createdAt: DateTime.now().toUtc(),
              streamId: streamId,
            );
            await _chatController.insert(streamMessage);
            _streamManager.startStream(streamId, streamMessage);
          }

          // Ensure stream message exists before adding chunk
          if (streamMessage == null) continue;

          // Send chunk to the manager - this triggers notifyListeners
          _streamManager.addChunk(streamId, textChunk);

          // Schedule scroll check after the frame rebuilds
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_scrollController.hasClients || !mounted) return;

            // Retrieve state for this specific stream
            var initialExtent = _initialScrollExtents[streamId];
            final reachedTarget = _reachedTargetScroll[streamId] ?? false;

            if (reachedTarget) return; // Already scrolled to target

            // Store initial extent after first chunk caused rebuild
            initialExtent ??=
                _initialScrollExtents[streamId] =
                    _scrollController.position.maxScrollExtent;

            // Only scroll if the list is scrollable
            if (initialExtent > 0) {
              // Calculate target scroll position (copied from original logic)
              final targetScroll =
                  initialExtent + // Use the stored initial extent
                  _scrollController.position.viewportDimension -
                  MediaQuery.of(context).padding.bottom -
                  168; // height of the composer + height of the app bar + visual buffer of 8

              if (_scrollController.position.maxScrollExtent > targetScroll) {
                _scrollController.animateTo(
                  targetScroll,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linearToEaseOut,
                );
                // Mark that we've reached the target for this stream
                _reachedTargetScroll[streamId] = true;
              } else {
                // If we haven't reached target position yet, scroll to bottom
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linearToEaseOut,
                );
              }
            }
          });
        }
      }

      // Stream completed successfully (only if message was created)
      if (streamMessage != null) {
        await _streamManager.completeStream(streamId);
      }
    } on GenerativeAIException catch (error) {
      debugPrint('Generation error for $streamId: $error');
      // Stream failed (only if message was created)
      if (streamMessage != null) {
        await _streamManager.errorStream(streamId, error);
      } else {
        // Handle error that occurred before the first chunk
        // Maybe show a temporary error message?
      }
    } catch (error) {
      // Catch other potential errors during stream processing
      debugPrint('Unhandled error for stream $streamId: $error');
      if (streamMessage != null) {
        await _streamManager.errorStream(streamId, error);
      } else {
        // Handle error that occurred before the first chunk
      }
    } finally {
      // Clean up scroll state for this stream ID when done/errored
      _initialScrollExtents.remove(streamId);
      _reachedTargetScroll.remove(streamId);
    }
  }
}
