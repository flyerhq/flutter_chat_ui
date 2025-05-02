import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart' show UserID;
import 'epoch_date_time_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents a user in the chat system.
@freezed
abstract class User with _$User {
  /// Creates a [User] instance.
  const factory User({
    /// Unique identifier for the user.
    required UserID id,

    /// The user's display name.
    String? name,

    /// URL or source string for the user's avatar image.
    String? imageSource,

    /// Timestamp when the user was created.
    @EpochDateTimeConverter() DateTime? createdAt,

    /// Additional custom metadata associated with the user.
    Map<String, dynamic>? metadata,
  }) = _User;

  const User._();

  /// Creates a [User] instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
