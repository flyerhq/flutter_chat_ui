import 'package:json_annotation/json_annotation.dart';

/// Converts a [Duration] to and from an [int] representing seconds.
class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(seconds: json);

  @override
  int toJson(Duration object) => object.inSeconds;
}
