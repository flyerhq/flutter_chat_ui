import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> initialize() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, 'chat.db');
  final database = await databaseFactoryIo.openDatabase(dbPath);
  return database;
}
