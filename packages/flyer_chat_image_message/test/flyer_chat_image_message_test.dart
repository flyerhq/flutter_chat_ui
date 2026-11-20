import 'dart:typed_data';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'transparent_image.dart';

ImageMessage _message({required String source, double? width, double? height}) {
  return ImageMessage(
    id: 'image-1',
    authorId: 'other',
    source: source,
    width: width,
    height: height,
  );
}

Widget _wrap(
  ChatController controller,
  ImageMessage message,
  ImageProvider provider,
) {
  return MultiProvider(
    providers: [
      Provider<ChatTheme>.value(value: ChatTheme.light()),
      Provider<UserID>.value(value: 'me'),
      Provider<ChatController>.value(value: controller),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: FlyerChatImageMessage(
          message: message,
          index: 0,
          customImageProvider: provider,
          showTime: false,
        ),
      ),
    ),
  );
}

Future<void> _settleImages(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 100)),
  );
  await tester.pump();
}

ImageProvider _shownImage(WidgetTester tester) {
  return tester.widgetList<Image>(find.byType(Image)).last.image;
}

void main() {
  testWidgets('shows the new image when the message source changes', (
    tester,
  ) async {
    final controller = InMemoryChatController();
    addTearDown(controller.dispose);
    final first = MemoryImage(Uint8List.fromList(transparentImage));
    final second = MemoryImage(Uint8List.fromList(transparentImage));

    await tester.pumpWidget(
      _wrap(controller, _message(source: 'a', width: 100, height: 100), first),
    );
    await _settleImages(tester);
    expect(_shownImage(tester), same(first));

    await tester.pumpWidget(
      _wrap(controller, _message(source: 'b', width: 100, height: 100), second),
    );
    await _settleImages(tester);

    expect(_shownImage(tester), same(second));
  });

  testWidgets('uses the new dimensions when the message size changes', (
    tester,
  ) async {
    final controller = InMemoryChatController();
    addTearDown(controller.dispose);
    final first = MemoryImage(Uint8List.fromList(transparentImage));
    final second = MemoryImage(Uint8List.fromList(transparentImage));

    await tester.pumpWidget(
      _wrap(controller, _message(source: 'a', width: 100, height: 200), first),
    );
    await _settleImages(tester);
    expect(
      tester.widget<AspectRatio>(find.byType(AspectRatio)).aspectRatio,
      0.5,
    );

    await tester.pumpWidget(
      _wrap(controller, _message(source: 'b', width: 100, height: 100), second),
    );
    await _settleImages(tester);

    expect(tester.widget<AspectRatio>(find.byType(AspectRatio)).aspectRatio, 1);
  });
}
