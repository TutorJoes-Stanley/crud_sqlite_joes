import 'package:crud_sqlite_joes/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository
{
  late DatabaseConnection _databaseConnection;
  Repository(){
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  //Read All Record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Read a Single Record By ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }
  //Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete User
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

}