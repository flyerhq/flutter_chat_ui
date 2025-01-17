// import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'mock_data.dart';

void main() {
  group('InMemoryChatController', () {
    // late InMemoryChatController inMemoryChatController;

    // setUp(() {
    //   inMemoryChatController = InMemoryChatController(messages: mockData);
    // });

    // test('inserts a new message at the end', () {
    //   final newMessage = TextMessage(
    //     id: '21',
    //     authorId: 'me',
    //     createdAt: DateTime.fromMillisecondsSinceEpoch(
    //       1736893310000,
    //       isUtc: true,
    //     ),
    //     text: 'test',
    //   );

    //   inMemoryChatController.insert(newMessage);

    //   expect(inMemoryChatController.get(20), newMessage);
    // });

    // test('removes first message using set', () {
    //   final newData = mockData.sublist(1);

    //   inMemoryChatController.set(newData);

    //   expect(inMemoryChatController.get(0).id, '2');
    // });

    // test('adds multiple messages using set', () {
    //   final newMessage1 = TextMessage(
    //     id: '21',
    //     authorId: 'me',
    //     createdAt: DateTime.fromMillisecondsSinceEpoch(
    //       1736893310000,
    //       isUtc: true,
    //     ),
    //     text: 'test',
    //   );

    //   final newMessage2 = TextMessage(
    //     id: '22',
    //     authorId: 'me',
    //     createdAt: DateTime.fromMillisecondsSinceEpoch(
    //       1736893310000,
    //       isUtc: true,
    //     ),
    //     text: 'test',
    //   );

    //   inMemoryChatController.set([...mockData, newMessage1, newMessage2]);

    //   expect(inMemoryChatController.get(20), newMessage1);
    //   expect(inMemoryChatController.get(21), newMessage2);
    // });

    // test('adds keeps inserted message when using set without it', () {
    //   final message = TextMessage(
    //     id: '21',
    //     authorId: 'me',
    //     createdAt: DateTime.fromMillisecondsSinceEpoch(
    //       1736893310000,
    //       isUtc: true,
    //     ),
    //     text: 'test',
    //   );

    //   inMemoryChatController.insert(message);

    //   expect(inMemoryChatController.get(20), message);

    //   inMemoryChatController.set(mockData);

    //   expect(inMemoryChatController.get(20), message);
    // });
  });
}
