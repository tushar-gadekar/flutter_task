import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';

class LocalDBService {
  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'users.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE users(id TEXT PRIMARY KEY, firstName TEXT, dob TEXT, mobile TEXT)''');
    });
  }

  Future<void> insertUser(UserModel user) async {
    final database = await db;
    await database.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UserModel>> getUsers() async {
    final database = await db;
    final maps = await database.query('users');
    return maps.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> deleteAll() async {
    final database = await db;
    await database.delete('users');
  }
}