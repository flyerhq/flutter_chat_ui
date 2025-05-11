import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Chat List Widget Integration Tests', () {
    late InMemoryChatController controller;

    setUp(() {
      controller = InMemoryChatController(messages: []);
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('List - all operations', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestChatWidget(
          controller: controller,
          currentUserId: 'testUser1',
          resolveUser: _testResolveUser,
        ),
      );

      await _testOperations(
        tester,
        controller,
        'n_msg0',
        'Normal Message 0',
        'n_msg1',
        'Normal Message 1',
        'n_msg2',
        'Normal Message 2',
        'n_msg2_5',
        'Normal Message 2.5',
        'n_msg3',
        'Normal Message 3',
        'n_msg4',
        'Normal Message 4',
      );
    });

    testWidgets('Reversed list - all operations', (WidgetTester tester) async {
      final builders = Builders(
        chatAnimatedListBuilder: (context, itemBuilder) {
          return ChatAnimatedListReversed(itemBuilder: itemBuilder);
        },
      );

      await tester.pumpWidget(
        _buildTestChatWidget(
          controller: controller,
          currentUserId: 'testUser1',
          resolveUser: _testResolveUser,
          builders: builders,
        ),
      );

      await _testOperations(
        tester,
        controller,
        'r_msg0',
        'Reversed Message 0',
        'r_msg1',
        'Reversed Message 1',
        'r_msg2',
        'Reversed Message 2',
        'r_msg2_5',
        'Reversed Message 2.5',
        'r_msg3',
        'Reversed Message 3',
        'r_msg4',
        'Reversed Message 4',
      );
    });

    testWidgets('List - advanced set operations', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestChatWidget(
          controller: controller,
          currentUserId: 'testUser1',
          resolveUser: _testResolveUser,
        ),
      );

      await _testSetOperations(tester, controller, 'n_setOp');
    });

    testWidgets('Reversed list - advanced set operations', (
      WidgetTester tester,
    ) async {
      final builders = Builders(
        chatAnimatedListBuilder: (context, itemBuilder) {
          // Using ChatAnimatedListReversed as per existing test patterns
          return ChatAnimatedListReversed(itemBuilder: itemBuilder);
        },
      );

      await tester.pumpWidget(
        _buildTestChatWidget(
          controller: controller,
          currentUserId: 'testUser1',
          resolveUser: _testResolveUser,
          builders: builders,
        ),
      );

      await _testSetOperations(tester, controller, 'r_setOp');
    });
  });
}

Future<User> _testResolveUser(UserID id) async {
  return User(id: id, name: 'Test User $id');
}

Widget _buildTestChatWidget({
  required ChatController controller,
  required UserID currentUserId,
  required ResolveUserCallback resolveUser,
  Builders? builders,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Chat(
        chatController: controller,
        currentUserId: currentUserId,
        resolveUser: resolveUser,
        builders: builders,
      ),
    ),
  );
}

