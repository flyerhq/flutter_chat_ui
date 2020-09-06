import 'dart:math';

String formatBytes(num size, [int fractionDigits = 2]) {
  if (size <= 0) return '0 B';
  int multiple = (log(size) / log(1024)).floor();
  return (size / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
      ' ' +
      ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
}
