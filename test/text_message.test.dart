import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview;
import 'package:flutter_test/flutter_test.dart';

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
              )
            ],
            onSendPressed: (types.PartialText message) => {},
            user: const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
          ),
        ),
      ),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to fine one TextMessage
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
              )
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

    // Expect to find one LinkPreview
    expect(find.byType(LinkPreview), findsOneWidget);
  });
}
