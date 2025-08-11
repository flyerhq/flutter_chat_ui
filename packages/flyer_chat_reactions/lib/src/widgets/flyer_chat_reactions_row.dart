import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../helpers/chat_theme_extensions.dart';
import '../models/reaction.dart';
import '../utils/typedef.dart';
import 'reaction_tile.dart';

/// A widget that displays a row of reaction tiles with emojis and counts.
///
/// Handles layout and overflow of reactions, showing a surplus count when
/// there are more reactions than can fit in the available space.
class FlyerChatReactionsRow extends StatefulWidget {
  /// The reactions to display, mapped by emoji.
  final List<Reaction> reactions;

  /// Callback for when a reaction is tapped.
  final OnReactionTapCallback? onReactionTap;

  /// Callback for when a reaction is long pressed.
  final OnReactionLongPressCallback? onReactionLongPress;

  /// Callback when the surplus  is tapped.
  final VoidCallback? onSurplusReactionTap;

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

  /// Remove/Add on tap or not.
  /// If true, the reaction will be removed locally when tapped.
  final bool removeOrAddLocallyOnTap;

  /// Creates a widget that displays a row of reaction tiles.
  const FlyerChatReactionsRow({
    super.key,
    required this.reactions,
    this.onReactionTap,
    this.onReactionLongPress,
    this.onSurplusReactionTap,
    this.emojiTextStyle,
    this.countTextStyle,
    this.surplusTextStyle,
    this.spacing = 2,
    this.reactionTilePadding = const EdgeInsets.symmetric(horizontal: 4),
    this.borderColor,
    this.reactionBackgroundColor,
    this.reactionReactedBackgroundColor,
    this.alignment = MainAxisAlignment.start,
    this.removeOrAddLocallyOnTap = false,
  });

  @override
  State<FlyerChatReactionsRow> createState() => _FlyerChatReactionsRowState();
}

class _FlyerChatReactionsRowState extends State<FlyerChatReactionsRow> {
  /// List of calculated sizes for each reaction tile.
  final reactionsSizes = <Size>[];

  /// Calculates how many reactions can fit in the available width.
  ///
  /// Also updates [reactionsSizes] with the
  /// calculated sizes for each visible reaction.
  ///
  /// Returns the number of reactions that can be displayed.
  int calculateSizesAndMaxCapacity({
    required List<Reaction> reactions,
    required double stackWidth,
    required TextStyle emojiTextStyle,
    required TextStyle countTextStyle,
    required TextStyle extraTextStyle,
  }) {
    reactionsSizes.clear();
    double usedWidth = 0;
    var visibleCount = 0;
    final widgetCount = reactions.length;

    for (var i = 0; i < widgetCount; i++) {
      final nextSize = ReactionTileSizeHelper.calculatePreferredSize(
        emojiStyle: emojiTextStyle,
        countTextStyle: countTextStyle,
        extraTextStyle: extraTextStyle,
        emoji: reactions[i].emoji,
        countText: ReactionTileCountTextHelper.getCountString(
          reactions[i].count,
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

  @override
  Widget build(BuildContext context) {
    final validReactions = widget.reactions.where((r) => r.count > 0).toList();
    if (validReactions.isEmpty) {
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
          reactions: validReactions,
          stackWidth: stackWidth,
          emojiTextStyle: emojiTextStyle,
          countTextStyle: countTextStyle,
          extraTextStyle: extraTextStyle,
        );
        var visibleItemsCount = reactionsSizes.length;
        var hiddenCount = validReactions.length - maxCapacity;
        final souldDisplaySurplus = hiddenCount > 0;

        Size? surplusWidgetSize;
        if (souldDisplaySurplus) {
          surplusWidgetSize = ReactionTileSizeHelper.calculatePreferredSize(
            emojiStyle: emojiTextStyle,
            countTextStyle: countTextStyle,
            extraTextStyle: extraTextStyle,
            extraText: '+$hiddenCount',
          );
          maxCapacity = calculateSizesAndMaxCapacity(
            reactions: validReactions,
            stackWidth: stackWidth - surplusWidgetSize.width - widget.spacing,
            emojiTextStyle: emojiTextStyle,
            countTextStyle: countTextStyle,
            extraTextStyle: extraTextStyle,
          );

          visibleItemsCount = reactionsSizes.length;
          hiddenCount = validReactions.length - visibleItemsCount;
        }

        final children = <Widget>[];

        for (var i = 0; i < visibleItemsCount; i++) {
          children.add(
            ReactionTile(
              key: ValueKey(validReactions[i].emoji),
              width: reactionsSizes[i].width,
              emoji: validReactions[i].emoji,
              count: validReactions[i].count,
              countTextStyle: countTextStyle,
              emojiTextStyle: emojiTextStyle,
              borderColor: theme.reactionBorderColor,
              backgroundColor: backgroundColor,
              reactedBackgroundColor: reactedBackgroundColor,
              reactedByUser: validReactions[i].isReactedByUser,
              onTap: () {
                widget.onReactionTap?.call(validReactions[i].emoji);
              },
              onLongPress: () {
                widget.onReactionLongPress?.call(validReactions[i].emoji);
              },
              removeOrAddLocallyOnTap: widget.removeOrAddLocallyOnTap,
            ),
          );
        }

        if (surplusWidgetSize != null) {
          children.add(
            ReactionTile(
              key: const ValueKey('surplus'),
              width: surplusWidgetSize.width,
              extraText: '+$hiddenCount',
              backgroundColor: backgroundColor,
              reactedBackgroundColor: backgroundColor,
              extraTextStyle: extraTextStyle,
              borderColor: theme.reactionBorderColor,
              onTap: () {
                widget.onSurplusReactionTap?.call();
              },
              onLongPress: widget.onSurplusReactionTap,
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
