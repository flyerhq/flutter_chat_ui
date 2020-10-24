import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;
}
