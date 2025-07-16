import 'dart:ui';
import 'package:animate_do/animate_do.dart' show FadeInLeft, Pulse;
import 'package:flutter/material.dart';

import '../models/default_data.dart';
import '../models/menu_item.dart';

class ReactionsDialogWidget extends StatefulWidget {
  const ReactionsDialogWidget({
    super.key,
    required this.messageWidget,
    required this.onReactionTap,
    required this.onContextMenuTap,
    this.menuItems = DefaultData.menuItems,
    this.reactions = DefaultData.reactions,
    this.widgetAlignment = Alignment.centerRight,
    this.menuItemsWidth = 0.45,
  });

  // The message widget to be displayed in the dialog
  final Widget messageWidget;

  // The callback function to be called when a reaction is tapped
  final Function(String) onReactionTap;

  // The callback function to be called when a context menu item is tapped
  final Function(MenuItem) onContextMenuTap;

  // The list of menu items to be displayed in the context menu
  final List<MenuItem> menuItems;

  // The list of reactions to be displayed
  final List<String> reactions;

  // The alignment of the widget
  // Only left right is taken into account
  final Alignment widgetAlignment;

  // The width of the menu items
  final double menuItemsWidth;

  @override
  State<ReactionsDialogWidget> createState() => _ReactionsDialogWidgetState();
}

class _ReactionsDialogWidgetState extends State<ReactionsDialogWidget> {
  // state variables for activating the animation
  bool reactionClicked = false;
  int? clickedReactionIndex;
  int? clickedContextMenuIndex;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // reactions
              buildReactions(context),
              const SizedBox(height: 10),
              // message
              buildMessage(),
              const SizedBox(height: 10),
              // context menu
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Align buildMenuItems(BuildContext context) {
    return Align(
      alignment: widget.widgetAlignment,
      child: // contextMenu for reply, copy, delete
          Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * widget.menuItemsWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var item in widget.menuItems)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      child: InkWell(
                        onTap: () {
                          // set the clicked index for animation
                          setState(() {
                            clickedContextMenuIndex = widget.menuItems.indexOf(
                              item,
                            );
                          });

                          // delay for 200 milliseconds to allow the animation to complete
                          Future.delayed(
                            const Duration(milliseconds: 500),
                          ).whenComplete(() {
                            // pop the dialog
                            Navigator.of(context).pop();
                            widget.onContextMenuTap(item);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                color:
                                    item.isDestructive
                                        ? Colors.red
                                        : Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.color,
                              ),
                            ),
                            Pulse(
                              infinite: false,
                              duration: const Duration(milliseconds: 500),
                              animate:
                                  clickedContextMenuIndex ==
                                  widget.menuItems.indexOf(item),
                              child: Icon(
                                item.icon,
                                color:
                                    item.isDestructive
                                        ? Colors.red
                                        : Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.menuItems.last != item)
                      Divider(color: Colors.grey.shade300, thickness: 1),
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
      alignment: widget.widgetAlignment,
      child: widget.messageWidget,
    );
  }

  Align buildReactions(BuildContext context) {
    return Align(
      alignment: widget.widgetAlignment,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var reaction in widget.reactions)
                FadeInLeft(
                  from: // first index should be from 0, second from 20, third from 40 and so on
                      0 + (widget.reactions.indexOf(reaction) * 20).toDouble(),
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        reactionClicked = true;
                        clickedReactionIndex = widget.reactions.indexOf(
                          reaction,
                        );
                      });
                      // delay for 200 milliseconds to allow the animation to complete
                      Future.delayed(
                        const Duration(milliseconds: 500),
                      ).whenComplete(() {
                        // pop the dialog
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          widget.onReactionTap(reaction);
                        }
                      });
                    },
                    child: Pulse(
                      infinite: false,
                      duration: const Duration(milliseconds: 500),
                      animate:
                          reactionClicked &&
                          clickedReactionIndex ==
                              widget.reactions.indexOf(reaction),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2),
                        child: Text(
                          reaction,
                          style: const TextStyle(fontSize: 22),
                        ),
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
