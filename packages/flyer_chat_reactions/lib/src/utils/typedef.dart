import 'package:flutter/material.dart';

/// Callback signature for when a reaction is tapped.
typedef OnReactionTapCallback = void Function(String reaction);
typedef OnReactionLongPressCallback = void Function(String reaction);
typedef ReactionsDialogMoreReactionsWidgetBuilder =
    Widget Function(BuildContext context);
