import 'package:json_annotation/json_annotation.dart';

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(
        json,
        isUtc: true,
      );

  @override
  int toJson(DateTime object) => object.toUtc().millisecondsSinceEpoch;
}
