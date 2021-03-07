import 'package:flutter/widgets.dart';
import '../chat_l10n.dart';

class InheritedL10n extends InheritedWidget {
  const InheritedL10n({
    Key? key,
    required this.l10n,
    required Widget child,
  }) : super(key: key, child: child);

  final ChatL10n l10n;

  static InheritedL10n of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedL10n>()!;
  }

  @override
  bool updateShouldNotify(InheritedL10n oldWidget) =>
      l10n.hashCode != oldWidget.l10n.hashCode;
}
