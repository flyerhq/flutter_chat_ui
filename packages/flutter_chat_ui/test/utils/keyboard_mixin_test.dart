import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/utils/keyboard_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

class _KeyboardObserver extends StatefulWidget {
  const _KeyboardObserver({super.key});

  @override
  State<_KeyboardObserver> createState() => _KeyboardObserverState();
}

class _KeyboardObserverState extends State<_KeyboardObserver>
    with WidgetsBindingObserver, KeyboardMixin {
  double? keyboardHeight;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();

  @override
  void onKeyboardHeightChanged(double height) => keyboardHeight = height;
}

void main() {
  testWidgets('ignores metrics when no View ancestor exists', (tester) async {
    final key = GlobalKey<_KeyboardObserverState>();
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: _KeyboardObserver(key: key),
      ),
      wrapWithView: false,
    );
    // A render object cannot attach without a View; the observer stays mounted.
    expect(tester.takeException(), isA<FlutterError>());

    expect(() => key.currentState!.didChangeMetrics(), returnsNormally);
  });

  testWidgets('reports keyboard height when a View exists', (tester) async {
    final key = GlobalKey<_KeyboardObserverState>();
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(home: _KeyboardObserver(key: key)));

    tester.view.viewInsets = const FakeViewPadding(bottom: 100);
    key.currentState!.didChangeMetrics();
    await tester.pump(const Duration(milliseconds: 100));

    expect(key.currentState!.keyboardHeight, 100);
  });
}
