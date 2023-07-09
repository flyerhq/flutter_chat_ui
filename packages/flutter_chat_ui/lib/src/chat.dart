import 'dart:ui';

import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'chat_animated_list.dart';
import 'chat_input.dart';
import 'chat_message.dart';
import 'utils/chat_input_height_notifier.dart';
import 'utils/typedefs.dart';

class Chat extends StatefulWidget {
  final String userId;
  final ChatController chatController;
  final Builders? builders;
  final CrossCache? crossCache;
  final ScrollController? scrollController;
  final ChatTheme? theme;
  final ChatTheme? darkTheme;
  final ThemeMode themeMode;
  final OnMessageSendCallback onMessageSend;
  final OnMessageTapCallback onMessageTap;
  final OnAttachmentTapCallback onAttachmentTap;

  const Chat({
    super.key,
    required this.userId,
    required this.chatController,
    this.builders,
    this.crossCache,
    this.scrollController,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.onMessageSend,
    this.onMessageTap,
    this.onAttachmentTap,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  late ChatTheme _theme;
  late Builders _builders;
  late CrossCache _crossCache;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateTheme();
    _builders = widget.builders ?? const Builders();
    _crossCache = widget.crossCache ?? CrossCache();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // Only try to dispose cross cache if it's not provided, since
    // users might want to keep downloading media even after the chat
    // is disposed.
    if (widget.crossCache == null) {
      _crossCache.dispose();
    }
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(_updateTheme);
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.theme != widget.theme ||
        oldWidget.darkTheme != widget.darkTheme) {
      _updateTheme(theme: _theme, darkTheme: _theme);
    }
  }

  void _updateTheme({ChatTheme? theme, ChatTheme? darkTheme}) {
    switch (widget.themeMode) {
      case ThemeMode.light:
        _theme = (theme ?? ChatTheme.light()).merge(widget.theme);
        break;
      case ThemeMode.dark:
        _theme = (darkTheme ?? ChatTheme.dark()).merge(widget.darkTheme);
        break;
      case ThemeMode.system:
        _theme =
            PlatformDispatcher.instance.platformBrightness == Brightness.dark
                ? (darkTheme ?? ChatTheme.dark()).merge(widget.darkTheme)
                : (theme ?? ChatTheme.light()).merge(widget.theme);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.userId),
        Provider.value(value: widget.chatController),
        Provider.value(value: _theme),
        Provider.value(value: _builders),
        Provider.value(value: _crossCache),
        Provider.value(value: widget.onMessageSend),
        Provider.value(value: widget.onMessageTap),
        Provider.value(value: widget.onAttachmentTap),
        ChangeNotifierProvider(create: (_) => ChatInputHeightNotifier()),
      ],
      child: ChatWidget(scrollController: _scrollController),
    );
  }
}

class ChatWidget extends StatelessWidget {
  final ScrollController scrollController;

  const ChatWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);

    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          ChatAnimatedList(
            scrollController: scrollController,
            itemBuilder: (_, animation, message, {bool? isRemoved}) =>
                ChatMessage(
              key: ValueKey(message),
              animation: animation,
              message: message,
              isRemoved: isRemoved,
            ),
          ),
          const ChatInputWidget(),
        ],
      ),
    );
  }
}
