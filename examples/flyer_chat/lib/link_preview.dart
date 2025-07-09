import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_link_preview/flyer_chat_link_preview.dart';
import 'package:uuid/uuid.dart';

class LinkPreviewExample extends StatefulWidget {
  final Dio dio;

  const LinkPreviewExample({super.key, required this.dio});

  @override
  LinkPreviewExampleState createState() => LinkPreviewExampleState();
}

class LinkPreviewExampleState extends State<LinkPreviewExample> {
  final _chatController = InMemoryChatController();

  final _currentUser = const User(
    id: 'me',
    imageSource: 'https://picsum.photos/id/65/200/200',
  );

  final metadataLinkPreviewFetchedKey = 'linkPreviewDataFetched';

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chatController.setMessages([
      Message.text(
        id: 'not-fetched',
        authorId: _currentUser.id,
        text: 'https://flyer.chat/ Not fetchet yet',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 1)),
      ),
      Message.text(
        id: 'wont-fetch',
        authorId: _currentUser.id,
        text: 'https://flyer.chat/ Will not fetch',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 2)),
        metadata: {metadataLinkPreviewFetchedKey: true},
      ),
      Message.text(
        id: 'complete',
        authorId: 'someone',
        text: 'https://flyer.chat/ Already fetched',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 3)),
        linkPreviewData: LinkPreviewData(
          link: 'https://flyer.chat/',
          description:
              'Open-source chat SDK for Flutter and React Native. Build fast, real-time apps and AI agents with a high-performance, customizable, cross-platform UI.',
          image: ImagePreviewData(
            url: 'https://flyer.chat/og-image.png',
            width: 1200.0,
            height: 630.0,
          ),
          title: 'Flyer Chat | Ship faster with a go-to chat SDK',
        ),
      ),

      Message.text(
        id: 'display-only-image',
        authorId: _currentUser.id,
        text: 'https://flyer.chat/ Display only the image',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 4)),
        linkPreviewData: LinkPreviewData(
          link: 'https://flyer.chat/',
          description:
              'Open-source chat SDK for Flutter and React Native. Build fast, real-time apps and AI agents with a high-performance, customizable, cross-platform UI.',
          image: ImagePreviewData(
            url: 'https://flyer.chat/og-image.png',
            width: 1200.0,
            height: 630.0,
          ),
          title: 'Flyer Chat | Ship faster with a go-to chat SDK',
        ),
      ),
      Message.text(
        id: 'fake-square',
        authorId: _currentUser.id,
        text: 'https://flyer.chat/ Fake square image',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 5)),
        linkPreviewData: LinkPreviewData(
          link: 'https://flyer.chat/',
          description:
              'Open-source chat SDK for Flutter and React Native. Build fast, real-time apps and AI agents with a high-performance, customizable, cross-platform UI.',
          image: ImagePreviewData(
            url: 'https://flyer.chat/og-image.png',
            width: 1200.0,
            height: 1200.0,
          ),
          title: 'Flyer Chat | Ship faster with a go-to chat SDK',
        ),
      ),
      Message.text(
        id: 'image-content',
        authorId: _currentUser.id,
        text: 'https://flyer.chat/og-image.png This is an image link',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 6)),
      ),
      Message.text(
        id: 'short one',
        authorId: _currentUser.id,
        text: 'Fake short one',
        createdAt: DateTime.now().toUtc().subtract(const Duration(hours: 5)),
        linkPreviewData: LinkPreviewData(
          link: 'https://flyer.chat/',
          description: 'Open-source chat SDK',
          image: ImagePreviewData(
            url: 'https://flyer.chat/og-image.png',
            width: 1200.0,
            height: 1200.0,
          ),
          title: 'Flyer Chat',
        ),
      ),
    ]);
  }

  void _addItem(String? text) async {
    if (text == null || text.isEmpty) {
      return;
    }

    final message = Message.text(
      id: Uuid().v4(),
      authorId: _currentUser.id,
      text: text,
      createdAt: DateTime.now().toUtc().subtract(const Duration(seconds: 1)),
    );

    if (mounted) {
      await _chatController.insertMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatTheme =
        theme.brightness == Brightness.dark
            ? ChatTheme.dark()
            : ChatTheme.light();

    return Scaffold(
      appBar: AppBar(title: const Text('LinkPreview')),
      body: Chat(
        backgroundColor: Colors.transparent,
        builders: Builders(
          linkPreviewBuilder: (context, message, isSentByMe) {
            final isLinkPreviewDataFetched =
                message.metadata?.containsKey(metadataLinkPreviewFetchedKey) ??
                false;

            // It's up to you to (optionally) implement the logic to avoid every
            // client to eventually refetch the preview data
            //
            // For example, you can use a metadata to indicate if the preview
            // was already fetched (and null).
            //
            // You could also store a data and implement some retry/refresh logic.
            //

            if (message.linkPreviewData != null || !isLinkPreviewDataFetched) {
              return LinkPreview(
                text: message.text,
                linkPreviewData: message.linkPreviewData,
                hideDescription: message.id == 'display-only-image',
                hideTitle: message.id == 'display-only-image',
                backgroundColor:
                    isSentByMe
                        ? Colors.white.withAlpha(100)
                        : chatTheme.colors.primary.withAlpha(100),
                sideBorderColor:
                    isSentByMe ? Colors.white : chatTheme.colors.primary,
                onLinkPreviewDataFetched: (linkPreviewData) {
                  _chatController.updateMessage(
                    message,
                    message.copyWith(
                      metadata: {
                        ...message.metadata ?? {},
                        metadataLinkPreviewFetchedKey: true,
                      },
                      linkPreviewData: linkPreviewData,
                    ),
                  );
                },
              );
            }
            return null;
          },
        ),
        onMessageSend: (text) {
          _addItem(text);
        },
        chatController: _chatController,
        currentUserId: _currentUser.id,

        resolveUser:
            (id) => Future.value(switch (id) {
              'me' => _currentUser,
              _ => null,
            }),
        theme: chatTheme,
      ),
    );
  }
}
