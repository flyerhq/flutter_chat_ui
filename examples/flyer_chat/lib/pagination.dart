import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  PaginationState createState() => PaginationState();
}

class PaginationState extends State<Pagination> {
  final _chatController = InMemoryChatController(
    messages: List.generate(
      20,
      (i) => Message.text(
        id: (i + 1).toString(),
        authorId: 'me',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 - ((20 - i) * 1000),
          isUtc: true,
        ),
        text: 'Message ${i + 1}',
      ),
    ).reversed.toList(),
  );
  final _currentUser = const User(id: 'me');
  final _scrollController = ScrollController();

  String? _lastMessageId;
  bool _hasMore = true;

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination'),
      ),
      body: Chat(
        builders: Builders(
          chatAnimatedListBuilder: (context, scrollController, itemBuilder) {
            return ChatAnimatedList(
              scrollController: _scrollController,
              itemBuilder: itemBuilder,
              onEndReached: _loadMore,
            );
          },
          inputBuilder: (context) => const SizedBox.shrink(),
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        resolveUser: (id) => Future.value(
          switch (id) {
            'me' => _currentUser,
            _ => null,
          },
        ),
        theme: ChatTheme.fromThemeData(theme),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (!_hasMore) return;

    final messages = await MockDatabase.getMessages(
      limit: 20,
      lastMessageId: _lastMessageId,
    );

    if (messages.isEmpty) {
      _hasMore = false;
      return;
    }

    await _chatController.set([...messages, ..._chatController.messages]);
    _lastMessageId = messages.first.id;
  }
}

class MockDatabase {
  static final List<Message> _messages = List.generate(
    80,
    (i) => Message.text(
      id: (i + 21).toString(),
      authorId: 'me',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        1736893310000 - ((80 - i) * 1000),
        isUtc: true,
      ),
      text: 'Message ${i + 21}',
    ),
  );

  static Future<List<Message>> getMessages({
    required int limit,
    String? lastMessageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final start = lastMessageId == null
        ? 0
        : _messages.indexWhere((m) => m.id == lastMessageId) + 1;

    if (start >= _messages.length) return [];

    return _messages.skip(start).take(limit).toList().reversed.toList();
  }
}
