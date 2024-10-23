import 'package:sembast_web/sembast_web.dart';

Future<Database> initialize() async {
  final database = await databaseFactoryWeb.openDatabase('chat.db');
  return database;
}
