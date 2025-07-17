import 'dart:ui';
import 'package:animate_do/animate_do.dart' show FadeInLeft, Pulse;
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart'
    show ChatProviders, buildMessageContent;
import 'package:provider/provider.dart';

import '../models/default_data.dart';
import '../models/menu_item.dart';

//// Theme values for [ReactionsDialogWidget].
typedef _LocalTheme =
    ({
      Color onSurface,
      Color surface,
      Color primary,
      BorderRadiusGeometry shape,
    });

class ReactionsDialogWidget extends StatefulWidget {
  const ReactionsDialogWidget({
    super.key,
    required this.messageWidget,
    required this.onReactionTap,
    this.moreReactionsWidget,
    this.onMoreReactionsTap,
    this.menuItems,
    this.reactions,
    this.widgetAlignment,
    this.menuItemsWidthRatio,
    this.menuItemBackgroundColor,
    this.menuItemDestructiveColor,
    this.menuItemDividerColor,
    this.reactionsPickerBackgroundColor,
    this.menuItemTapAnimationDuration,
    this.reactionTapAnimationDuration,
    this.reactionPickerFadeLeftAnimationDuration,
  });

  /// The message widget to be displayed in the dialog
  final Widget messageWidget;

  /// The callback function to be called when a reaction is tapped
  final Function(String) onReactionTap;

  /// More Reactions Widget
  final Widget? moreReactionsWidget;

  /// The callback function to be called when the "more" reactions  widget is tapped
  /// If not provided the widget will not be displayed
  final VoidCallback? onMoreReactionsTap;

  /// The list of menu items to be displayed in the context menu
  final List<MenuItem>? menuItems;

  /// The list of reactions to be displayed
  final List<String>? reactions;

  /// The alignment of the widget
  /// Only left right is taken into account
  final Alignment? widgetAlignment;

  /// The width ratio of the menu items
  final double? menuItemsWidthRatio;

  /// Animation duration when a menu item is selected
  final Duration? menuItemTapAnimationDuration;

  /// The background color for menu items
  final Color? menuItemBackgroundColor;

  /// Destructive color for menu items
  final Color? menuItemDestructiveColor;

  /// The divider color for menu items
  final Color? menuItemDividerColor;

  /// The background color for reactions picker
  final Color? reactionsPickerBackgroundColor;

  /// Animation duration when a reaction is selected
  final Duration? reactionTapAnimationDuration;

  /// Animation duration to display the reactions row
  final Duration? reactionPickerFadeLeftAnimationDuration;

  @override
  State<ReactionsDialogWidget> createState() => _ReactionsDialogWidgetState();
}

