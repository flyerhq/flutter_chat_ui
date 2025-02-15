import 'package:freezed_annotation/freezed_annotation.dart';

import 'epoch_date_time_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String id,
    String? firstName,
    String? lastName,
    String? imageSource,
    @EpochDateTimeConverter() DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
