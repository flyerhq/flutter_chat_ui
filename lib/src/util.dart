import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

types.PreviewData createPreviewData(PreviewData previewData) {
  final _previewData = types.PreviewData();

  final _previewDataImgage = types.PreviewDataImage(
    height: previewData.image.height,
    url: previewData.image.url,
    width: previewData.image.width,
  );

  _previewData.description = previewData.description;
  _previewData.image = _previewDataImgage;
  _previewData.link = previewData.link;
  _previewData.title = previewData.title;

  return _previewData;
}

PreviewData createChatPreviewData(types.PreviewData previewData) {
  final _previewData = PreviewData();

  final _previewDataImgage = PreviewDataImage(
    height: previewData.image.height,
    url: previewData.image.url,
    width: previewData.image.width,
  );

  _previewData.description = previewData.description;
  _previewData.image = _previewDataImgage;
  _previewData.link = previewData.link;
  _previewData.title = previewData.title;

  return _previewData;
}

String formatBytes(int size, [int fractionDigits = 2]) {
  if (size <= 0) return '0 B';
  int multiple = (log(size) / log(1024)).floor();
  return (size / pow(1024, multiple)).toStringAsFixed(fractionDigits) +
      ' ' +
      ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][multiple];
}

String getVerboseDateTimeRepresentation(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime localDateTime = dateTime.toLocal();

  if (localDateTime.day == now.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return 'Today';
  }

  DateTime yesterday = now.subtract(Duration(days: 1));

  if (localDateTime.day == yesterday.day &&
      localDateTime.month == yesterday.month &&
      localDateTime.year == yesterday.year) {
    return 'Yesterday';
  }

  return DateFormat.d().add_MMMM().format(dateTime);
}