Future<void> _testOperations(
  WidgetTester tester,
  ChatController controller,
  String msg0Id,
  String msg0Text,
  String msg1Id,
  String msg1Text,
  String msg2Id,
  String msg2Text,
  String msg2_5Id,
  String msg2_5Text,
  String msg3Id,
  String msg3Text,
  String msg4Id,
  String msg4Text,
) async {
  final message0 = TextMessage(
    id: msg0Id,
    authorId: 'testUser1',
    text: msg0Text,
  );
  final message1 = TextMessage(
    id: msg1Id,
    authorId: 'testUser1',
    text: msg1Text,
  );
  final message2 = TextMessage(
    id: msg2Id,
    authorId: 'testUser1',
    text: msg2Text,
  );
  final message2_5 = TextMessage(
    id: msg2_5Id,
    authorId: 'testUser1',
    text: msg2_5Text,
  );
  final message3 = TextMessage(
    id: msg3Id,
    authorId: 'testUser1',
    text: msg3Text,
  );
  final message4 = TextMessage(
    id: msg4Id,
    authorId: 'testUser1',
    text: msg4Text,
  );

  // Insert initial 4 messages
  await controller.insertMessage(message1);
  await tester.pumpAndSettle();
  await controller.insertMessage(message2);
  await tester.pumpAndSettle();
  await controller.insertMessage(message3);
  await tester.pumpAndSettle();
  await controller.insertMessage(message4);
  await tester.pumpAndSettle();

  // Verify initial 4 messages are present
  expect(find.text(msg1Text), findsOneWidget);
  expect(find.byKey(ValueKey(msg1Id)), findsOneWidget);
  expect(find.text(msg2Text), findsOneWidget);
  expect(find.byKey(ValueKey(msg2Id)), findsOneWidget);
  expect(find.text(msg3Text), findsOneWidget);
  expect(find.byKey(ValueKey(msg3Id)), findsOneWidget);
  expect(find.text(msg4Text), findsOneWidget);
  expect(find.byKey(ValueKey(msg4Id)), findsOneWidget);

  // Check visual order for initial 4 messages
  final message1FinderInitial = find.text(msg1Text);
  final message2FinderInitial = find.text(msg2Text);
  final message3FinderInitial = find.text(msg3Text);
  final message4FinderInitial = find.text(msg4Text);

  final offset1Initial = tester.getTopLeft(message1FinderInitial);
  final offset2Initial = tester.getTopLeft(message2FinderInitial);
  final offset3Initial = tester.getTopLeft(message3FinderInitial);
  final offset4Initial = tester.getTopLeft(message4FinderInitial);

  expect(
    offset1Initial.dy < offset2Initial.dy,
    isTrue,
    reason: 'INITIAL: $msg1Text should be visually above $msg2Text',
  );
  expect(
    offset2Initial.dy < offset3Initial.dy,
    isTrue,
    reason: 'INITIAL: $msg2Text should be visually above $msg3Text',
  );
  expect(
    offset3Initial.dy < offset4Initial.dy,
    isTrue,
    reason: 'INITIAL: $msg3Text should be visually above $msg4Text',
  );

  // Insert message2_5 at content index 2
  await controller.insertMessage(message2_5, index: 2);
  await tester.pumpAndSettle();

  // Verify all 5 messages are present
  expect(find.text(msg1Text), findsOneWidget); // msg1
  expect(find.byKey(ValueKey(msg1Id)), findsOneWidget);
  expect(find.text(msg2Text), findsOneWidget); // msg2
  expect(find.byKey(ValueKey(msg2Id)), findsOneWidget);
  expect(find.text(msg2_5Text), findsOneWidget); // msg2_5 (inserted)
  expect(find.byKey(ValueKey(msg2_5Id)), findsOneWidget);
  expect(find.text(msg3Text), findsOneWidget); // original msg3
  expect(find.byKey(ValueKey(msg3Id)), findsOneWidget);
  expect(find.text(msg4Text), findsOneWidget); // original msg4
  expect(find.byKey(ValueKey(msg4Id)), findsOneWidget);

  // Check final visual order for all 5 messages
  final message1FinderFinal = find.text(msg1Text);
  final message2FinderFinal = find.text(msg2Text);
  final message2_5FinderFinal = find.text(msg2_5Text);
  final message3FinderFinal = find.text(msg3Text); // original msg3
  final message4FinderFinal = find.text(msg4Text); // original msg4

  final offset1Final = tester.getTopLeft(message1FinderFinal);
  final offset2Final = tester.getTopLeft(message2FinderFinal);
  final offset2_5Final = tester.getTopLeft(message2_5FinderFinal);
  final offset3Final = tester.getTopLeft(message3FinderFinal);
  final offset4Final = tester.getTopLeft(message4FinderFinal);

  expect(
    offset1Final.dy < offset2Final.dy,
    isTrue,
    reason: 'FINAL: $msg1Text should be visually above $msg2Text',
  );
  expect(
    offset2Final.dy < offset2_5Final.dy,
    isTrue,
    reason: 'FINAL: $msg2Text should be visually above $msg2_5Text',
  );
  expect(
    offset2_5Final.dy < offset3Final.dy,
    isTrue,
    reason: 'FINAL: $msg2_5Text should be visually above $msg3Text',
  );
  expect(
    offset3Final.dy < offset4Final.dy,
    isTrue,
    reason: 'FINAL: $msg3Text should be visually above $msg4Text',
  );

  // Insert message0 at content index 0
  await controller.insertMessage(message0, index: 0);
  await tester.pumpAndSettle();

  // Verify all 6 messages are present and message0 is at the top
  expect(find.text(msg0Text), findsOneWidget); // msg0 (inserted at top)
  expect(find.byKey(ValueKey(msg0Id)), findsOneWidget);
  expect(find.text(msg1Text), findsOneWidget); // msg1
  expect(find.byKey(ValueKey(msg1Id)), findsOneWidget);
  expect(find.text(msg2Text), findsOneWidget); // msg2
  expect(find.byKey(ValueKey(msg2Id)), findsOneWidget);
  expect(find.text(msg2_5Text), findsOneWidget); // msg2_5
  expect(find.byKey(ValueKey(msg2_5Id)), findsOneWidget);
  expect(find.text(msg3Text), findsOneWidget); // original msg3
  expect(find.byKey(ValueKey(msg3Id)), findsOneWidget);
  expect(find.text(msg4Text), findsOneWidget); // original msg4
  expect(find.byKey(ValueKey(msg4Id)), findsOneWidget);

  // Check visual order for message0 and message1
  final message0FinderAfterInsert = find.text(msg0Text);
  final message1FinderAfterInsert = find.text(msg1Text);
  final offset0AfterInsert = tester.getTopLeft(message0FinderAfterInsert);
  final offset1AfterInsert = tester.getTopLeft(message1FinderAfterInsert);

  expect(
    offset0AfterInsert.dy < offset1AfterInsert.dy,
    isTrue,
    reason: 'POST-INSERT-AT-0: $msg0Text should be visually above $msg1Text',
  );

  // Update message2_5
  final updatedMessage2_5Text = '$msg2_5Text Updated!';
  // message2_5 is already a TextMessage, so we can use copyWith directly.
  final updatedMessage2_5 = message2_5.copyWith(text: updatedMessage2_5Text);

  await controller.updateMessage(message2_5, updatedMessage2_5);
  await tester.pumpAndSettle();

  // Verify message2_5 update and its position
  expect(
    find.text(updatedMessage2_5Text),
    findsOneWidget,
    reason: 'Updated text for msg2_5 should be visible',
  );
  expect(
    find.text(msg2_5Text),
    findsNothing,
    reason: 'Original text for msg2_5 should be gone after update',
  );
  expect(
    find.byKey(ValueKey(msg2_5Id)),
    findsOneWidget,
    reason: 'msg2_5 should still be findable by key after update',
  );

  // Re-verify visual order around the updated message2_5
  // We expect: ... msg2 < updated_msg2_5 < msg3 ...

  final msg2FinderAfterUpdate = find.text(msg2Text);
  final updatedMsg2_5FinderAfterUpdate = find.text(updatedMessage2_5Text);
  final msg3FinderAfterUpdate = find.text(msg3Text);

  // Ensure finders actually find something before getting offsets
  expect(msg2FinderAfterUpdate, findsOneWidget);
  expect(updatedMsg2_5FinderAfterUpdate, findsOneWidget);
  expect(msg3FinderAfterUpdate, findsOneWidget);

  final offset2AfterUpdate = tester.getTopLeft(msg2FinderAfterUpdate);
  final offsetUpdated2_5AfterUpdate = tester.getTopLeft(
    updatedMsg2_5FinderAfterUpdate,
  );
  final offset3AfterUpdate = tester.getTopLeft(msg3FinderAfterUpdate);

  expect(
    offset2AfterUpdate.dy < offsetUpdated2_5AfterUpdate.dy,
    isTrue,
    reason:
        'POST-UPDATE: $msg2Text should be visually above $updatedMessage2_5Text',
  );
  expect(
    offsetUpdated2_5AfterUpdate.dy < offset3AfterUpdate.dy,
    isTrue,
    reason:
        'POST-UPDATE: $updatedMessage2_5Text should be visually above $msg3Text',
  );

  // Remove updatedMessage2_5
  await controller.removeMessage(updatedMessage2_5);
  await tester.pumpAndSettle();

  // Verify message2_5 removal
  expect(
    find.text(updatedMessage2_5Text),
    findsNothing,
    reason: 'Updated text for msg2_5 should be gone after removal',
  );
  expect(
    find.byKey(ValueKey(msg2_5Id)),
    findsNothing,
    reason: 'msg2_5 should not be findable by key after removal',
  );

  // Verify surrounding messages are still present and order is maintained
  // We expect: ... msg0 < msg1 < msg2 < msg3 < msg4 ...
  final msg0FinderAfterRemove = find.text(msg0Text);
  final msg1FinderAfterRemove = find.text(msg1Text);
  final msg2FinderAfterRemove = find.text(msg2Text);
  final msg3FinderAfterRemove = find.text(msg3Text);
  final msg4FinderAfterRemove = find.text(msg4Text);

  expect(
    msg0FinderAfterRemove,
    findsOneWidget,
    reason: 'msg0 should still be present after msg2_5 removal',
  );
  expect(
    msg1FinderAfterRemove,
    findsOneWidget,
    reason: 'msg1 should still be present after msg2_5 removal',
  );
  expect(
    msg2FinderAfterRemove,
    findsOneWidget,
    reason: 'msg2 should still be present after msg2_5 removal',
  );
  expect(
    msg3FinderAfterRemove,
    findsOneWidget,
    reason: 'msg3 should still be present after msg2_5 removal',
  );
  expect(
    msg4FinderAfterRemove,
    findsOneWidget,
    reason: 'msg4 should still be present after msg2_5 removal',
  );

  final offset0AfterRemove = tester.getTopLeft(msg0FinderAfterRemove);
  final offset1AfterRemove = tester.getTopLeft(msg1FinderAfterRemove);
  final offset2AfterRemove = tester.getTopLeft(msg2FinderAfterRemove);
  final offset3AfterRemove = tester.getTopLeft(msg3FinderAfterRemove);
  final offset4AfterRemove = tester.getTopLeft(msg4FinderAfterRemove);

  // Check full order of remaining messages
  expect(
    offset0AfterRemove.dy < offset1AfterRemove.dy,
    isTrue,
    reason: 'POST-REMOVE: $msg0Text should be visually above $msg1Text',
  );
  expect(
    offset1AfterRemove.dy < offset2AfterRemove.dy,
    isTrue,
    reason: 'POST-REMOVE: $msg1Text should be visually above $msg2Text',
  );
  expect(
    offset2AfterRemove.dy < offset3AfterRemove.dy,
    isTrue,
    reason: 'POST-REMOVE: $msg2Text should be visually above $msg3Text',
  );
  expect(
    offset3AfterRemove.dy < offset4AfterRemove.dy,
    isTrue,
    reason: 'POST-REMOVE: $msg3Text should be visually above $msg4Text',
  );

  // Set messages to a new list: [message2, message1]
  // This will remove all other messages and change the order of msg1 and msg2.
  await controller.setMessages([message2, message1]);
  await tester.pumpAndSettle();

  // Verify setMessages operation
  // 1. Only msg1 and msg2 should be present
  expect(
    find.text(msg1Text),
    findsOneWidget,
    reason: 'msg1Text should be present after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg1Id)),
    findsOneWidget,
    reason: 'msg1Id should be present after setMessages',
  );
  expect(
    find.text(msg2Text),
    findsOneWidget,
    reason: 'msg2Text should be present after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg2Id)),
    findsOneWidget,
    reason: 'msg2Id should be present after setMessages',
  );

  // 2. All other messages should be gone
  expect(
    find.text(msg0Text),
    findsNothing,
    reason: 'msg0Text should be gone after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg0Id)),
    findsNothing,
    reason: 'msg0Id should be gone after setMessages',
  );
  expect(
    find.text(updatedMessage2_5Text),
    findsNothing,
    reason: 'updatedMessage2_5Text should be gone after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg2_5Id)),
    findsNothing,
    reason: 'msg2_5Id should be gone after setMessages',
  );
  expect(
    find.text(msg3Text),
    findsNothing,
    reason: 'msg3Text should be gone after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg3Id)),
    findsNothing,
    reason: 'msg3Id should be gone after setMessages',
  );
  expect(
    find.text(msg4Text),
    findsNothing,
    reason: 'msg4Text should be gone after setMessages',
  );
  expect(
    find.byKey(ValueKey(msg4Id)),
    findsNothing,
    reason: 'msg4Id should be gone after setMessages',
  );

  // 3. Verify new visual order: message2 should be above message1
  final msg1FinderAfterSet = find.text(msg1Text);
  final msg2FinderAfterSet = find.text(msg2Text);

  // Ensure finders still work for the remaining messages
  expect(msg1FinderAfterSet, findsOneWidget);
  expect(msg2FinderAfterSet, findsOneWidget);

  final offsetMsg1AfterSet = tester.getTopLeft(msg1FinderAfterSet);
  final offsetMsg2AfterSet = tester.getTopLeft(msg2FinderAfterSet);

  expect(
    offsetMsg2AfterSet.dy <
        offsetMsg1AfterSet.dy, // msg2 is now visually above msg1
    isTrue,
    reason: 'POST-SET: $msg2Text should be visually above $msg1Text',
  );
}

