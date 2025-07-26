import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import 'pagination_mock_database.dart';
import 'widgets/composer_action_bar.dart';

class PaginationOlder extends StatefulWidget {
  const PaginationOlder({super.key});

  @override
  PaginationOlderState createState() => PaginationOlderState();
}

class PaginationOlderState extends State<PaginationOlder> {
  final _chatController = InMemoryChatController(
    messages: List.from(MockDatabase.initialNewerMessages),
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
      appBar: AppBar(title: const Text('Pagination (get older)')),
      body: Chat(
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedList(
              itemBuilder: itemBuilder,
              onEndReached: _loadOlderMessages,
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

  Future<void> _loadOlderMessages() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;

    final messages = await MockDatabase.getOlderMessages(
      limit: 20,
      lastMessageId: _lastMessageId,
    );

    if (messages.isEmpty) {
      _hasMore = false;
      _isLoading = false;
      return;
    }

    await _chatController.insertAllMessages(
      messages,
      index: 0,
      // Important: we don't want to animate the insertion of the messages
      // because pagination logic relies on messages to be inserted instantly.
      // There is no need for animation anyway as all older messages are out of
      // visible range.
      animated: false,
    );
    _lastMessageId = messages.first.id;
    _isLoading = false;
  }

  /// Scrolls to a specific message ID, loading necessary pages first if needed
  Future<void> _scrollToMessage(MessageID messageId) async {
    // First check if the message is already loaded
    var messageExists = _chatController.messages.any((m) => m.id == messageId);

    if (messageExists) {
      // Message is already loaded, scroll to it directly
      // If the list is reversed, we might need to add an offset that
      // is equal to the height of the chat composer (not including the safe area).
      // For this example it would be 60.
      await _chatController.scrollToMessage(messageId, offset: 0);
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

    while (!messageExists && _hasMore) {
      await _loadOlderMessages();

      // Check if message is now loaded
      messageExists = _chatController.messages.any((m) => m.id == messageId);
    }

    // Dismiss loaded information
    scaffoldMessenger.hideCurrentSnackBar();

    // If the list is reversed, we might need to add an offset that
    // is equal to the height of the chat composer (not including the safe area).
    // For this example it would be 60.
    await _chatController.scrollToMessage(messageId, offset: 0);
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
