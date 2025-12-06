import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Theme values for [FlyerChatFileMessage].
typedef _LocalTheme = ({
  TextStyle bodyMedium,
  TextStyle bodySmall,
  TextStyle labelSmall,
  Color onPrimary,
  Color onSurface,
  Color primary,
  BorderRadiusGeometry shape,
  Color surfaceContainer,
});

/// A widget that displays a file message.
///
/// Shows the file name, size, and an icon.
class FlyerChatFileMessage extends StatelessWidget {
  /// The file message data model.
  final FileMessage message;

  /// The index of the message in the list.
  final int index;

  /// Padding around the message bubble content.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the message bubble.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the file icon.
  final double? iconSize;

  /// IconData to represent the file type. Defaults to a generic file icon.
  final IconData? icon;

  /// Color of the file icon.
  final Color? iconColor;

  /// Gap between the icon and the text content.
  final double? gap;

  /// Background color for messages sent by the current user.
  final Color? sentBackgroundColor;

  /// Background color for messages received from other users.
  final Color? receivedBackgroundColor;

  /// Text style for the file name in messages sent by the current user.
  final TextStyle? sentNameTextStyle;

  /// Text style for the file name in messages received from other users.
  final TextStyle? receivedNameTextStyle;

  /// Text style for the file size in messages sent by the current user.
  final TextStyle? sentSizeTextStyle;

  /// Text style for the file size in messages received from other users.
  final TextStyle? receivedSizeTextStyle;

  /// Text style for the message timestamp and status.
  final TextStyle? timeStyle;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the text content.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// The widget to display on top of the message.
  final Widget? topWidget;

  /// Creates a widget to display a file message.
  const FlyerChatFileMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius,
    this.icon,
    this.iconSize = 24,
    this.gap = 8,
    this.iconColor,
    this.sentBackgroundColor,
    this.receivedBackgroundColor,
    this.sentNameTextStyle,
    this.receivedNameTextStyle,
    this.sentSizeTextStyle,
    this.receivedSizeTextStyle,
    this.timeStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.topWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        bodyMedium: t.typography.bodyMedium,
        bodySmall: t.typography.bodySmall,
        labelSmall: t.typography.labelSmall,
        onPrimary: t.colors.onPrimary,
        onSurface: t.colors.onSurface,
        primary: t.colors.primary,
        shape: t.shape,
        surfaceContainer: t.colors.surfaceContainer,
      ),
    );
    final isSentByMe = context.read<UserID>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final nameTextStyle = _resolveNameTextStyle(isSentByMe, theme);
    final sizeTextStyle = _resolveSizeTextStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus = showTime || (isSentByMe && showStatus)
        ? TimeAndStatus(
            time: message.resolvedTime,
            status: message.resolvedStatus,
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
                children: [
                  sizeContent,
                  const SizedBox(width: 4),
                  timeAndStatus,
                ],
              ),
      ],
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? theme.shape,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.insert_drive_file_outlined,
            color:
                iconColor ?? (isSentByMe ? theme.onPrimary : theme.onSurface),
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
    final textDirection = Directionality.of(context);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topWidget != null) topWidget!,
            // In comparison to other messages types, if timeAndStatusPosition is inline,
            // the fileContent is already a Row with the timeAndStatus widget inside it.
            fileContent,
            if (timeAndStatusPosition != TimeAndStatusPosition.inline)
              // Ensure the  width is not smaller than the timeAndStatus widget
              // Ensure the height accounts for it's height
              Opacity(opacity: 0, child: timeAndStatus),
          ],
        ),
        if (timeAndStatusPosition != TimeAndStatusPosition.inline &&
            timeAndStatus != null)
          Positioned.directional(
            textDirection: textDirection,
            end: timeAndStatusPosition == TimeAndStatusPosition.end ? 0 : null,
            start: timeAndStatusPosition == TimeAndStatusPosition.start
                ? 0
                : null,
            bottom: 0,
            child: timeAndStatus,
          ),
      ],
    );
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

  Color? _resolveBackgroundColor(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return sentBackgroundColor ?? theme.primary;
    }
    return receivedBackgroundColor ?? theme.surfaceContainer;
  }

  TextStyle? _resolveNameTextStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return sentNameTextStyle ??
          theme.bodyMedium.copyWith(color: theme.onPrimary);
    }
    return receivedNameTextStyle ??
        theme.bodyMedium.copyWith(color: theme.onSurface);
  }

  TextStyle? _resolveSizeTextStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return sentSizeTextStyle ??
          theme.bodySmall.copyWith(
            color: theme.onPrimary.withValues(alpha: 0.8),
          );
    }
    return receivedSizeTextStyle ??
        theme.bodySmall.copyWith(color: theme.onSurface.withValues(alpha: 0.8));
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, _LocalTheme theme) {
    final color = isSentByMe ? theme.onPrimary : theme.onSurface;

    return timeStyle ?? theme.labelSmall.copyWith(color: color);
  }
}

/// A widget to display the message timestamp and status indicator.
class TimeAndStatus extends StatelessWidget {
  /// The time the message was created.
  final DateTime? time;

  /// The status of the message.
  final MessageStatus? status;

  /// Whether to display the timestamp.
  final bool showTime;

  /// Whether to display the status indicator.
  final bool showStatus;

  /// The text style for the time and status.
  final TextStyle? textStyle;

  /// Creates a widget for displaying time and status.
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
