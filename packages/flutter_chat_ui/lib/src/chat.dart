import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'chat_animated_list/chat_animated_list.dart';
import 'chat_message/chat_message_internal.dart';
import 'composer.dart';
import 'utils/composer_height_notifier.dart';
import 'utils/load_more_notifier.dart';
import 'utils/typedefs.dart';

/// The main widget that orchestrates the chat UI.
///
/// Sets up necessary providers ([ChatController], [ChatTheme], [Builders], etc.)
/// and displays the chat list and composer.
class Chat extends StatefulWidget {
  /// The ID of the currently logged-in user.
  final UserID currentUserId;

  /// Callback to resolve a [User] object from a [UserID].
  /// Used for displaying user avatars and potentially names.
  final ResolveUserCallback resolveUser;

  /// The controller managing the chat message state.
  final ChatController chatController;

  /// Collection of custom builder functions for UI components.
  final Builders? builders;

  /// Cross-platform cache utility, primarily for images.
  /// If not provided, a default instance is created.
  final CrossCache? crossCache;

  /// Optional user-provided cache for resolved `User` objects.
  /// Ideally, you would not provide this and rely on the default internal LRU cache.
  /// However, you can supply your own instance if you need direct control to clear
  /// the cache for a specific user (e.g., when an avatar URL changes and requires a refresh).
  final UserCache? userCache;

  /// The visual theme for the chat UI.
  /// If not provided, defaults to [ChatTheme.light].
  final ChatTheme? theme;

  /// Callback triggered when the user attempts to send a message.
  final OnMessageSendCallback? onMessageSend;

  /// Callback triggered when a message is tapped.
  final OnMessageTapCallback? onMessageTap;

  /// Callback triggered when a message is long-pressed.
  final OnMessageLongPressCallback? onMessageLongPress;

  /// Callback triggered when the attachment button in the composer is tapped.
  final OnAttachmentTapCallback? onAttachmentTap;

  /// Background color for the main chat container.
  /// Overrides the color provided by [theme] if set.
  /// Ignored if [decoration] is provided.
  final Color? backgroundColor;

  /// Decoration for the main chat container.
  /// Overrides [backgroundColor].
  final Decoration? decoration;

  /// Date format for displaying message timestamps.
  /// Defaults to 'HH:mm' (e.g., 14:30).
  final DateFormat? timeFormat;

  /// Creates the main chat widget.
  const Chat({
    super.key,
    required this.currentUserId,
    required this.resolveUser,
    required this.chatController,
    this.builders,
    this.crossCache,
    this.userCache,
    this.theme,
    this.onMessageSend,
    this.onMessageTap,
    this.onMessageLongPress,
    this.onAttachmentTap,
    this.backgroundColor,
    this.decoration,
    this.timeFormat,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  late ChatTheme _theme;
  late Builders _builders;
  late final CrossCache _crossCache;
  late final UserCache _userCache;
  late DateFormat _timeFormat;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateTheme();
    _updateBuilders();
    _crossCache = widget.crossCache ?? CrossCache();
    _userCache = widget.userCache ?? UserCache(maxSize: 100);
    _timeFormat = widget.timeFormat ?? DateFormat('HH:mm');
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.theme != widget.theme) {
      _updateTheme();
    }

    if (oldWidget.builders != widget.builders) {
      _updateBuilders();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Only try to dispose cross cache if it's not provided, since
    // users might want to keep downloading media even after the chat
    // is disposed.
    if (widget.crossCache == null) {
      _crossCache.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.currentUserId),
        Provider.value(value: widget.resolveUser),
        Provider.value(value: widget.chatController),
        Provider.value(value: _theme),
        Provider.value(value: _builders),
        Provider.value(value: _crossCache),
        if (widget.userCache != null)
          ChangeNotifierProvider.value(value: _userCache)
        else
          ChangeNotifierProvider(create: (_) => _userCache),
        Provider.value(value: _timeFormat),
        Provider.value(value: widget.onMessageSend),
        Provider.value(value: widget.onMessageTap),
        Provider.value(value: widget.onMessageLongPress),
        Provider.value(value: widget.onAttachmentTap),
        ChangeNotifierProvider(create: (_) => ComposerHeightNotifier()),
        ChangeNotifierProvider(create: (_) => LoadMoreNotifier()),
      ],
      child: Container(
        color:
            widget.decoration != null
                ? null
                : (widget.backgroundColor ?? _theme.colors.surface),
        decoration: widget.decoration,
        child: Stack(
          children: [
            _builders.chatAnimatedListBuilder?.call(context, _buildItem) ??
                ChatAnimatedList(itemBuilder: _buildItem),
            _builders.composerBuilder?.call(context) ?? const Composer(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    Message message,
    int index,
    Animation<double> animation, {
    MessagesGroupingMode? messagesGroupingMode,
    int? messageGroupingTimeoutInSeconds,
    bool? isRemoved,
  }) {
    return ChatMessageInternal(
      key: ValueKey(message.id),
      message: message,
      index: index,
      animation: animation,
      messagesGroupingMode: messagesGroupingMode,
      messageGroupingTimeoutInSeconds: messageGroupingTimeoutInSeconds,
      isRemoved: isRemoved,
    );
  }

  void _updateTheme() {
    _theme = widget.theme ?? ChatTheme.light();
  }

  void _updateBuilders() {
    _builders = widget.builders ?? const Builders();
  }
}
