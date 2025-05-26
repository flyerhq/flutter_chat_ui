import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// A widget that displays a user's name.
///
/// Fetches user data using the provided [userId] and [ResolveUserCallback].
/// Uses [UserCache] for efficient user data retrieval.
/// Displays the user's name if available, otherwise an empty string.
class Username extends StatelessWidget {
  /// The ID of the user whose name is to be displayed.
  final UserID userId;

  /// Optional text style for the username.
  final TextStyle? style;

  /// Creates a username widget.
  const Username({super.key, required this.userId, this.style});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final resolveUser = context.read<ResolveUserCallback>();
    final userCache = context.watch<UserCache>();

    // Try to get from cache synchronously first
    final cachedUser = userCache.getSync(userId);

    if (cachedUser != null) {
      // Sync path - no FutureBuilder needed
      return _buildUsername(context, theme, cachedUser);
    }

    // Async path - use FutureBuilder with cache
    return FutureBuilder<User?>(
      // This will update the cache when resolved
      future: userCache.getOrResolve(userId, resolveUser),
      builder: (context, snapshot) {
        return _buildUsername(context, theme, snapshot.data);
      },
    );
  }

  Widget _buildUsername(BuildContext context, ChatTheme theme, User? user) {
    final defaultStyle = theme.typography.labelMedium.copyWith(
      color: theme.colors.onSurface,
    );

    return Text(user?.name ?? '', style: style ?? defaultStyle);
  }
}
