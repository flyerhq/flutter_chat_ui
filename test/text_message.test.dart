import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview;
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('contains text message', (WidgetTester tester) async {
    // Build the Chat widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Chat(
            messages: const [
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id',
                text: 'text',
              ),
            ],
            onSendPressed: (types.PartialText message) => {},
            user: const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
          ),
        ),
      ),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to fine one TextMessage.
    expect(find.byType(TextMessage), findsOneWidget);
  });

  testWidgets('contains link preview', (WidgetTester tester) async {
    // Build the Chat widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Chat(
            messages: const [
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id',
                previewData: types.PreviewData(
                  description: 'Flutter',
                  link: 'https://flutter.dev/',
                  title: 'Flutter',
                ),
                text: 'https://flutter.dev/',
              ),
            ],
            onPreviewDataFetched:
                (types.TextMessage message, types.PreviewData previewData) =>
                    {},
            onSendPressed: (types.PartialText message) => {},
            user: const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
          ),
        ),
      ),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to find one LinkPreview.
    expect(find.byType(LinkPreview), findsOneWidget);
  });

  testWidgets('triggers visibility detection', (WidgetTester tester) async {
    // Check out documentation https://pub.dev/packages/visibility_detector#widget-tests.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    final messagesVisible = <String>{};
    // Build the Chat widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Chat(
            messages: const [
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id',
                text: 'Short message',
              ),
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id2',
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                    'sed do eiusmod tempor incididunt ut labore et dolore '
                    'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                    'exercitation ullamco laboris nisi ut aliquip ex ea '
                    'commodo consequat. Duis aute irure dolor in reprehenderit '
                    'in voluptate velit esse cillum dolore eu fugiat nulla '
                    'pariatur. Excepteur sint occaecat cupidatat non proident, '
                    'sunt in culpa qui officia deserunt mollit anim id est '
                    'laborum.',
              ),
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id3',
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                    'sed do eiusmod tempor incididunt ut labore et dolore '
                    'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                    'exercitation ullamco laboris nisi ut aliquip ex ea '
                    'commodo consequat. Duis aute irure dolor in reprehenderit '
                    'in voluptate velit esse cillum dolore eu fugiat nulla '
                    'pariatur. Excepteur sint occaecat cupidatat non proident, '
                    'sunt in culpa qui officia deserunt mollit anim id est '
                    'laborum.',
              ),
              types.TextMessage(
                author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'previewId',
                previewData: types.PreviewData(
                  description: 'Flutter',
                  link: 'https://flutter.dev/',
                  title: 'Flutter',
                ),
                text: 'https://flutter.dev/',
              ),
            ],
            onSendPressed: (types.PartialText message) => {},
            onPreviewDataFetched:
                (types.TextMessage message, types.PreviewData previewData) =>
                    {},
            onMessageVisibilityChanged: (m, visible) {
              if (visible) {
                messagesVisible.add(m.id);
              } else {
                messagesVisible.remove(m.id);
              }
            },
            user: const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
          ),
        ),
      ),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to find the first messages as visible.
    assert(messagesVisible.length == 2 &&
        messagesVisible.containsAll(<String>{'id', 'id2'}));

    // Scroll all the way up to the preview data message.
    await tester.dragUntilVisible(
      find.byType(LinkPreview),
      find.byType(CustomScrollView),
      const Offset(0, 100),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to find the last message as visible.
    assert(messagesVisible.length == 2 &&
        messagesVisible.containsAll(<String>{'id3', 'previewId'}));
  });
}
