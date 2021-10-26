import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/src/models/message_spacer.dart';
import 'package:flutter_chat_ui/src/models/preview_image.dart';
import 'package:flutter_chat_ui/src/util.dart';
import 'package:flutter_chat_ui/src/chat_theme.dart' show colors;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatBytes', () {
    test('formats bytes correctly when the size is 0', () {
      expect(formatBytes(0), equals('0 B'));
    });

    test('formats bytes correctly', () {
      expect(formatBytes(1024), equals('1.00 kB'));
    });
  });

  group('getUserAvatarNameColor', () {
    test('returns correct avatar color', () {
      types.User user =
          const types.User(firstName: 'John', id: '1', lastName: 'Doe');
      expect(getUserAvatarNameColor(user, colors), const Color(0xff66e0da));
    });
  });

  group('getUserInitials', () {
    test('returns correct user initials', () {
      types.User user =
          const types.User(firstName: 'John', id: '1', lastName: 'Doe');
      expect(getUserInitials(user), 'JD');
    });
  });

  group('getUserName', () {
    test('returns correct user name when first name and last name provided',
        () {
      types.User user =
          const types.User(firstName: 'John', id: '1', lastName: 'Doe');
      expect(getUserName(user), 'John Doe');
    });

    test('returns correct user name when only first name provided', () {
      types.User user = const types.User(
        firstName: 'John',
        id: '1',
      );
      expect(getUserName(user), 'John');
    });

    test('returns correct user name when only last name provided', () {
      types.User user = const types.User(id: '1', lastName: 'Doe');
      expect(getUserName(user), 'Doe');
    });
  });

  group('getVerboseDateTimeRepresentation', () {
    test('returns correctly formatted date and time', () {
      expect(
        getVerboseDateTimeRepresentation(DateTime.utc(1989, 11, 9, 10)),
        'Nov 9, 10:00',
      );
    });
  });

  group('isConsistsOfEmojis', () {
    test('returns false if text doesnt contain emoji', () {
      types.TextMessage message = const types.TextMessage(
        author: types.User(id: '1'),
        id: '1',
        text: 'test',
      );
      expect(
        isConsistsOfEmojis(EmojiEnlargementBehavior.single, message),
        false,
      );
    });

    test('returns true if text contains emoji', () {
      types.TextMessage message = const types.TextMessage(
        author: types.User(id: '1'),
        id: '1',
        text: '😊',
      );
      expect(
        isConsistsOfEmojis(EmojiEnlargementBehavior.single, message),
        true,
      );
    });
  });

  group('calculateChatMessages', () {
    test('correctly returns calculated chat messages', () {
      types.User user = const types.User(id: '1');
      types.TextMessage message = types.TextMessage(
        author: user,
        id: '1',
        text: 'test',
      );
      types.ImageMessage imageMessage = types.ImageMessage(
        author: user,
        id: '2',
        name: 'test image',
        size: 200,
        uri: 'https://some.image',
      );
      expect(
          calculateChatMessages(
            [imageMessage, message],
            user,
            dateHeaderThreshold: 1000,
            groupMessagesThreshold: 1000,
            showUserNames: true,
          ),
          [
            [
              const MessageSpacer(height: 12.0, id: '2'),
              {
                'message': imageMessage,
                'nextMessageInGroup': false,
                'showName': false,
                'showStatus': true
              },
              const MessageSpacer(height: 12.0, id: '1'),
              {
                'message': message,
                'nextMessageInGroup': false,
                'showName': false,
                'showStatus': true
              }
            ],
            [const PreviewImage(id: '2', uri: 'https://some.image')]
          ]);
    });
  });
}
