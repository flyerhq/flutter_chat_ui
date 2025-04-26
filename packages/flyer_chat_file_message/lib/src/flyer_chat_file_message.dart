import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlyerChatFileMessage extends StatelessWidget {
  static const BorderRadiusGeometry _sentinelBorderRadius = BorderRadius.zero;
  static const Color _sentinelColor = Colors.transparent;
  static const TextStyle _sentinelTextStyle = TextStyle();

  final FileMessage message;
  final int index;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? iconSize;
  final IconData? icon;
  final Color? iconColor;
  final double? gap;
  final Color? sentBackgroundColor;
  final Color? receivedBackgroundColor;
  final TextStyle? sentNameTextStyle;
  final TextStyle? receivedNameTextStyle;
  final TextStyle? sentSizeTextStyle;
  final TextStyle? receivedSizeTextStyle;
  final TextStyle? timeStyle;
  final bool showTime;
  final bool showStatus;
  final TimeAndStatusPosition timeAndStatusPosition;

  const FlyerChatFileMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius = _sentinelBorderRadius,
    this.icon,
    this.iconSize = 24,
    this.gap = 8,
    this.iconColor = _sentinelColor,
    this.sentBackgroundColor = _sentinelColor,
    this.receivedBackgroundColor = _sentinelColor,
    this.sentNameTextStyle = _sentinelTextStyle,
    this.receivedNameTextStyle = _sentinelTextStyle,
    this.sentSizeTextStyle = _sentinelTextStyle,
    this.receivedSizeTextStyle = _sentinelTextStyle,
    this.timeStyle = _sentinelTextStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final isSentByMe = context.watch<UserID>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final nameTextStyle = _resolveNameTextStyle(isSentByMe, theme);
    final sizeTextStyle = _resolveSizeTextStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus =
        showTime || (isSentByMe && showStatus)
            ? TimeAndStatus(
              time: message.time,
              status: message.status,
              showTime: showTime,
              showStatus: isSentByMe && showStatus,
              textStyle: timeStyle,
            )
            : null;

    final sizeContent = Text(
      _formatFileSize(message.size ?? 0),
      style: sizeTextStyle,
    );

    final fileContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message.name,
          style: nameTextStyle?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        timeAndStatus == null ||
                timeAndStatusPosition != TimeAndStatusPosition.inline
            ? sizeContent
            : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [sizeContent, const SizedBox(width: 4), timeAndStatus],
            ),
      ],
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            borderRadius == _sentinelBorderRadius ? theme.shape : borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.insert_drive_file_outlined,
            color:
                iconColor == _sentinelColor
                    ? (isSentByMe
                        ? theme.colors.onPrimary
                        : theme.colors.onSurface)
                    : iconColor,
            size: iconSize,
          ),
          SizedBox(width: gap),
          Flexible(
            child: _buildContentBasedOnPosition(
              context: context,
              fileContent: fileContent,
              timeAndStatus: timeAndStatus,
              textStyle: sizeTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBasedOnPosition({
    required BuildContext context,
    required Widget fileContent,
    required TimeAndStatus? timeAndStatus,
    required TextStyle? textStyle,
  }) {
    if (timeAndStatus == null ||
        timeAndStatusPosition == TimeAndStatusPosition.inline) {
      return fileContent;
    }

    final textDirection = Directionality.of(context);
    switch (timeAndStatusPosition) {
      case TimeAndStatusPosition.start:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [fileContent, timeAndStatus],
        );
      case TimeAndStatusPosition.inline:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [fileContent, const SizedBox(width: 4), timeAndStatus],
        );
      case TimeAndStatusPosition.end:
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: textStyle?.lineHeight ?? 0),
              child: fileContent,
            ),
            Opacity(opacity: 0, child: timeAndStatus),
            Positioned.directional(
              textDirection: textDirection,
              end: 0,
              bottom: 0,
              child: timeAndStatus,
            ),
          ],
        );
    }
  }

  String _formatFileSize(int sizeInBytes) {
    if (sizeInBytes <= 0) return '0 B'; // Handle 0 or negative sizes

    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = 0;
    var size = sizeInBytes.toDouble();

    // Determine the correct unit index
    while (size >= 1024 && i < units.length - 1) {
      size /= 1024;
      i++;
    }

    // Use NumberFormat for locale-aware formatting.
    // It shows a decimal digit only if needed (e.g., 1.1 MB) and none otherwise (e.g., 1 MB).
    // For Bytes (i == 0), always show 0 decimal digits.
    final format = NumberFormat.decimalPatternDigits(
      locale: Intl.defaultLocale, // Uses the default locale set for the app
      decimalDigits: i == 0 ? 0 : 1,
    );

    return '${format.format(size)} ${units[i]}';
  }

  Color? _resolveBackgroundColor(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentBackgroundColor == _sentinelColor
          ? theme.colors.primary
          : sentBackgroundColor;
    }
    return receivedBackgroundColor == _sentinelColor
        ? theme.colors.surfaceContainer
        : receivedBackgroundColor;
  }

  TextStyle? _resolveNameTextStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentNameTextStyle == _sentinelTextStyle
          ? theme.typography.bodyMedium.copyWith(color: theme.colors.onPrimary)
          : sentNameTextStyle;
    }
    return receivedNameTextStyle == _sentinelTextStyle
        ? theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)
        : receivedNameTextStyle;
  }

  TextStyle? _resolveSizeTextStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentSizeTextStyle == _sentinelTextStyle
          ? theme.typography.bodySmall.copyWith(
            color: theme.colors.onPrimary.withValues(alpha: 0.8),
          )
          : sentSizeTextStyle;
    }
    return receivedSizeTextStyle == _sentinelTextStyle
        ? theme.typography.bodySmall.copyWith(
          color: theme.colors.onSurface.withValues(alpha: 0.8),
        )
        : receivedSizeTextStyle;
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, ChatTheme theme) {
    final color = isSentByMe ? theme.colors.onPrimary : theme.colors.onSurface;

    if (timeStyle == _sentinelTextStyle) {
      return theme.typography.labelSmall.copyWith(color: color);
    }

    return timeStyle;
  }
}

extension on TextStyle {
  double get lineHeight => (height ?? 1) * (fontSize ?? 0);
}

class TimeAndStatus extends StatelessWidget {
  final DateTime? time;
  final MessageStatus? status;
  final bool showTime;
  final bool showStatus;
  final TextStyle? textStyle;

  const TimeAndStatus({
    super.key,
    required this.time,
    this.status,
    this.showTime = true,
    this.showStatus = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = context.watch<DateFormat>();

    return Row(
      spacing: 2,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTime && time != null)
          Text(timeFormat.format(time!.toLocal()), style: textStyle),
        if (showStatus && status != null)
          if (status == MessageStatus.sending)
            SizedBox(
              width: 6,
              height: 6,
              child: CircularProgressIndicator(
                color: textStyle?.color,
                strokeWidth: 2,
              ),
            )
          else
            Icon(getIconForStatus(status!), color: textStyle?.color, size: 12),
      ],
    );
  }
}
