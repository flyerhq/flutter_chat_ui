import 'package:flutter/material.dart';

import '../helpers/reaction_text.dart';

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

  /// The minimum count required to display the count text.
  /// If count is less than this value, count text will not be shown.
  /// Defaults to 2.
  final int countDisplayThreshold;

  /// The text to display, after the count text.
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
  /// If null, uses the default theme color.
  final Color? backgroundColor;

  /// Background color for the reaction tile when reacted by the user.
  /// If null, uses the default theme color.
  final Color? reactedBackgroundColor;

  /// Color of the border around the reaction tile.
  final Color? borderColor;

  /// Text style for the count text and extra text.
  /// If null, uses the default style.
  final TextStyle? textStyle;

  /// Font size for the emoji.
  /// If null, uses the default size.
  final double? emojiFontSize;

  /// Space between the emoji and the count text.
  /// Defaults to 0.
  final double spaceBetweenEmojiAndCount;

  /// Fixed width for the reaction tile.
  /// If null, the tile will size itself based on its content.
  final double? width;

  /// Fixed height for the reaction tile.
  /// If null, the tile will size itself based on its content.
  final double? height;

  /// Padding around the content of the reaction tile.
  /// If null, uses default container padding.
  final EdgeInsets? padding;

  /// Creates a reaction tile widget.
  const ReactionTile({
    super.key,
    this.emoji,
    this.count,
    this.countDisplayThreshold = 2,
    this.extraText,
    this.reactedByUser = false,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.reactedBackgroundColor,
    this.borderColor,
    this.textStyle,
    this.emojiFontSize,
    this.spaceBetweenEmojiAndCount = 0,
    this.width,
    this.height,
    this.padding,
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
    final isOnlyEmoji = widget.extraText == null || widget.extraText!.isEmpty;
    if (_count == 0) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        onTap: () {
          if (widget.count != null) {
            setState(() {
              _count = _count! + (_isTapped ? -1 : 1);
              _isTapped = !_isTapped;
              // TODO the widget rebuilds locally
              // but maybe we should notify the parent (maybe only if the count is 0 or count.toString().length is different)
              // To redraw all reactions
            });
          }
          widget.onTap?.call();
        },
        onLongPress: widget.onLongPress,
        child: Container(
          padding: widget.padding,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.emoji != null)
                /// Emoji alignement issue https://github.com/flutter/flutter/issues/119623
                Padding(
                  padding: EdgeInsets.fromLTRB(isOnlyEmoji ? 2.5 : 0, 0, 0, 3),
                  child: Text(
                    widget.emoji!,
                    style: TextStyle(fontSize: widget.emojiFontSize),
                  ),
                ),
              if (_count != null && _count! >= widget.countDisplayThreshold)
                Text(getReactionText(_count!), style: widget.textStyle),
              if (widget.extraText != null)
                Text(widget.extraText!, style: widget.textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
