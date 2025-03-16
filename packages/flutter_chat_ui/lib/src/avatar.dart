import 'package:cross_cache/cross_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  final String userId;
  final double? size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  const Avatar({
    super.key,
    required this.userId,
    this.size = 32,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final resolveUser = context.read<ResolveUserCallback>();
    final userCache = context.read<UserCache>();

    // Try to get from cache synchronously first
    final cachedUser = userCache.getSync(userId);

    if (cachedUser != null) {
      // Sync path - no FutureBuilder needed
      return _buildAvatar(context, theme, cachedUser);
    }

    // Async path - use FutureBuilder with cache
    return FutureBuilder<User?>(
      // This will update the cache when resolved
      future: userCache.getOrResolve(userId, resolveUser),
      builder: (context, snapshot) {
        return _buildAvatar(context, theme, snapshot.data);
      },
    );
  }

  Widget _buildAvatar(BuildContext context, ChatTheme theme, User? user) {
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.surfaceContainer,
        shape: BoxShape.circle,
      ),
      child: AvatarContent(
        user: user,
        size: size,
        foregroundColor: foregroundColor ?? theme.colors.onSurface,
        textStyle: theme.typography.labelLarge.copyWith(
          color: foregroundColor ?? theme.colors.onSurface,
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

class AvatarContent extends StatefulWidget {
  final User? user;
  final double? size;
  final Color foregroundColor;
  final TextStyle? textStyle;

  const AvatarContent({
    super.key,
    required this.user,
    required this.size,
    required this.foregroundColor,
    this.textStyle,
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
            ? CachedNetworkImage(widget.user!.imageSource!, crossCache)
            : null;
  }

  @override
  void didUpdateWidget(covariant AvatarContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user?.imageSource != widget.user?.imageSource) {
      if (widget.user?.imageSource != null) {
        final crossCache = context.read<CrossCache>();
        final newImage = CachedNetworkImage(
          widget.user!.imageSource!,
          crossCache,
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
    if (user?.firstName == null && user?.lastName == null) return '';

    final firstInitial =
        user?.firstName?.isNotEmpty == true ? user!.firstName![0] : '';
    final lastInitial =
        user?.lastName?.isNotEmpty == true ? user!.lastName![0] : '';

    return '$firstInitial$lastInitial'.toUpperCase();
  }
}
