import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class FlyerChatSystemMessage extends StatelessWidget {
  final SystemMessage message;
  final int index;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final TextStyle? textStyle;

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
    final theme = context.watch<ChatTheme>();
    final resolvedBackgroundColor =
        backgroundColor ?? theme.colors.surfaceContainer;
    final resolvedTextStyle =
        textStyle ??
        theme.typography.bodySmall.copyWith(color: theme.colors.onSurface);

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
