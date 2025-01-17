import 'package:flutter_chat_core/flutter_chat_core.dart';

final List<Message> mockData = [
  TextMessage(
    id: '1',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029000000000,
      isUtc: true,
    ),
    text: 'Hey Jane, how are you?',
  ),
  TextMessage(
    id: '2',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029001000000,
      isUtc: true,
    ),
    text: "I'm doing great John, thanks for asking! How about you?",
  ),
  TextMessage(
    id: '3',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029002000000,
      isUtc: true,
    ),
    text: "I'm doing well too, thank you.",
  ),
  TextMessage(
    id: '4',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029003000000,
      isUtc: true,
    ),
    text: 'I just remembered about our high school reunion.',
  ),
  TextMessage(
    id: '5',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029004000000,
      isUtc: true,
    ),
    text: 'Oh really? When is it?',
  ),
  TextMessage(
    id: '6',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029005000000,
      isUtc: true,
    ),
    text: 'Next month, on the 15th.',
  ),
  TextMessage(
    id: '7',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029006000000,
      isUtc: true,
    ),
    text: 'I had completely forgotten about it. Thanks for reminding me!',
  ),
  TextMessage(
    id: '8',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029007000000,
      isUtc: true,
    ),
    text: 'No problem at all!',
  ),
  TextMessage(
    id: '9',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029008000000,
      isUtc: true,
    ),
    text: "I'm actually excited about it. It's been so long since we all met.",
  ),
  TextMessage(
    id: '10',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029009000000,
      isUtc: true,
    ),
    text: "Yeah, it's going to be great to see everyone again.",
  ),
  TextMessage(
    id: '11',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029010000000,
      isUtc: true,
    ),
    text: 'Do you remember any details about the event?',
  ),
  TextMessage(
    id: '12',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029011000000,
      isUtc: true,
    ),
    text: "I think it's going to be held at our old high school.",
  ),
  TextMessage(
    id: '13',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029012000000,
      isUtc: true,
    ),
    text: 'That sounds nostalgic. I wonder how much the place has changed.',
  ),
  TextMessage(
    id: '14',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029013000000,
      isUtc: true,
    ),
    text:
        "I heard they've renovated the auditorium. It should look amazing now.",
  ),
  TextMessage(
    id: '15',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029014000000,
      isUtc: true,
    ),
    text: "That's great! I'm looking forward to checking it out.",
  ),
  TextMessage(
    id: '16',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029015000000,
      isUtc: true,
    ),
    text: "It's going to be a memorable event for sure.",
  ),
  TextMessage(
    id: '17',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029016000000,
      isUtc: true,
    ),
    text: 'By the way, have you heard from anyone else about the reunion?',
  ),
  TextMessage(
    id: '18',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029017000000,
      isUtc: true,
    ),
    text: 'I bumped into Lisa the other day, and she mentioned attending.',
  ),
  TextMessage(
    id: '19',
    authorId: 'recipient',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029018000000,
      isUtc: true,
    ),
    text: "That's great to hear. I hope many of our classmates can make it.",
  ),
  TextMessage(
    id: '20',
    authorId: 'me',
    createdAt: DateTime.fromMicrosecondsSinceEpoch(
      1729029019000000,
      isUtc: true,
    ),
    text:
        'Yeah, it would be fantastic to catch up with everyone after all these years.',
  ),
];
