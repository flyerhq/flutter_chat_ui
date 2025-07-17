import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

import '../helpers/chattheme_extensions.dart';

/// A widget that displays a reaction with an emoji and optional count.
///
/// Used to show individual reactions in the chat interface, supporting both
/// single emoji reactions, reactions with counts or a text (for surplus)

class ReactionTile extends StatefulWidget {
  /// The emoji to display as the reaction.
  final String? emoji;

  /// The count of reactions for this emoji.
  /// If null, the count is not shown.
  /// If 0, the tile is not shown.
  final int? count;

  /// The text to display, after the count text or alone.
  /// Typically used for surplus reactions.
  final String? extraText;

  /// Whether this reaction was added by the current user.
  /// Affects the visual styling of the tile.
  final bool reactedByUser;

  /// Callback triggered when the reaction tile is tapped.
  /// Used to handle reaction selection/deselection.
  final VoidCallback? onTap;

  /// Callback triggered when the reaction tile is long pressed.
  /// Used to handle additional actions like showing a menu or details.
  final VoidCallback? onLongPress;

  /// Background color for the reaction tile when not reacted by the user.
  final Color? backgroundColor;

  /// Background color for the reaction tile when reacted by the user.
  final Color? reactedBackgroundColor;

  /// Color of the border around the reaction tile.
  final Color? borderColor;

  /// Text style for the count text and extra text.
  final TextStyle? countTextStyle;

  /// Text style for the surplus text.
  final TextStyle? extraTextStyle;

  /// Text style for the emoji.
  final TextStyle? emojiTextStyle;

  /// Space between the emoji and the count text.
  /// Defaults to 0.
  final double spaceBetweenEmojiAndCount;

  /// Fixed width for the reaction tile.
  /// If null, the tile will size itself based on its content and constraints.
  final double? width;

  /// Fixed height for the reaction tile.
  /// If null, uses the default height.
  final double? height;

  /// Creates a reaction tile widget.
  const ReactionTile({
    super.key,
    this.emoji,
    this.count,
    this.extraText,
    this.reactedByUser = false,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.reactedBackgroundColor,
    this.borderColor,
    this.countTextStyle,
    this.emojiTextStyle,
    this.extraTextStyle,
    this.spaceBetweenEmojiAndCount = 0,
    this.width,
    this.height,
  });

  @override
  State<ReactionTile> createState() => _ReactionTileState();
}

class _ReactionTileState extends State<ReactionTile> {
  late bool _isTapped;
  late int? _count;

  @override
  void initState() {
    super.initState();
    _count = widget.count;
    _isTapped = widget.reactedByUser;
  }

  @override
  Widget build(BuildContext context) {
    // Used to shrink on state update
    if (_count == 0) {
      return const SizedBox.shrink();
    }
    final theme = context.read<ChatTheme>();
    final countString =
        _count != null
            ? ReactionTileCountTextHelper.getCountString(_count!)
            : null;
    return GestureDetector(
      onTap: () {
        if (widget.count != null) {
          setState(() {
            _count = _count! + (_isTapped ? -1 : 1);
            _isTapped = !_isTapped;
          });
        }
        widget.onTap?.call();
      },
      onLongPress: widget.onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ReactionTileConstants.horizontalPadding,
        ),
        height: widget.height ?? ReactionTileConstants.height,
        width: widget.width,
        decoration: BoxDecoration(
          color:
              _isTapped
                  ? widget.reactedBackgroundColor
                  : widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border:
              widget.borderColor != null
                  ? Border.all(color: widget.borderColor!, width: 1)
                  : null,
        ),
        child: ColoredBox(
          color: Colors.transparent,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.emoji != null)
                  /// Emoji alignement issue https://github.com/flutter/flutter/issues/119623
                  Padding(
                    padding: EdgeInsets.fromLTRB(2.5, 0, 0, 1.5),
                    child: Text(
                      widget.emoji!,
                      style: ReactionTileStyleResolver.resolveEmojiTextStyle(
                        provided: widget.emojiTextStyle,
                        theme: theme,
                      ),
                    ),
                  ),
                if (widget.emoji != null && countString != null)
                  SizedBox(width: ReactionTileConstants.textElementsSpacing),
                if (countString != null)
                  Text(
                    countString,
                    style: ReactionTileStyleResolver.resolveCountTextStyle(
                      provided: widget.countTextStyle,
                      theme: theme,
                    ),
                  ),
                if ((countString != null || widget.emoji != null) &&
                    widget.extraText != null)
                  SizedBox(width: ReactionTileConstants.textElementsSpacing),
                if (widget.extraText != null)
                  Text(
                    widget.extraText!,
                    style: ReactionTileStyleResolver.resolveExtraTextStyle(
                      provided: widget.extraTextStyle,
                      theme: theme,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReactionTileConstants {
  static const double textElementsSpacing = 2;
  static const double minimumWidth = 40;
  static const double horizontalPadding = 8;
  static const double height = 24;
}

class ReactionTileCountTextHelper {
  static String? getCountString(int count) {
    return count > 1 ? count.toString() : null;
  }
}

class ReactionTileSizeHelper {
  /// Calculate the prefered size for the [ReactionTile]
  ///
  /// This is used to calculate the size of the [ReactionTile]
  /// and the number of reactions that can fit in the available width.
  ///

  static Size calculatePrefferedSize({
    required TextStyle emojiStyle,
    required TextStyle countTextStyle,
    required TextStyle extraTextStyle,
    String? emoji,
    String? countText,
    String? extraText,
  }) {
    final hasEmoji = emoji != null && emoji.isNotEmpty;
    final hasText = countText != null && countText.isNotEmpty;
    final hasExtraText = extraText != null && extraText.isNotEmpty;
    if (!hasEmoji && !hasText && !hasExtraText) {
      return Size.square(0);
    }
    var width = 0.0;

    if (hasEmoji) {
      width += emojiStyle.fontSize!;
      width += 2.5; // See emoji alignement
    }
    if (hasText) {
      if (width > 0) {
        width += ReactionTileConstants.textElementsSpacing;
      }
      width += countText.length * countTextStyle.fontSize!;
    }
    if (hasExtraText) {
      if (width > 0) {
        width += ReactionTileConstants.textElementsSpacing;
      }
      width += extraText.length * extraTextStyle.fontSize!;
    }
    width += ReactionTileConstants.horizontalPadding * 2;

    return Size(
      width.clamp(ReactionTileConstants.minimumWidth, double.infinity),
      ReactionTileConstants.height,
    );
  }
}

class ReactionTileStyleResolver {
  static TextStyle resolveEmojiTextStyle({
    TextStyle? provided,
    required ChatTheme theme,
  }) {
    if (provided != null) return provided;
    return theme.reactionEmojiTextStyle;
  }

  static TextStyle resolveCountTextStyle({
    TextStyle? provided,
    required ChatTheme theme,
  }) {
    if (provided != null) return provided;
    return theme.reactionCountTextStyle;
  }

  static TextStyle resolveExtraTextStyle({
    TextStyle? provided,
    required ChatTheme theme,
  }) {
    if (provided != null) return provided;
    return theme.reactionSurplusTextStyle;
  }
}
