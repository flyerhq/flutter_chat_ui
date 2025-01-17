import 'package:flutter_chat_core/flutter_chat_core.dart';

final List<Message> mockData = [
  TextMessage(
    id: '1',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893310000,
      isUtc: true,
    ),
    text: 'Hey Jane, how are you?',
  ),
  TextMessage(
    id: '2',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893311000,
      isUtc: true,
    ),
    text: "I'm doing great John, thanks for asking! How about you?",
  ),
  TextMessage(
    id: '3',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893312000,
      isUtc: true,
    ),
    text: "I'm doing well too, thank you.",
  ),
  TextMessage(
    id: '4',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893313000,
      isUtc: true,
    ),
    text: 'I just remembered about our high school reunion.',
  ),
  TextMessage(
    id: '5',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893314000,
      isUtc: true,
    ),
    text: 'Oh really? When is it?',
  ),
  TextMessage(
    id: '6',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893315000,
      isUtc: true,
    ),
    text: 'Next month, on the 15th.',
  ),
  TextMessage(
    id: '7',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893316000,
      isUtc: true,
    ),
    text: 'I had completely forgotten about it. Thanks for reminding me!',
  ),
  TextMessage(
    id: '8',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893317000,
      isUtc: true,
    ),
    text: 'No problem at all!',
  ),
  TextMessage(
    id: '9',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893318000,
      isUtc: true,
    ),
    text: "I'm actually excited about it. It's been so long since we all met.",
  ),
  TextMessage(
    id: '10',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893319000,
      isUtc: true,
    ),
    text: "Yeah, it's going to be great to see everyone again.",
  ),
  TextMessage(
    id: '11',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893320000,
      isUtc: true,
    ),
    text: 'Do you remember any details about the event?',
  ),
  TextMessage(
    id: '12',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893321000,
      isUtc: true,
    ),
    text: "I think it's going to be held at our old high school.",
  ),
  TextMessage(
    id: '13',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893322000,
      isUtc: true,
    ),
    text: 'That sounds nostalgic. I wonder how much the place has changed.',
  ),
  TextMessage(
    id: '14',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893323000,
      isUtc: true,
    ),
    text:
        "I heard they've renovated the auditorium. It should look amazing now.",
  ),
  TextMessage(
    id: '15',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893324000,
      isUtc: true,
    ),
    text: "That's great! I'm looking forward to checking it out.",
  ),
  TextMessage(
    id: '16',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893325000,
      isUtc: true,
    ),
    text: "It's going to be a memorable event for sure.",
  ),
  TextMessage(
    id: '17',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893326000,
      isUtc: true,
    ),
    text: 'By the way, have you heard from anyone else about the reunion?',
  ),
  TextMessage(
    id: '18',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893327000,
      isUtc: true,
    ),
    text: 'I bumped into Lisa the other day, and she mentioned attending.',
  ),
  TextMessage(
    id: '19',
    authorId: 'recipient',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893328000,
      isUtc: true,
    ),
    text: "That's great to hear. I hope many of our classmates can make it.",
  ),
  TextMessage(
    id: '20',
    authorId: 'me',
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      1736893329000,
      isUtc: true,
    ),
    text:
        'Yeah, it would be fantastic to catch up with everyone after all these years.',
  ),
];
