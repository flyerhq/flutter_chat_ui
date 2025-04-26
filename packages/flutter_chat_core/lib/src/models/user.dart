import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart' show UserID;
import 'epoch_date_time_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required UserID id,
    String? name,
    String? imageSource,
    @EpochDateTimeConverter() DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