class _ReactionsDialogWidgetState extends State<ReactionsDialogWidget> {
  bool reactionClicked = false;
  int? clickedReactionIndex;
  int? clickedContextMenuIndex;

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        onSurface: t.colors.onSurface,
        surface: t.colors.surface,
        primary: t.colors.primary,
        shape: t.shape,
      ),
    );
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildReactionsPicker(context, theme),
            const SizedBox(height: 10),
            buildMessage(),
            const SizedBox(height: 10),
            buildMenuItems(context, theme),
          ],
        ),
      ),
    );
  }

  Align buildMenuItems(BuildContext context, _LocalTheme theme) {
    final destructiveColor = widget.menuItemDestructiveColor ?? Colors.red;
    return Align(
      alignment: widget.widgetAlignment ?? Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          /// TODO: maybe use pixels, for desktop?
          width:
              MediaQuery.of(context).size.width *
              (widget.menuItemsWidthRatio ?? 0.45),
          decoration: BoxDecoration(
            color: widget.menuItemBackgroundColor ?? theme.surface,
            borderRadius: theme.shape,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var item in widget.menuItems ?? const [])
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            clickedContextMenuIndex = widget.menuItems?.indexOf(
                              item,
                            );
                          });

                          Future.delayed(
                            widget.menuItemTapAnimationDuration ??
                                const Duration(milliseconds: 200),
                          ).whenComplete(() {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            item.onTap?.call();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color:
                                    item.isDestructive
                                        ? destructiveColor
                                        : theme.onSurface,
                              ),
                            ),
                            Pulse(
                              infinite: false,
                              duration:
                                  widget.menuItemTapAnimationDuration ??
                                  const Duration(milliseconds: 200),
                              animate:
                                  clickedContextMenuIndex ==
                                  widget.menuItems?.indexOf(item),
                              child: Icon(
                                item.icon,
                                color:
                                    item.isDestructive
                                        ? destructiveColor
                                        : theme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.menuItems?.last != item)
                      Divider(
                        color: widget.menuItemDividerColor ?? Colors.white,
                        thickness: 0.5,
                        height: 0.5,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Align buildMessage() {
    return Align(
      alignment: widget.widgetAlignment ?? Alignment.centerRight,
      child: widget.messageWidget,
    );
  }

  Align buildReactionsPicker(BuildContext context, _LocalTheme theme) {
    return Align(
      alignment: widget.widgetAlignment ?? Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: widget.reactionsPickerBackgroundColor ?? theme.surface,
            borderRadius: theme.shape,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var reaction in widget.reactions ?? DefaultData.reactions)
                FadeInLeft(
                  from:
                      0 +
                      ((widget.reactions?.indexOf(reaction) ?? 0) * 20)
                          .toDouble(),
                  duration:
                      widget.reactionPickerFadeLeftAnimationDuration ??
                      const Duration(milliseconds: 200),
                  delay: Duration.zero,
                  child: InkWell(
                    child: Pulse(
                      infinite: false,
                      duration:
                          widget.reactionTapAnimationDuration ??
                          const Duration(milliseconds: 200),
                      animate:
                          reactionClicked &&
                          clickedReactionIndex ==
                              widget.reactions?.indexOf(reaction),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2),
                        child: Text(
                          reaction,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        reactionClicked = true;
                        clickedReactionIndex = widget.reactions?.indexOf(
                          reaction,
                        );
                      });
                      Future.delayed(
                        widget.reactionTapAnimationDuration ??
                            const Duration(milliseconds: 200),
                      ).whenComplete(() {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        widget.onReactionTap(reaction);
                      });
                    },
                  ),
                ),
              if (widget.onMoreReactionsTap != null)
                FadeInLeft(
                  from: 0 + ((widget.reactions?.length ?? 0) * 20).toDouble(),
                  duration:
                      widget.reactionPickerFadeLeftAnimationDuration ??
                      const Duration(milliseconds: 200),
                  delay: Duration.zero,
                  child: InkWell(
                    onTap: () {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      widget.onMoreReactionsTap?.call();
                    },
                    child:
                        widget.moreReactionsWidget ??
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2),
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: theme.onSurface,
                          ),
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Method to display the reactions dialog for a message
/// Refer to [ReactionsDialogWidget] for the available parameters
///
void showReactionsDialog(
  BuildContext context,
  Message message, {
  required bool isSentByMe,
  required Function(String) onReactionTap,
  required Function(MenuItem) onContextMenuTap,
  VoidCallback? onMoreReactionsTap,
  List<MenuItem>? menuItems,
  List<String>? reactions,
  Alignment? widgetAlignment,
  double? menuItemsWidthRatio,
  Color? menuItemBackgroundColor,
  Color? menuItemDestructiveColor,
  Color? menuItemDividerColor,
  Color? reactionsPickerBackgroundColor,
  Duration? menuItemTapAnimationDuration,
  Duration? reactionTapAnimationDuration,
  Duration? reactionPickerFadeLeftAnimationDuration,
  Widget? moreReactionsWidget,
}) {
  final providers = ChatProviders.from(context);

  final widget = buildMessageContent(
    context,
    context.read<Builders>(),
    message,
    0,
    isSentByMe: isSentByMe,
  );

  showDialog(
    context: context,
    useSafeArea: true,
    useRootNavigator: false,
    builder:
        (context) => MultiProvider(
          providers: providers,
          child: ReactionsDialogWidget(
            messageWidget: widget,
            widgetAlignment:
                widgetAlignment ??
                (isSentByMe ? Alignment.centerRight : Alignment.centerLeft),
            onReactionTap: (reaction) {
              onReactionTap(reaction);
            },
            onMoreReactionsTap: onMoreReactionsTap,
            menuItems: menuItems,
            reactions: reactions,
            menuItemsWidthRatio: menuItemsWidthRatio,
            menuItemBackgroundColor: menuItemBackgroundColor,
            menuItemDestructiveColor: menuItemDestructiveColor,
            menuItemDividerColor: menuItemDividerColor,
            reactionsPickerBackgroundColor: reactionsPickerBackgroundColor,
            menuItemTapAnimationDuration: menuItemTapAnimationDuration,
            reactionTapAnimationDuration: reactionTapAnimationDuration,
            reactionPickerFadeLeftAnimationDuration:
                reactionPickerFadeLeftAnimationDuration,
            moreReactionsWidget: moreReactionsWidget,
          ),
        ),
  );
}
