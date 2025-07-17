import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import '../models/reaction.dart';

/// Theme values for [ReactionsList].
typedef _LocalTheme =
    ({
      Color backgroundColor,
      Color selectedFilterChipColor,
      Color unselectedFilterChipColor,
      TextStyle filterChipTextStyle,
      TextStyle listEmojiTextStyle,
      TextStyle listCountTextStyle,
      TextStyle listUsernamesTextStyle,
    });

/// A widget that displays a list of users and their reactions in a bottom sheet.
///
/// Used to show who reacted with which emoji, typically shown when long-pressing
/// a reaction tile.
class ReactionsList extends StatefulWidget {
  /// The list of reactions to display.
  final List<Reaction> reactions;

  /// The config for the reactions list.
  final ReactionListStyleConfig styleConfig;

  /// Creates a widget that displays a list of users and their reactions.
  const ReactionsList({
    super.key,
    required this.reactions,
    this.styleConfig = const ReactionListStyleConfig(),
  });

  @override
  State<ReactionsList> createState() => _ReactionsListState();
}

class _ReactionsListState extends State<ReactionsList> {
  String? selectedEmoji;
  late Future<Map<String, String>> _userNamesFuture;

  @override
  void initState() {
    super.initState();
    _initUserNamesFuture();
  }

  @override
  void didUpdateWidget(covariant ReactionsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reactions != widget.reactions) {
      _initUserNamesFuture();
    }
  }

  void _initUserNamesFuture() {
    final resolveUser = context.read<ResolveUserCallback>();
    final userCache = context.read<UserCache>();
    _userNamesFuture = _resolveUserNames(context, resolveUser, userCache);
  }

  Future<Map<String, String>> _resolveUserNames(
    BuildContext context,
    ResolveUserCallback resolveUser,
    UserCache userCache,
  ) async {
    final userMap = <String, String>{};
    for (final reaction in widget.reactions) {
      for (final userId in reaction.userIds) {
        if (!userMap.containsKey(userId)) {
          final resolvedUser = await userCache.getOrResolve(
            userId,
            resolveUser,
          );
          userMap[userId] = resolvedUser?.name ?? userId;
        }
      }
    }
    return userMap;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        backgroundColor: widget.styleConfig.backgroundColor ?? t.colors.surface,
        selectedFilterChipColor:
            widget.styleConfig.filterChipsSelectedColor ??
            t.colors.onPrimary.withValues(alpha: 0.2),
        unselectedFilterChipColor:
            widget.styleConfig.filterChipsUnselectedColor ??
            t.colors.onSurface.withValues(alpha: 0.2),
        filterChipTextStyle:
            widget.styleConfig.filterChipsTextStyles ?? t.typography.bodyMedium,
        listEmojiTextStyle:
            widget.styleConfig.listEmojiTextStyle ?? t.typography.bodyMedium,
        listCountTextStyle:
            widget.styleConfig.listCountTextStyle ?? t.typography.bodyMedium,
        listUsernamesTextStyle:
            widget.styleConfig.listUsernamesTextStyle ??
            t.typography.bodyMedium,
      ),
    );

    final filteredReactions =
        selectedEmoji == null
            ? widget.reactions
            : widget.reactions.where((r) => r.emoji == selectedEmoji).toList();

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildChip(
                  label: Text(
                    '${widget.styleConfig.allFilterChipLabel} • ${widget.reactions.length}',
                  ),
                  theme: theme,
                  selected: selectedEmoji == null,
                  onSelected: (selected) {
                    setState(() {
                      selectedEmoji = null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ...widget.reactions.map(
                  (reaction) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(reaction.emoji),
                          const SizedBox(width: 4),
                          Text('${reaction.count}'),
                        ],
                      ),
                      theme: theme,
                      selected: selectedEmoji == reaction.emoji,
                      onSelected: (selected) {
                        setState(() {
                          selectedEmoji = selected ? reaction.emoji : null;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Reactions list
          Flexible(
            child: FutureBuilder<Map<String, String>>(
              future: _userNamesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final userMap = snapshot.data ?? {};

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredReactions.length,
                    itemBuilder: (context, index) {
                      final reaction = filteredReactions[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Row(
                              children: [
                                Text(
                                  reaction.emoji,
                                  style: widget.styleConfig.listEmojiTextStyle,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${reaction.count}',
                                  style: widget.styleConfig.listCountTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 4,
                            ),
                            child: Text(
                              reaction.userIds
                                  .map((userId) => userMap[userId] ?? userId)
                                  .join(', '),
                              style: theme.listUsernamesTextStyle,
                            ),
                          ),
                          if (index < filteredReactions.length - 1)
                            Divider(
                              height: 1,
                              color: theme.unselectedFilterChipColor.withValues(
                                alpha: 0.2,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required Widget label,
    required _LocalTheme theme,
    void Function(bool)? onSelected,
    required bool selected,
  }) {
    return FilterChip(
      label: label,
      showCheckmark: false,
      selectedColor: theme.selectedFilterChipColor,
      backgroundColor: theme.backgroundColor,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide.none,
      onSelected: onSelected,
      selected: selected,
    );
  }
}

/// Shows a bottom sheet with the list of reactions.
/// Must be called with a context from the Chat for providers to be available.
Future<void> showReactionsList({
  required BuildContext context,
  required List<Reaction> reactions,
  ReactionListStyleConfig? styleConfig,
}) {
  final providers = ChatProviders.from(context);
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder:
        (context) => MultiProvider(
          providers: providers,
          child: ReactionsList(
            reactions: reactions,
            styleConfig: styleConfig ?? const ReactionListStyleConfig(),
          ),
        ),
  );
}

class ReactionListStyleConfig {
  /// Label for All filter chips. Default is 'All'
  final String allFilterChipLabel;

  /// The style for the user ID text.
  final TextStyle? listUsernamesTextStyle;

  /// The style for the filter chips text.
  final TextStyle? filterChipsTextStyles;

  /// The background color for selected filter chips.
  final Color? filterChipsSelectedColor;

  /// The background color for unselected filter chips.
  final Color? filterChipsUnselectedColor;

  /// The style for the header title text.
  final TextStyle? headerTitleTextStyle;

  /// The style for the header count text.
  final TextStyle? headerCountTextStyle;

  /// Font size for the emoji in reaction tiles.
  final TextStyle? listEmojiTextStyle;

  /// The style for the reaction count text.
  final TextStyle? listCountTextStyle;

  /// Background color for the bottom sheet.
  final Color? backgroundColor;

  const ReactionListStyleConfig({
    this.allFilterChipLabel = 'All',
    this.listUsernamesTextStyle,
    this.filterChipsTextStyles,
    this.filterChipsSelectedColor,
    this.filterChipsUnselectedColor,
    this.headerTitleTextStyle,
    this.headerCountTextStyle,
    this.listEmojiTextStyle,
    this.listCountTextStyle,
    this.backgroundColor,
  });
}
