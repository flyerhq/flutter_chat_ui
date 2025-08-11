import 'dart:ui';
import 'package:animate_do/animate_do.dart' show FadeInLeft, Pulse;
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart'
    show ChatProviders, buildMessageContent;
import 'package:provider/provider.dart';

import '../models/default_data.dart';
import '../utils/hover_float_effect.dart';
import '../utils/typedef.dart';

//// Theme values for [ReactionsDialogWidget].
typedef _LocalTheme =
    ({
      Color onSurface,
      Color surfaceContainer,
      Color primary,
      BorderRadiusGeometry shape,
    });

class ReactionsDialogWidget extends StatefulWidget {
  const ReactionsDialogWidget({
    super.key,
    required this.messageWidget,
    required this.onReactionTap,
    this.moreReactionsWidgetBuilder,
    this.onMoreReactionsTap,
    this.reactions,
    this.userReactions,
    this.horizontalAlignment = CrossAxisAlignment.end,
    this.reactionsPickerBackgroundColor,
    this.reactionsPickerReactedBackgroundColor,
    this.reactionTapAnimationDuration,
    this.reactionPickerFadeLeftAnimationDuration,
    this.activateHoverFloatEffect = true,
    this.bottomWidgetBuilder,
  });

  /// The message widget to be displayed in the dialog
  final Widget messageWidget;

  /// The callback function to be called when a reaction is tapped
  final OnReactionTapCallback onReactionTap;

  /// More Reactions Widget builder
  final ReactionsDialogMoreReactionsWidgetBuilder? moreReactionsWidgetBuilder;

  /// The callback function to be called when the "more" reactions  widget is tapped
  /// If not provided the widget will not be displayed
  final VoidCallback? onMoreReactionsTap;

  /// The list of menu items to be displayed in the context menu
  final ReactionsDialogBottomWidgetBuilder? bottomWidgetBuilder;

  /// The list of default reactions to be displayed
  final List<String>? reactions;

  /// The list of user reactions to be displayed
  /// This allow user to remove them from here
  final List<String>? userReactions;

  /// The horizontal alignment of the widget
  final CrossAxisAlignment horizontalAlignment;

  /// The background color for reactions picker
  final Color? reactionsPickerBackgroundColor;

  /// The color for the reactions reacted by the user
  final Color? reactionsPickerReactedBackgroundColor;

  /// Animation duration when a reaction is selected
  final Duration? reactionTapAnimationDuration;

  /// Animation duration to display the reactions row
  final Duration? reactionPickerFadeLeftAnimationDuration;

  /// Whether to activate the hover float effect
  final bool activateHoverFloatEffect;

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
        surfaceContainer: t.colors.surfaceContainerHigh,
        primary: t.colors.primary,
        shape: t.shape,
      ),
    );
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: widget.horizontalAlignment,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildReactionsPicker(context, theme),
            const SizedBox(height: 10),
            widget.activateHoverFloatEffect
                ? HoverFloatEffect(child: widget.messageWidget)
                : widget.messageWidget,
            if (widget.bottomWidgetBuilder != null) ...[
              const SizedBox(height: 10),
              widget.bottomWidgetBuilder!(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildReactionsPicker(BuildContext context, _LocalTheme theme) {
    // Merge default reactions with user reactions, removing duplicates
    final allReactions =
        <String>{
          ...(widget.reactions ?? DefaultData.reactions),
          ...(widget.userReactions ?? const []),
        }.toList();

    final reactionTapAnimationDuration =
        widget.reactionTapAnimationDuration ??
        const Duration(milliseconds: 200);
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:
              widget.reactionsPickerBackgroundColor ?? theme.surfaceContainer,
          borderRadius: theme.shape,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < allReactions.length; i++)
                FadeInLeft(
                  from: 0 + (i * 20).toDouble(),
                  duration:
                      widget.reactionPickerFadeLeftAnimationDuration ??
                      const Duration(milliseconds: 200),
                  delay: Duration.zero,
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 2),
                      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2),
                      decoration: BoxDecoration(
                        color:
                            (widget.userReactions ?? const []).contains(
                                  allReactions[i],
                                )
                                ? widget.reactionsPickerReactedBackgroundColor ??
                                    theme.onSurface.withValues(alpha: 0.2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Pulse(
                        infinite: false,
                        duration: reactionTapAnimationDuration,
                        animate: reactionClicked && clickedReactionIndex == i,
                        child: Text(
                          allReactions[i],
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        reactionClicked = true;
                        clickedReactionIndex = i;
                      });
                      Future.delayed(reactionTapAnimationDuration).whenComplete(
                        () {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                          widget.onReactionTap(allReactions[i]);
                        },
                      );
                    },
                  ),
                ),
              if (widget.onMoreReactionsTap != null)
                FadeInLeft(
                  from: 0 + (allReactions.length * 20).toDouble(),
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
                        widget.moreReactionsWidgetBuilder?.call(context) ??
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
  required OnReactionTapCallback onReactionTap,
  VoidCallback? onMoreReactionsTap,
  List<String>? reactions,
  List<String>? userReactions,
  CrossAxisAlignment? horizontalAlignment,
  Color? reactionsPickerBackgroundColor,
  Color? reactionsPickerReactedBackgroundColor,
  Duration? reactionTapAnimationDuration,
  Duration? reactionPickerFadeLeftAnimationDuration,
  ReactionsDialogMoreReactionsWidgetBuilder? moreReactionsWidgetBuilder,
  ReactionsDialogBottomWidgetBuilder? bottomWidgetBuilder,
  bool activateHoverFloatEffect = true,
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
            horizontalAlignment:
                horizontalAlignment ??
                (isSentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start),
            onReactionTap: onReactionTap,
            onMoreReactionsTap: onMoreReactionsTap,
            bottomWidgetBuilder: bottomWidgetBuilder,
            reactions: reactions,
            userReactions: userReactions,
            reactionsPickerBackgroundColor: reactionsPickerBackgroundColor,
            reactionsPickerReactedBackgroundColor:
                reactionsPickerReactedBackgroundColor,
            reactionTapAnimationDuration: reactionTapAnimationDuration,
            reactionPickerFadeLeftAnimationDuration:
                reactionPickerFadeLeftAnimationDuration,
            moreReactionsWidgetBuilder: moreReactionsWidgetBuilder,
            activateHoverFloatEffect: activateHoverFloatEffect,
          ),
        ),
  );
}
