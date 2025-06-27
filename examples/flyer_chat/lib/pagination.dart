import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import 'widgets/composer_action_bar.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  PaginationState createState() => PaginationState();
}

class PaginationState extends State<Pagination> {
  final _chatController = InMemoryChatController(
    messages: List.generate(20, (i) {
      final random = Random();
      final numLines = random.nextInt(4) + 1;
      final text = List.generate(
        numLines,
        (lineIndex) => 'Message ${i + 1} - Line ${lineIndex + 1}',
      ).join('\n');
      return Message.text(
        id: (i + 1).toString(),
        authorId: 'me',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 - ((20 - i) * 1000),
          isUtc: true,
        ),
        text: text,
      );
    }).reversed.toList(),
  );
  final _currentUser = const User(id: 'me');

  MessageID? _lastMessageId;
  bool _hasMore = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pagination')),
      body: Chat(
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedList(
              itemBuilder: itemBuilder,
              onEndReached: _loadMore,
            );
          },
          composerBuilder: (context) => CustomComposer(
            topWidget: ComposerActionBar(
              buttons: [
                ComposerActionButton(
                  icon: Icons.call_to_action,
                  title: 'Scroll to 1',
                  onPressed: () => _scrollToMessage('1'),
                ),
                ComposerActionButton(
                  icon: Icons.call_to_action,
                  title: 'Scroll to 40',
                  onPressed: () => _scrollToMessage('40'),
                ),
                ComposerActionButton(
                  icon: Icons.call_to_action,
                  title: 'Scroll to 80',
                  onPressed: () => _scrollToMessage('80'),
                ),
              ],
            ),
          ),
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        resolveUser: (id) => Future.value(switch (id) {
          'me' => _currentUser,
          _ => null,
        }),
        theme: ChatTheme.fromThemeData(theme),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;

    final messages = await MockDatabase.getMessages(
      limit: 20,
      lastMessageId: _lastMessageId,
    );

    if (messages.isEmpty) {
      _hasMore = false;
      _isLoading = false;
      return;
    }

    await _chatController.insertAllMessages(messages, index: 0);
    _lastMessageId = messages.first.id;
    _isLoading = false;
  }

  /// Scrolls to a specific message ID, loading necessary pages first if needed
  Future<void> _scrollToMessage(MessageID messageId) async {
    // First check if the message is already loaded
    var messageExists = _chatController.messages.any((m) => m.id == messageId);

    if (messageExists) {
      // Message is already loaded, scroll to it directly
      // If the list is reserved, we might need to add an offset that
      // is equal to the height of the chat composer (not including the safe area).
      // For this example it would be 110.
      await _chatController.scrollToMessage(messageId);
      return;
    }

    // Message is not loaded, show loading information
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Loading message $messageId...'),
        duration: const Duration(
          minutes: 1,
        ), // Long duration since we'll dismiss it manually
      ),
    );

    while (!messageExists) {
      await _loadMore();

      // Check if message is now loaded
      messageExists = _chatController.messages.any((m) => m.id == messageId);
    }

    // Dismiss loaded information
    scaffoldMessenger.hideCurrentSnackBar();

    // If the list is reversed, we need to wait for insert animation to complete
    // await Future.delayed(const Duration(milliseconds: 250));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the list is reversed, we might need to add an offset that
      // is equal to the height of the chat composer (not including the safe area).
      // For this example it would be 110.
      _chatController.scrollToMessage(messageId);
    });
  }
}

class MockDatabase {
  static final List<Message> _messages = List.generate(80, (i) {
    final random = Random();
    final numLines = random.nextInt(4) + 1;
    final text = List.generate(
      numLines,
      (lineIndex) => 'Message ${i + 21} - Line ${lineIndex + 1}',
    ).join('\n');
    return Message.text(
      id: (i + 21).toString(),
      authorId: 'me',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        1736893310000 - ((80 - i) * 1000),
        isUtc: true,
      ),
      text: text,
    );
  });

  static Future<List<Message>> getMessages({
    required int limit,
    MessageID? lastMessageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final start = lastMessageId == null
        ? 0
        : _messages.indexWhere((m) => m.id == lastMessageId) + 1;

    if (start >= _messages.length) return [];

    return _messages.skip(start).take(limit).toList().reversed.toList();
  }
}

class CustomComposer extends StatefulWidget {
  final Widget topWidget;

  const CustomComposer({super.key, required this.topWidget});

  @override
  State<CustomComposer> createState() => _CustomComposerState();
}

class _CustomComposerState extends State<CustomComposer> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void didUpdateWidget(covariant CustomComposer oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    final theme = context.select(
      (ChatTheme t) => (surfaceContainerLow: t.colors.surfaceContainerLow),
    );

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRect(
        child: Container(
          key: _key,
          color: theme.surfaceContainerLow,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSafeArea),
            child: widget.topWidget,
          ),
        ),
      ),
    );
  }

  void _measure() {
    if (!mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      final bottomSafeArea = MediaQuery.of(context).padding.bottom;

      context.read<ComposerHeightNotifier>().setHeight(height - bottomSafeArea);
    }
  }
}
