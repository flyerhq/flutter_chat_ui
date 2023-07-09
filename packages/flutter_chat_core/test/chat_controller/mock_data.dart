import 'package:flutter_chat_core/flutter_chat_core.dart';

final List<Message> mockData = [
  TextMessage(
    id: '1',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368000000, isUtc: true),
    text: 'Hey Jane, how are you?',
  ),
  TextMessage(
    id: '2',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368001000, isUtc: true),
    text: "I'm doing great John, thanks for asking! How about you?",
  ),
  TextMessage(
    id: '3',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368002000, isUtc: true),
    text: "I'm doing well too, thank you.",
  ),
  TextMessage(
    id: '4',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368003000, isUtc: true),
    text: 'I just remembered about our high school reunion.',
  ),
  TextMessage(
    id: '5',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368004000, isUtc: true),
    text: 'Oh really? When is it?',
  ),
  TextMessage(
    id: '6',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368005000, isUtc: true),
    text: 'Next month, on the 15th.',
  ),
  TextMessage(
    id: '7',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368006000, isUtc: true),
    text: 'I had completely forgotten about it. Thanks for reminding me!',
  ),
  TextMessage(
    id: '8',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368007000, isUtc: true),
    text: 'No problem at all!',
  ),
  TextMessage(
    id: '9',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368008000, isUtc: true),
    text: "I'm actually excited about it. It's been so long since we all met.",
  ),
  TextMessage(
    id: '10',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368009000, isUtc: true),
    text: "Yeah, it's going to be great to see everyone again.",
  ),
  TextMessage(
    id: '11',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368010000, isUtc: true),
    text: 'Do you remember any details about the event?',
  ),
  TextMessage(
    id: '12',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368011000, isUtc: true),
    text: "I think it's going to be held at our old high school.",
  ),
  TextMessage(
    id: '13',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368012000, isUtc: true),
    text: 'That sounds nostalgic. I wonder how much the place has changed.',
  ),
  TextMessage(
    id: '14',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368013000, isUtc: true),
    text:
        "I heard they've renovated the auditorium. It should look amazing now.",
  ),
  TextMessage(
    id: '15',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368014000, isUtc: true),
    text: "That's great! I'm looking forward to checking it out.",
  ),
  TextMessage(
    id: '16',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368015000, isUtc: true),
    text: "It's going to be a memorable event for sure.",
  ),
  TextMessage(
    id: '17',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368016000, isUtc: true),
    text: 'By the way, have you heard from anyone else about the reunion?',
  ),
  TextMessage(
    id: '18',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368017000, isUtc: true),
    text: 'I bumped into Lisa the other day, and she mentioned attending.',
  ),
  TextMessage(
    id: '19',
    senderId: 'sender2',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368018000, isUtc: true),
    text: "That's great to hear. I hope many of our classmates can make it.",
  ),
  TextMessage(
    id: '20',
    senderId: 'sender1',
    timestamp: DateTime.fromMillisecondsSinceEpoch(1684368019000, isUtc: true),
    text:
        'Yeah, it would be fantastic to catch up with everyone after all these years.',
  ),
];
