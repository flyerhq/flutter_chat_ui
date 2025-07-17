import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import 'helpers/chattheme_extensions.dart';
import 'models/reaction.dart';
import 'utils/typedef.dart';
import 'widgets/reaction_tile.dart';
import 'widgets/reactions_list.dart';

/// A widget that displays a row of reaction tiles with emojis and counts.
///
/// Handles layout and overflow of reactions, showing a surplus count when
/// there are more reactions than can fit in the available space.
class FlyerChatReactions extends StatefulWidget {
  /// The reactions to display, mapped by emoji.
  final MessageReactions? reactions;

  /// Callback for when a reaction is tapped.
  final OnMessageReactionCallback? onReactionTap;

  /// Font size for the emoji in reaction tiles.
  final TextStyle? emojiTextStyle;

  /// Text style for the count text in reaction tiles.
  /// Note that we use a FittedBox so if the text is too long, it will be scaled down.
  final TextStyle? countTextStyle;

  /// Text style for the surplus text in reaction tiles.
  /// Note that we use a FittedBox so if the text is too long, it will be scaled down.
  final TextStyle? surplusTextStyle;

  /// Space between reaction tiles.
  /// Defaults to 2.
  final double spacing;

  /// Inside padding for each [ReactionTile].
  /// Defaults to EdgeInsets.zero.
  final EdgeInsets reactionTilePadding;

  /// Color of the border around reaction tiles.
  /// If null, uses the default theme color.
  final Color? borderColor;

  /// Background color for reaction tiles when not reacted by the user.
  /// If null, uses the default theme color.
  final Color? reactionBackgroundColor;

  /// Background color for reaction tiles when reacted by the user.
  /// If null, uses the default theme color.
  final Color? reactionReactedBackgroundColor;

  /// Alignment of the reactions row
  final MainAxisAlignment alignment;

