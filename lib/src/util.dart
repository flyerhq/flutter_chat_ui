import 'dart:math';
import 'package:intl/intl.dart';

/// Returns text representation of a provided bytes value (e.g. 1kB, 1GB)
String formatBytes(int size, [int fractionDigits = 2]) {
  if (size <= 0) return '0 B';
  final multiple = (log(size) / log(1024)).floor();
  return (size / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
      ' ' +
      ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
}

/// Returns formatted date used as a separator between different days in the
/// chat history. Supports today, yesterday and formatted date values.
String getVerboseDateTimeRepresentation(
  DateTime dateTime,
  String? locale,
  String todayText,
  String yesterdayText,
) {
  final now = DateTime.now();
  final localDateTime = dateTime.toLocal();

  if (localDateTime.day == now.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return todayText;
  }

  final yesterday = now.subtract(const Duration(days: 1));

  if (localDateTime.day == yesterday.day &&
      localDateTime.month == yesterday.month &&
      localDateTime.year == yesterday.year) {
    return yesterdayText;
  }

  return DateFormat.MMMMd(locale).format(dateTime);
}
