import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// A class that represents additional space between messages.
@immutable
class MessageSpacer extends Equatable {
  /// Creates a MessageSpacer.
  const MessageSpacer({
    required this.height,
    required this.id,
  });

  /// Equatable props
  @override
  List<Object> get props => [height, id];

  /// Spacer's height
  final double height;

  /// Unique ID of the spacer
  final String id;
}