  /// Creates a widget that displays a row of reaction tiles.
  const FlyerChatReactions({
    super.key,
    this.reactions,
    this.onReactionTap,
    this.emojiTextStyle,
    this.countTextStyle,
    this.surplusTextStyle,
    this.spacing = 2,
    this.reactionTilePadding = const EdgeInsets.symmetric(horizontal: 4),
    this.borderColor,
    this.reactionBackgroundColor,
    this.reactionReactedBackgroundColor,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  State<FlyerChatReactions> createState() => _FlyerChatReactionsState();
}

class _FlyerChatReactionsState extends State<FlyerChatReactions> {
  /// Text style for the count text, initialized with default or provided style.

  /// List of reactions to display, processed from the input reactions.
  late List<Reaction> _reactions;

  /// List of calculated sizes for each reaction tile.
  final reactionsSizes = <Size>[];

  /// Calculates how many reactions can fit in the available width.
  ///
  /// Also updates [reactionsSizes] with the
  /// calculated sizes for each visible reaction.
  ///
  /// Returns the number of reactions that can be displayed.
  int calculateSizesAndMaxCapacity(
    double stackWidth, {
    required TextStyle emojiTextStyle,
    required TextStyle countTextStyle,
    required TextStyle extraTextStyle,
  }) {
    reactionsSizes.clear();
    double usedWidth = 0;
    var visibleCount = 0;
    final widgetCount = _reactions.length;

    for (var i = 0; i < widgetCount; i++) {
      final nextSize = ReactionTileSizeHelper.calculatePrefferedSize(
        emojiStyle: emojiTextStyle,
        countTextStyle: countTextStyle,
        extraTextStyle: extraTextStyle,
        emoji: _reactions[i].emoji,
        countText: ReactionTileCountTextHelper.getCountString(
          _reactions[i].count,
        ),
      );
      final spaceNeeded =
          usedWidth + nextSize.width + (visibleCount > 0 ? widget.spacing : 0);
      if (spaceNeeded < stackWidth) {
        usedWidth = spaceNeeded;
        visibleCount++;
        reactionsSizes.add(nextSize);
      } else {
        break;
      }
    }
    return visibleCount;
  }

  void _showReactionList() {
    showReactionsList(
      context: context,
      reactions: _reactions,
      resolveUser: context.read<ResolveUserCallback>(),
      userCache: context.read<UserCache>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reactions == null || widget.reactions!.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = context.read<ChatTheme>();
    final emojiTextStyle = ReactionTileStyleResolver.resolveEmojiTextStyle(
      provided: widget.emojiTextStyle,
      theme: theme,
    );
    final countTextStyle = ReactionTileStyleResolver.resolveCountTextStyle(
      provided: widget.countTextStyle,
      theme: theme,
    );
    final extraTextStyle = ReactionTileStyleResolver.resolveExtraTextStyle(
      provided: widget.surplusTextStyle,
      theme: theme,
    );
    final currentUserId = context.read<UserID>();

    _reactions = reactionsFromMessageReactions(
      reactions: widget.reactions ?? {},
      currentUserId: currentUserId,
    );

    final reactedBackgroundColor =
        widget.reactionReactedBackgroundColor ??
        theme.reactionReactedBackgroundColor;
    final backgroundColor =
        widget.reactionBackgroundColor ?? theme.reactionBackgroundColor;

    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        final isNotEnoughSpace =
            constraints.maxWidth <= 0 || constraints.maxHeight <= 0;
        if (isNotEnoughSpace) {
          return const SizedBox.shrink();
        }

        final stackWidth = constraints.maxWidth;
        var maxCapacity = calculateSizesAndMaxCapacity(
          stackWidth,
          emojiTextStyle: emojiTextStyle,
          countTextStyle: countTextStyle,
          extraTextStyle: extraTextStyle,
        );
        var visibleItemsCount = reactionsSizes.length;
        var hiddenCount = _reactions.length - maxCapacity;
        final souldDisplaySurplus = hiddenCount > 0;

        Size? surplusWidgetSize;
        if (souldDisplaySurplus) {
          surplusWidgetSize = ReactionTileSizeHelper.calculatePrefferedSize(
            emojiStyle: emojiTextStyle,
            countTextStyle: countTextStyle,
            extraTextStyle: extraTextStyle,
            extraText: '+$hiddenCount',
          );
          maxCapacity = calculateSizesAndMaxCapacity(
            stackWidth - surplusWidgetSize.width - widget.spacing,
            emojiTextStyle: emojiTextStyle,
            countTextStyle: countTextStyle,
            extraTextStyle: extraTextStyle,
          );

          visibleItemsCount = reactionsSizes.length;
          hiddenCount = _reactions.length - visibleItemsCount;
        }

        final children = <Widget>[];

        for (var i = 0; i < visibleItemsCount; i++) {
          children.add(
            ReactionTile(
              width: reactionsSizes[i].width,
              emoji: _reactions[i].emoji,
              count: _reactions[i].count,
              countTextStyle: countTextStyle,
              emojiTextStyle: emojiTextStyle,
              borderColor: theme.reactionBorderColor,
              backgroundColor: backgroundColor,
              reactedBackgroundColor: reactedBackgroundColor,
              reactedByUser: _reactions[i].isReactedByUser(currentUserId),
              onTap: () {
                widget.onReactionTap?.call(_reactions[i].emoji);
              },
              onLongPress: () => _showReactionList,
            ),
          );
        }

        if (surplusWidgetSize != null) {
          children.add(
            ReactionTile(
              width: surplusWidgetSize.width,
              extraText: '+$hiddenCount',
              backgroundColor: backgroundColor,
              extraTextStyle: extraTextStyle,
              borderColor: theme.reactionBorderColor,
              onTap: _showReactionList,
              onLongPress: _showReactionList,
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: widget.alignment,
              mainAxisSize: MainAxisSize.max,
              children: children,
            ),
          ],
        );
      },
    );
  }
}
