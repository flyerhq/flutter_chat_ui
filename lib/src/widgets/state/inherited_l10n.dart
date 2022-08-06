import 'package:flutter/widgets.dart';

import '../../chat_l10n.dart';

/// Used to make provided [ChatL10n] class available through the whole package.
class InheritedL10n extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatL10n] class.
  const InheritedL10n({
    super.key,
    required this.l10n,
    required super.child,
  });

  /// Represents localized copy.
  final ChatL10n l10n;

  static InheritedL10n of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedL10n>()!;

  @override
  bool updateShouldNotify(InheritedL10n oldWidget) =>
      l10n.hashCode != oldWidget.l10n.hashCode;
}
