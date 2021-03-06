import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class InheritedUser extends InheritedWidget {
  const InheritedUser({
    Key? key,
    required this.user,
    required Widget child,
  }) : super(key: key, child: child);

  final types.User user;

  static InheritedUser of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedUser>()!;
  }

  @override
  bool updateShouldNotify(InheritedUser oldWidget) =>
      user.id != oldWidget.user.id;
}
