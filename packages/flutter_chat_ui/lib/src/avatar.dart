import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// A widget that displays a user's avatar.
///
/// Fetches user data using the provided [userId] and [ResolveUserCallback].
/// Uses [UserCache] for efficient user data retrieval.
/// Displays the user's image if available, otherwise shows initials or a default icon.
class Avatar extends StatelessWidget {
  /// The ID of the user whose avatar is to be displayed.
  final UserID userId;

  /// The size (diameter) of the avatar circle.
  final double? size;

  /// Background color for the avatar circle if no image is available.
  final Color? backgroundColor;

  /// Foreground color for the initials text or default icon.
  final Color? foregroundColor;

  /// Optional callback triggered when the avatar is tapped.
  final VoidCallback? onTap;

  /// Optional HTTP headers for authenticated image requests.
  /// Commonly used for authorization tokens, e.g., {'Authorization': 'Bearer token'}.
  final Map<String, String>? headers;

  /// Creates an avatar widget.
  const Avatar({
    super.key,
    required this.userId,
    this.size = 32,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.headers,
  });

  @override
  Widget build(BuildContext context) {
    final resolveUser = context.read<ResolveUserCallback>();
    final userCache = context.watch<UserCache>();

    // Try to get from cache synchronously first
    final cachedUser = userCache.getSync(userId);

    if (cachedUser != null) {
      // Sync path - no FutureBuilder needed
      return _buildAvatar(context, cachedUser);
    }

    // Async path - use FutureBuilder with cache
    return FutureBuilder<User?>(
      // This will update the cache when resolved
      future: userCache.getOrResolve(userId, resolveUser),
      builder: (context, snapshot) {
        return _buildAvatar(context, snapshot.data);
      },
    );
  }

  Widget _buildAvatar(BuildContext context, User? user) {
    final theme = context.select(
      (ChatTheme t) => (
        labelLarge: t.typography.labelLarge,
        onSurface: t.colors.onSurface,
        surfaceContainer: t.colors.surfaceContainer,
      ),
    );

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.surfaceContainer,
        shape: BoxShape.circle,
      ),
      child: AvatarContent(
        user: user,
        size: size,
        foregroundColor: foregroundColor ?? theme.onSurface,
        headers: headers,
        textStyle: theme.labelLarge.copyWith(
          color: foregroundColor ?? theme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}

/// Internal widget responsible for rendering the actual avatar content
/// (image, initials, or icon) based on the resolved [User] data.
class AvatarContent extends StatefulWidget {
  /// The resolved user data (can be null if resolution fails or is pending).
  final User? user;

  /// The size (diameter) of the avatar.
  final double? size;

  /// The foreground color for initials or the default icon.
  final Color foregroundColor;

  /// The text style for the initials.
  final TextStyle? textStyle;

  /// Optional HTTP headers for authenticated image requests.
  /// Commonly used for authorization tokens, e.g., {'Authorization': 'Bearer token'}.
  final Map<String, String>? headers;

  /// Creates an [AvatarContent] widget.
  const AvatarContent({
    super.key,
    required this.user,
    required this.size,
    required this.foregroundColor,
    this.textStyle,
    this.headers,
  });

  @override
  State<AvatarContent> createState() => _AvatarContentState();
}

class _AvatarContentState extends State<AvatarContent> {
  late CachedNetworkImage? _cachedNetworkImage;

  @override
  void initState() {
    super.initState();

    final crossCache = context.read<CrossCache>();

    _cachedNetworkImage =
        widget.user?.imageSource != null
            ? CachedNetworkImage(
              widget.user!.imageSource!,
              crossCache,
              headers: widget.headers,
            )
            : null;
  }

  @override
  void didUpdateWidget(covariant AvatarContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user?.imageSource != widget.user?.imageSource ||
        oldWidget.headers != widget.headers) {
      if (widget.user?.imageSource != null) {
        final crossCache = context.read<CrossCache>();
        final newImage = CachedNetworkImage(
          widget.user!.imageSource!,
          crossCache,
          headers: widget.headers,
        );

        precacheImage(newImage, context).then((_) {
          if (mounted) {
            setState(() {
              _cachedNetworkImage = newImage;
            });
          }
        });
      } else {
        setState(() {
          _cachedNetworkImage = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedNetworkImage != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: _cachedNetworkImage!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    final initials = _getInitials(widget.user);
    if (initials.isNotEmpty) {
      return Center(child: Text(initials, style: widget.textStyle));
    }

    return Icon(Icons.person, color: widget.foregroundColor, size: 24);
  }

  String _getInitials(User? user) {
    if (user?.name == null || user!.name!.trim().isEmpty) return '';

    final nameParts = user.name!.trim().split(' ');
    final firstInitial = nameParts.isNotEmpty ? nameParts.first[0] : '';
    final lastInitial = nameParts.length > 1 ? nameParts.last[0] : '';

    return '$firstInitial$lastInitial'.toUpperCase();
  }
}
