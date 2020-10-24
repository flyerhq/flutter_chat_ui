import 'package:meta/meta.dart';

enum MessageType {
  image,
  text,
}

@immutable
abstract class MessageModel {
  const MessageModel(
    this.authorId,
    this.id,
    this.timestamp,
    this.type,
  )   : assert(authorId != null),
        assert(id != null),
        assert(timestamp != null),
        assert(type != null);

  final String authorId;
  final String id;
  final int timestamp;
  final MessageType type;

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
  const ImageMessageModel({
    @required authorId,
    this.height,
    @required id,
    @required this.imageName,
    @required this.size,
    @required timestamp,
    @required this.url,
    this.width,
  })  : assert(imageName != null),
        assert(size != null),
        assert(url != null),
        super(authorId, id, timestamp, MessageType.text);

  final int height;
  final String imageName;
  final int size;
  final String url;
  final int width;

  ImageMessageModel.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        imageName = json['imageName'],
        size = json['size'],
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
  const TextMessageModel({
    @required authorId,
    @required id,
    @required this.text,
    @required timestamp,
  })  : assert(text != null),
        super(authorId, id, timestamp, MessageType.text);

  final String text;

  TextMessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        super(
          json['authorId'],
          json['id'],
          json['timestamp'],
          MessageType.text,
        );
}
