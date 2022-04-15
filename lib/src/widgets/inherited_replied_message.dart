import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// Used to make provided [types.Message] class available through the whole package
class InheritedRepliedMessage extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [types.User] class
  const InheritedRepliedMessage({
    Key? key,
    this.repliedMessage,
    required Widget child,
  }) : super(key: key, child: child);

  /// Represents current logged in user. Used to determine message's author.
  final types.Message? repliedMessage;

  static InheritedRepliedMessage of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedRepliedMessage>()!;
  }

  @override
  bool updateShouldNotify(InheritedRepliedMessage oldWidget) =>
      repliedMessage?.id != oldWidget.repliedMessage?.id;
}
