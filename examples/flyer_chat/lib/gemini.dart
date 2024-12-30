import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import 'sembast_chat_controller.dart';
import 'widgets/input_action_bar.dart';

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

  late final ChatController _chatController;
  late final GenerativeModel _model;
  late ChatSession _chatSession;

  Message? _currentGeminiResponse;

  @override
  void initState() {
    super.initState();
    _chatController = SembastChatController(widget.database);
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: widget.geminiApiKey,
      safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );

    _chatSession = _model.startChat(
      history: _chatController.messages
          .whereType<TextMessage>()
          .map((message) => Content.text(message.text))
          .toList(),
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    _crossCache.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini'),
      ),
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, message) =>
              FlyerChatTextMessage(message: message),
          imageMessageBuilder: (context, message) =>
              FlyerChatImageMessage(message: message),
          inputBuilder: (context) => ChatInput(
            topWidget: InputActionBar(
              buttons: [
                InputActionButton(
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
        ),
        chatController: _chatController,
        crossCache: _crossCache,
        scrollController: _scrollController,
        onMessageSend: _handleMessageSend,
        onAttachmentTap: _handleAttachmentTap,
        user: const User(id: 'me'),
      ),
    );
  }

  void _handleMessageSend(String text) async {
    await _chatController.insert(
      TextMessage(
        id: _uuid.v4(),
        author: const User(id: 'me'),
        createdAt: DateTime.now().toUtc(),
        text: text,
        isOnlyEmoji: isOnlyEmoji(text),
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
        author: const User(id: 'me'),
        createdAt: DateTime.now().toUtc(),
        source: image.path,
      ),
    );

    final bytes = await _crossCache.get(image.path);

    final content = Content.data('image/jpeg', bytes);
    _sendContent(content);
  }

  void _sendContent(Content content) async {
    try {
      final response = _chatSession.sendMessageStream(content);

      var accumulatedText = '';
      // used to showcase an example where we stop scrolling to the bottom
      // as soon as message that is being generated reaches top of the viewport
      final initialMaxScrollExtent = _scrollController.position.maxScrollExtent;
      final viewportDimension = _scrollController.position.viewportDimension;

      await for (final chunk in response) {
        if (chunk.text != null) {
          accumulatedText += chunk.text!;

          if (_currentGeminiResponse == null) {
            _currentGeminiResponse = TextMessage(
              id: _uuid.v4(),
              author: const User(id: 'gemini'),
              createdAt: DateTime.now().toUtc(),
              text: accumulatedText,
              isOnlyEmoji: isOnlyEmoji(accumulatedText),
            );
            await _chatController.insert(_currentGeminiResponse!);
          } else {
            final newUpdatedMessage = (_currentGeminiResponse as TextMessage)
                .copyWith(text: accumulatedText);
            await _chatController.update(
              _currentGeminiResponse!,
              newUpdatedMessage,
            );
            _currentGeminiResponse = newUpdatedMessage;

            // used to showcase an example where we stop scrolling to the bottom
            // as soon as message that is being generated reaches top of the viewport
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_scrollController.hasClients || !mounted) return;
              if ((_scrollController.position.maxScrollExtent -
                      initialMaxScrollExtent) <
                  viewportDimension) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linearToEaseOut,
                );
              }
            });
          }
        }
      }

      _currentGeminiResponse = null;
    } on GenerativeAIException catch (error) {
      debugPrint('Generation error $error');
    }
  }
}
