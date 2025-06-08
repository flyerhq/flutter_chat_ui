import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// A widget that displays a system message, typically used for informational
/// messages like "User joined the chat".
class FlyerChatSystemMessage extends StatelessWidget {
  /// The system message data model.
  final SystemMessage message;

  /// The index of the message in the list.
  final int index;

  /// Padding around the message content.
  final EdgeInsetsGeometry? padding;

  /// Background color of the message container.
  final Color? backgroundColor;

  /// Text style for the system message.
  final TextStyle? textStyle;

  /// Creates a widget to display a system message.
  const FlyerChatSystemMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        bodySmall: t.typography.bodySmall,
        onSurface: t.colors.onSurface,
        surfaceContainer: t.colors.surfaceContainer,
      ),
    );
    final resolvedBackgroundColor = backgroundColor ?? theme.surfaceContainer;
    final resolvedTextStyle =
        textStyle ?? theme.bodySmall.copyWith(color: theme.onSurface);

    return Center(
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(color: resolvedBackgroundColor),
        child: Text(
          message.text,
          style: resolvedTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
