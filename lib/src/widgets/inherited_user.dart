import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class InheritedUser extends InheritedWidget {
  const InheritedUser({
    Key key,
    @required this.user,
    @required Widget child,
  })  : assert(user != null),
        assert(child != null),
        super(key: key, child: child);

  final types.User user;

  static InheritedUser of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedUser>();
  }

  @override
  bool updateShouldNotify(InheritedUser old) => user.id != old.user.id;
}
