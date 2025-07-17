import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

import '../models/reaction.dart';

/// A widget that displays a list of users and their reactions in a bottom sheet.
///
/// Used to show who reacted with which emoji, typically shown when long-pressing
/// a reaction tile.
class ReactionsList extends StatefulWidget {
  /// The list of reactions to display.
  final List<Reaction> reactions;

  /// The style for the user ID text.
  final TextStyle? userTextStyle;

  /// The style for the reaction count text.
  final TextStyle? countTextStyle;

  /// Font size for the emoji in reaction tiles.
  final double? emojiFontSize;

  /// Background color for the bottom sheet.
  final Color? backgroundColor;

  /// Callback to resolve user names.
  final ResolveUserCallback? resolveUser;

  /// Cache for user names.
  final UserCache? userCache;

  /// Creates a widget that displays a list of users and their reactions.
  const ReactionsList({
    super.key,
    required this.reactions,
    this.userTextStyle,
    this.countTextStyle,
    this.emojiFontSize,
    this.backgroundColor,
    this.resolveUser,
    this.userCache,
  });

  @override
  State<ReactionsList> createState() => _ReactionsListState();
}

class _ReactionsListState extends State<ReactionsList> {
  String? selectedEmoji;

  Future<Map<String, String>> _resolveUserNames(BuildContext context) async {
    final userMap = <String, String>{};
    for (final reaction in widget.reactions) {
      for (final userId in reaction.userIds) {
        if (!userMap.containsKey(userId) && widget.resolveUser != null) {
          final resolvedUser = await widget.userCache?.getOrResolve(
            userId,
            widget.resolveUser!,
          );
          userMap[userId] = resolvedUser?.name ?? userId;
        }
      }
    }
    return userMap;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredReactions =
        selectedEmoji == null
            ? widget.reactions
            : widget.reactions.where((r) => r.emoji == selectedEmoji).toList();

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Text('Reactions', style: theme.textTheme.titleMedium),
                const Spacer(),
                Text(
                  '${widget.reactions.fold(0, (sum, r) => sum + r.count)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
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
                    child: FilterChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(reaction.emoji),
                          const SizedBox(width: 4),
                          Text('${reaction.count}'),
                        ],
                      ),
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
              future: _resolveUserNames(context),
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
                                  style: TextStyle(
                                    fontSize: widget.emojiFontSize,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${reaction.count}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
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
                              style:
                                  widget.userTextStyle ??
                                  theme.textTheme.bodyMedium,
                            ),
                          ),
                          if (index < filteredReactions.length - 1)
                            Divider(
                              height: 1,
                              color: theme.colorScheme.outline.withAlpha(60),
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
}

/// Shows a bottom sheet with the list of reactions.
Future<void> showReactionsList({
  required BuildContext context,
  required List<Reaction> reactions,
  TextStyle? userTextStyle,
  TextStyle? countTextStyle,
  double? emojiFontSize,
  Color? backgroundColor,
  ResolveUserCallback? resolveUser,
  UserCache? userCache,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder:
        (context) => ReactionsList(
          reactions: reactions,
          userTextStyle: userTextStyle,
          countTextStyle: countTextStyle,
          emojiFontSize: emojiFontSize,
          backgroundColor: backgroundColor,
          resolveUser: resolveUser,
          userCache: userCache,
        ),
  );
}
