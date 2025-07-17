import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import 'helpers/chattheme_extensions.dart';
import 'helpers/reaction_text.dart';
import 'helpers/text_size_extension.dart';
import 'models/reaction.dart';
import 'widgets/reaction_tile.dart';
import 'widgets/reactions_list.dart';

/// Direction in which the reactions will grow when there are multiple reactions.
enum FlyerChatReactionsGrowDirection { left, right }

/// A widget that displays a row of reaction tiles with emojis and counts.
///
/// Handles layout and overflow of reactions, showing a surplus count when
/// there are more reactions than can fit in the available space.
class FlyerChatReactions extends StatefulWidget {
  /// The reactions to display, mapped by emoji.
  final MessageReactions? reactions;

  /// Font size for the emoji in reaction tiles.
  /// If null, uses the default size.
  final double? emojiFontSize;

  /// Text style for the count text in reaction tiles.
  /// If null, uses the default style.
  final TextStyle? countTextStyle;

  /// Direction in which reactions will grow when there are multiple reactions.
  /// Defaults to [FlyerChatReactionsGrowDirection.right].
  final FlyerChatReactionsGrowDirection growDirection;

  /// Space between reaction tiles.
  /// Defaults to 2.
  final double spacing;

  /// Padding for each reaction tile.
  /// Defaults to EdgeInsets.zero.
  final EdgeInsets reactionTilePadding;

  /// Minimum width for each reaction tile.
  final double? minimumReactionTileWidth;

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
    this.emojiFontSize,
    this.countTextStyle,
    this.spacing = 2,
    this.reactionTilePadding = EdgeInsets.zero,
    this.minimumReactionTileWidth = 40,
    this.borderColor,
    this.growDirection = FlyerChatReactionsGrowDirection.left,
    this.reactionBackgroundColor,
    this.reactionReactedBackgroundColor,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  State<FlyerChatReactions> createState() => _FlyerChatReactionsState();
}

class _FlyerChatReactionsState extends State<FlyerChatReactions> {
  /// Text style for the count text, initialized with default or provided style.
  late final TextStyle _countTextStyle;

  /// List of reactions to display, processed from the input reactions.
  late List<Reaction> _reactions;

  /// List of calculated sizes for each reaction tile.
  final reactionsSizes = <Size>[];

  /// Maximum height among all reaction tiles.
  double maxReactionHeight = 0;

  /// Estimates the size needed for a reaction tile based on its content.
  Size estimateReactionTileSizeUsingPainter({
    required String? emoji,
    required String? text,
  }) {
    var emojiSize = Size(0, 0);
    if (emoji != null) {
      emojiSize = emoji.getPaintedSize(
        context,
        TextStyle(fontSize: widget.emojiFontSize),
      );
    }
    final height = emojiSize.height;

    Size? textSize;
    if (text != null && text.isNotEmpty) {
      textSize = text.getPaintedSize(context, _countTextStyle);
    }
    final isOnlyEmoji = text == null || text.isEmpty;
    final totalWidth =
        widget.reactionTilePadding.horizontal +
        emojiSize.width +
        (isOnlyEmoji ? 2.5 : 0) + // Emoji offset fix
        (textSize?.width ?? 0) +
        4; // Safety margin for pixel rounding
    final maxHeight = max(height, textSize?.height ?? 0);
    final totalHeight = widget.reactionTilePadding.vertical + maxHeight;

    return Size(
      max(totalWidth, widget.minimumReactionTileWidth ?? 0),
      totalHeight,
    );
  }

  /// Calculates how many reactions can fit in the available width.
  ///
  /// Also updates [reactionsSizes] and [maxReactionHeight] with the
  /// calculated sizes for each visible reaction.
  ///
  /// Returns the number of reactions that can be displayed.
  int calculateSizesAndMaxCapacity(double stackWidth) {
    reactionsSizes.clear();
    double usedWidth = 0;
    var visibleCount = 0;
    final widgetCount = _reactions.length;

    for (var i = 0; i < widgetCount; i++) {
      final nextSize = estimateReactionTileSizeUsingPainter(
        emoji: _reactions[i].emoji,
        text: getReactionText(_reactions[i].count),
      );
      final spaceNeeded =
          usedWidth + nextSize.width + (visibleCount > 0 ? widget.spacing : 0);
      if (spaceNeeded < stackWidth) {
        usedWidth = spaceNeeded;
        visibleCount++;
        reactionsSizes.add(nextSize);
        maxReactionHeight = max(maxReactionHeight, nextSize.height);
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
  void initState() {
    super.initState();
    _countTextStyle = _resolveCountTextStyle();
  }

  TextStyle _resolveCountTextStyle() {
    if (widget.countTextStyle != null) {
      return widget.countTextStyle!;
    }

    final theme = context.read<ChatTheme>();
    return TextStyle(
      fontSize: theme.reactionCountTextFontSize ?? 10,
      fontWeight: FontWeight.bold,
      color: theme.reactionCountTextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ChatTheme>();
    final currentUserId = context.watch<UserID>();
    final onReactionTap = context.read<OnMessageReactionCallback?>();
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

        var maxCapacity = calculateSizesAndMaxCapacity(stackWidth);
        var visibleItemsCount = reactionsSizes.length;
        var hiddenCount = _reactions.length - maxCapacity;
        final souldDisplaySurplus = hiddenCount > 0;

        Size? surplusWidgetSize;
        if (souldDisplaySurplus) {
          surplusWidgetSize = estimateReactionTileSizeUsingPainter(
            emoji: null,
            text: '+$hiddenCount',
          );
          maxCapacity = calculateSizesAndMaxCapacity(
            stackWidth - surplusWidgetSize.width - widget.spacing,
          );

          visibleItemsCount = reactionsSizes.length;
          hiddenCount = _reactions.length - visibleItemsCount;
        }

        final children = <Widget>[];

        for (var i = 0; i < visibleItemsCount; i++) {
          if (i > 0) children.add(SizedBox(width: widget.spacing));
          children.add(
            ReactionTile(
              width: reactionsSizes[i].width,
              height: maxReactionHeight,
              emoji: _reactions[i].emoji,
              count: _reactions[i].count,
              padding: widget.reactionTilePadding,
              textStyle: _countTextStyle,
              emojiFontSize: widget.emojiFontSize,
              borderColor: theme.reactionBorderColor,
              backgroundColor: backgroundColor,
              reactedBackgroundColor: reactedBackgroundColor,
              reactedByUser: _reactions[i].isReactedByUser(currentUserId),
              onTap: () {
                onReactionTap?.call(1, _reactions[i].emoji);
              },
              onLongPress: () => _showReactionList,
            ),
          );
        }

        if (souldDisplaySurplus) {
          children.add(SizedBox(width: widget.spacing));
          children.add(
            ReactionTile(
              width: surplusWidgetSize!.width,
              height: maxReactionHeight,
              emoji: null,
              extraText: '+$hiddenCount',
              padding: widget.reactionTilePadding,
              backgroundColor: backgroundColor,
              reactedBackgroundColor: reactedBackgroundColor,
              reactedByUser: false,
              textStyle: _countTextStyle,
              emojiFontSize: widget.emojiFontSize,
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
