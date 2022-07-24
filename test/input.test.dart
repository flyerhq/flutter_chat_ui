import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sendButtonVisibilityMode', () {
    testWidgets(
      'The SendButton should always be visible when sendButtonVisibilityMode is set to SendButtonVisibilityMode.always',
      (WidgetTester tester) async {
        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                inputOptions: const InputOptions(
                  sendButtonVisibilityMode: SendButtonVisibilityMode.always,
                ),
                messages: const [],
                onSendPressed: (types.PartialText message) {},
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );
        // Trigger a frame.
        await tester.pump();

        // The SendButton should exist in the widget tree.
        expect(find.byType(SendButton), findsOneWidget);
      },
    );

    testWidgets(
      'The SendButton should always be invisible when sendButtonVisibilityMode is set to SendButtonVisibilityMode.hidden',
      (WidgetTester tester) async {
        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                inputOptions: const InputOptions(
                  sendButtonVisibilityMode: SendButtonVisibilityMode.hidden,
                ),
                messages: const [],
                onSendPressed: (types.PartialText message) {},
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );
        // Trigger a frame.
        await tester.pump();

        // The SendButton should not exist in the widget tree.
        expect(find.byType(SendButton), findsNothing);
      },
    );

    testWidgets(
      'The SendButton should be invisible only when sendButtonVisibilityMode is not specified and the TextField is empty',
      (WidgetTester tester) async {
        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                messages: const [],
                onSendPressed: (types.PartialText message) {},
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );
        // Trigger a frame.
        await tester.pump();

        // The SendButton should not exist in the widget tree.
        expect(find.byType(SendButton), findsNothing);
      },
    );

    testWidgets(
      'The SendButton should be visible only when sendButtonVisibilityMode is not specified and the TextField is not empty',
      (WidgetTester tester) async {
        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                messages: const [],
                onSendPressed: (types.PartialText message) {},
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );
        // Trigger a frame.
        await tester.pump();
        // Enter 'hi' into the TextField.
        await tester.enterText(find.byType(TextField), 'hi');
        // Trigger a frame.
        await tester.pump();

        // The SendButton should exist in the widget tree.
        expect(find.byType(SendButton), findsOneWidget);
      },
    );

    testWidgets(
      'onSendPressed function has to be called on SendButton tap',
      (WidgetTester tester) async {
        // Define a bool indicating function was called.
        var isCalled = false;

        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                messages: const [],
                onSendPressed: (types.PartialText message) => isCalled = true,
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );

        // Enter 'hi' into the TextField.
        await tester.enterText(find.byType(TextField), 'hi');

        // Trigger a frame.
        await tester.pump();

        // Tap the Send button.
        await tester.tap(find.byType(SendButton));

        // Trigger a frame.
        await tester.pump();

        // Expect TextField is cleared.
        expect(find.text('hi'), findsNothing);

        // Expect onSendPressed function was called.
        expect(isCalled, true);
      },
    );

    testWidgets(
      'onAttachmentPressed function has to be called on SendButton tap',
      (WidgetTester tester) async {
        // Define a bool indicating function was called.
        var isCalled = false;

        // Build the Chat widget.
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: Chat(
                messages: const [],
                onAttachmentPressed: () => isCalled = true,
                onSendPressed: (types.PartialText message) => {},
                user: const types.User(
                  id: '06c33e8b-e835-4736-80f4-63f44b66666c',
                ),
              ),
            ),
          ),
        );

        // Tap the Attachment button.
        await tester.tap(find.byType(AttachmentButton));

        // Trigger a frame.
        await tester.pump();

        // Expect onAttachmentPressed function was called.
        expect(isCalled, true);
      },
    );
  });
}
