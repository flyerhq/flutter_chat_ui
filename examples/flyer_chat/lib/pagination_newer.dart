import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'pagination_mock_database.dart';

class PaginationNewer extends StatefulWidget {
  const PaginationNewer({super.key});

  @override
  PaginationNewerState createState() => PaginationNewerState();
}

class PaginationNewerState extends State<PaginationNewer> {
  final _chatController = InMemoryChatController(
    messages: List.from(MockDatabase.initialOlderMessages),
  );
  final _currentUser = const User(id: 'me');

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
      appBar: AppBar(title: const Text('Pagination (get newer)')),
      body: Chat(
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedList(
              itemBuilder: itemBuilder,
              onStartReached: _loadNewerMessages,
              initialScrollToEndMode: InitialScrollToEndMode.none,
            );
          },
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

  Future<void> _loadNewerMessages() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;

    // The visually bottommost message is the last in our data list.
    final newestMessageId = _chatController.messages.last.id;
    final messages = await MockDatabase.getNewerMessages(
      limit: 20,
      newestMessageId: newestMessageId,
    );

    if (messages.isEmpty) {
      _hasMore = false;
    } else {
      // Append newer messages to the visual bottom of the list.
      await _chatController.insertAllMessages(
        messages,
        index: _chatController.messages.length,
        // Important: we don't want to animate the insertion of the messages
        // because pagination logic relies on messages to be inserted instantly.
        // There is no need for animation anyway as all newer messages are out of
        // visible range.
        animated: false,
      );
    }

    _isLoading = false;
  }
}
