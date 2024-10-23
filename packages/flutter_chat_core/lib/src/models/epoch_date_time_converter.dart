import 'package:json_annotation/json_annotation.dart';

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMicrosecondsSinceEpoch(
        json,
        isUtc: true,
      );

  @override
  int toJson(DateTime object) => object.toUtc().microsecondsSinceEpoch;
}
