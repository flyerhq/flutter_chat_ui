import 'package:meta/meta.dart';

enum MessageType {
  image,
  text,
}

@immutable
abstract class MessageModel {
  final String authorId;
  final String id;
  final int timestamp;
  final MessageType type;

  const MessageModel(
    this.authorId,
    this.id,
    this.timestamp,
    this.type,
  )   : assert(authorId != null),
        assert(id != null),
        assert(timestamp != null),
        assert(type != null);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String type = json['type'];

    switch (type) {
      case 'image':
        return ImageMessageModel.fromJson(json);
      case 'text':
        return TextMessageModel.fromJson(json);
      default:
        return null;
    }
  }
}

@immutable
class ImageMessageModel extends MessageModel {
  final num height;
  final String url;
  final num width;

  ImageMessageModel({
    @required authorId,
    this.height,
    @required id,
    @required timestamp,
    @required this.url,
    this.width,
  })  : assert(url != null),
        super(authorId, id, timestamp, MessageType.text);

  ImageMessageModel.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        url = json['url'],
        width = json['width'],
        super(
          json['authorId'],
          json['id'],
          json['timestamp'],
          MessageType.image,
        );
}

@immutable
class TextMessageModel extends MessageModel {
  final String text;

  TextMessageModel({
    @required authorId,
    @required id,
    @required this.text,
    @required timestamp,
  })  : assert(text != null),
        super(authorId, id, timestamp, MessageType.text);

  TextMessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        super(
          json['authorId'],
          json['id'],
          json['timestamp'],
          MessageType.text,
        );
}
