import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

types.PreviewData createPreviewData(PreviewData previewData) {
  final _previewDataImgage = types.PreviewDataImage(
    height: previewData.image.height,
    url: previewData.image.url,
    width: previewData.image.width,
  );

  return types.PreviewData(
    description: previewData.description,
    image: _previewDataImgage,
    link: previewData.link,
    title: previewData.title,
  );
}

PreviewData createChatPreviewData(types.PreviewData previewData) {
  final _previewDataImage = PreviewDataImage(
    height: previewData.image.height,
    url: previewData.image.url,
    width: previewData.image.width,
  );

  return PreviewData(
    description: previewData.description,
    image: _previewDataImage,
    link: previewData.link,
    title: previewData.title,
  );
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
