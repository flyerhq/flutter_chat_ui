import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// Used to make provided [types.User] class available through the whole package.
class InheritedUser extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [types.User] class.
  const InheritedUser({
    super.key,
    required this.user,
    required super.child,
  });

  /// Represents current logged in user. Used to determine message's author.
  final types.User user;

  static InheritedUser of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedUser>()!;

  @override
  bool updateShouldNotify(InheritedUser oldWidget) =>
      user.id != oldWidget.user.id;
}
