import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const dbName = 'database.db';
  static const version = 1;
  static const tableName = 'mytable';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';

  static final DBHelper instance = DBHelper();
  static Database? _database;
  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: version, onCreate: oncreate);
  }

  Future oncreate(Database db, int version) async {
    await db.execute(''' 
      create table $tableName (
        $columnId integer primary key,
        $columnTitle Text not null,
        $columnDescription Text not null
      )
       ''');
  }

  insertDB(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryDB() async {
    Database? db = await instance.database;
    return await db!.query(tableName);
  }

  Future<int> updateDB(Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.update(tableName, row,
        where: '$columnId = ?', whereArgs: [row[columnId]]);
  }

  Future<int?> deleteDB(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableName, where: '$columnId = ? ', whereArgs: [id]);
  }
}