Future<void> _testSetOperations(
  WidgetTester tester,
  ChatController controller,
  String listTypePrefix,
) async {
  final msgAText = '$listTypePrefix Message A';
  final msgBText = '$listTypePrefix Message B';
  final msgCText = '$listTypePrefix Message C';
  final msgDText = '$listTypePrefix Message D';
  final msgEText = '$listTypePrefix Message E';

  final msgAId = '${listTypePrefix}_msgA';
  final msgBId = '${listTypePrefix}_msgB';
  final msgCId = '${listTypePrefix}_msgC';
  final msgDId = '${listTypePrefix}_msgD';
  final msgEId = '${listTypePrefix}_msgE';

  final messageA = TextMessage(
    id: msgAId,
    authorId: 'testUser1',
    text: msgAText,
  );
  final messageB = TextMessage(
    id: msgBId,
    authorId: 'testUser1',
    text: msgBText,
  );
  final messageC = TextMessage(
    id: msgCId,
    authorId: 'testUser1',
    text: msgCText,
  );
  final messageD = TextMessage(
    id: msgDId,
    authorId: 'testUser1',
    text: msgDText,
  );
  final messageE = TextMessage(
    id: msgEId,
    authorId: 'testUser1',
    text: msgEText,
  );

  // Ensure starting with a clean slate for this test function
  await controller.setMessages([]);
  await tester.pumpAndSettle();
  expect(find.text(msgAText), findsNothing);
  expect(find.text(msgBText), findsNothing);
  expect(find.text(msgCText), findsNothing);

  // Scenario 1: Set from 0 items to N items
  await controller.setMessages([messageA, messageB, messageC]);
  await tester.pumpAndSettle();

  expect(find.text(msgAText), findsOneWidget);
  expect(find.byKey(ValueKey(msgAId)), findsOneWidget);
  expect(find.text(msgBText), findsOneWidget);
  expect(find.byKey(ValueKey(msgBId)), findsOneWidget);
  expect(find.text(msgCText), findsOneWidget);
  expect(find.byKey(ValueKey(msgCId)), findsOneWidget);

  final offsetA1 = tester.getTopLeft(find.text(msgAText));
  final offsetB1 = tester.getTopLeft(find.text(msgBText));
  final offsetC1 = tester.getTopLeft(find.text(msgCText));

  expect(
    offsetA1.dy < offsetB1.dy,
    isTrue,
    reason: 'SC1: $msgAText < $msgBText',
  );
  expect(
    offsetB1.dy < offsetC1.dy,
    isTrue,
    reason: 'SC1: $msgBText < $msgCText',
  );

  // Scenario 2: Random set operation (N to M messages)
  // Current: [A, B, C]
  // Target:  [C, E, A, D]
  await controller.setMessages([messageC, messageE, messageA, messageD]);
  await tester.pumpAndSettle();

  // Verify new set is present
  expect(find.text(msgCText), findsOneWidget); // Was moved
  expect(find.byKey(ValueKey(msgCId)), findsOneWidget);
  expect(find.text(msgEText), findsOneWidget); // New
  expect(find.byKey(ValueKey(msgEId)), findsOneWidget);
  expect(find.text(msgAText), findsOneWidget); // Was moved
  expect(find.byKey(ValueKey(msgAId)), findsOneWidget);
  expect(find.text(msgDText), findsOneWidget); // New
  expect(find.byKey(ValueKey(msgDId)), findsOneWidget);

  // Verify msgB is gone
  expect(find.text(msgBText), findsNothing);
  expect(find.byKey(ValueKey(msgBId)), findsNothing);

  final offsetC2 = tester.getTopLeft(find.text(msgCText));
  final offsetE2 = tester.getTopLeft(find.text(msgEText));
  final offsetA2 = tester.getTopLeft(find.text(msgAText));
  final offsetD2 = tester.getTopLeft(find.text(msgDText));

  expect(
    offsetC2.dy < offsetE2.dy,
    isTrue,
    reason: 'SC2: $msgCText < $msgEText',
  );
  expect(
    offsetE2.dy < offsetA2.dy,
    isTrue,
    reason: 'SC2: $msgEText < $msgAText',
  );
  expect(
    offsetA2.dy < offsetD2.dy,
    isTrue,
    reason: 'SC2: $msgAText < $msgDText',
  );

  // Scenario 3: Set from M to 0 items
  // Current: [C, E, A, D]
  await controller.setMessages([]);
  await tester.pumpAndSettle();

  expect(find.text(msgCText), findsNothing);
  expect(find.byKey(ValueKey(msgCId)), findsNothing);
  expect(find.text(msgEText), findsNothing);
  expect(find.byKey(ValueKey(msgEId)), findsNothing);
  expect(find.text(msgAText), findsNothing);
  expect(find.byKey(ValueKey(msgAId)), findsNothing);
  expect(find.text(msgDText), findsNothing);
  expect(find.byKey(ValueKey(msgDId)), findsNothing);
}
