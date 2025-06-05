import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// A widget to display the message timestamp and status indicator over an image.
class TimeAndStatus extends StatelessWidget {
  /// The time the message was created.
  final DateTime? time;

  /// The status of the message.
  final MessageStatus? status;

  /// Whether to display the timestamp.
  final bool showTime;

  /// Whether to display the status indicator.
  final bool showStatus;

  /// Background color for the time and status container.
  final Color? backgroundColor;

  /// Text style for the time and status.
  final TextStyle? textStyle;

  /// Creates a widget for displaying time and status over an image.
  const TimeAndStatus({
    super.key,
    required this.time,
    this.status,
    this.showTime = true,
    this.showStatus = true,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = context.watch<DateFormat>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
              Icon(
                getIconForStatus(status!),
                color: textStyle?.color,
                size: 12,
              ),
        ],
      ),
    );
  }
}
