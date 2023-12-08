import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// Used to make provided [types.User] class available through the whole package.
class InheritedFocusNode extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [types.User] class.
  const InheritedFocusNode({
    super.key,
    required this.focusNode,
    required super.child,
  });

  static InheritedFocusNode of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedFocusNode>()!;

  /// Represents current logged in user. Used to determine message's author.
  final FocusNode focusNode;

  @override
  bool updateShouldNotify(InheritedFocusNode oldWidget) =>
      focusNode.hashCode != oldWidget.focusNode.hashCode;
}
