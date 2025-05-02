import 'package:json_annotation/json_annotation.dart';

/// A [JsonConverter] for converting between [DateTime] and epoch timestamps (milliseconds since epoch).
class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  /// Creates a const instance of [EpochDateTimeConverter].
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json, isUtc: true);

  @override
  int toJson(DateTime object) => object.toUtc().millisecondsSinceEpoch;
}
