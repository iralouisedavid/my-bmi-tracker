import 'package:bmi_calculator/models/result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';


class DatabaseHelperTest {
  DatabaseHelperTest._();

  static final DatabaseHelperTest _instance = DatabaseHelperTest._();

  factory DatabaseHelperTest.getInstance(Database db) {
    _instance._database = db;
    return _instance;
  }

  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) {
          db.execute(
            'CREATE TABLE IF NOT EXISTS results(id INTEGER PRIMARY KEY, weight REAL, height REAL, age INTEGER, bmi REAL, status TEXT)',
          );
        });
    // create the results table if it does not exist
    await _database.execute(
      'CREATE TABLE IF NOT EXISTS results(id INTEGER PRIMARY KEY, weight REAL, height REAL, age INTEGER, bmi REAL, status TEXT)',
    );
  }

  Future<void> insertResult(Result result) async {
    try {
      if (!_database.isOpen) {
        await initDatabase();
      }
      await _database.insert('results', result.toMap());
    } catch (e) {
      print('Error inserting result: $e');
    }
  }

  Future<List<Result>> getResults() async {
    try {
      if (!_database.isOpen) {
        await initDatabase();
      }
      final List<Map<String, dynamic>> maps = await _database.query('results');
      return List.generate(maps.length, (i) {
        return Result.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error getting results: $e');
      return []; // or return null or throw an exception as appropriate
    }
  }

  Future<int> deleteResult(int id) async {
    if (!_database.isOpen) {
      await initDatabase();
    }
    // check if the ID exists in the database
    final List<Map<String, dynamic>> result =
    await _database.query('results', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) {
      print('ID not found in database');
      return 0;
    }

    // attempt to delete the row
    final int rowsDeleted =
    await _database.delete('results', where: 'id = ?', whereArgs: [id]);
    if (rowsDeleted > 0) {
      print('Row deleted successfully');
    } else {
      print('No rows were deleted');
    }

    return rowsDeleted;
  }
}



// class Cache {
//   Cache._(); // Private constructor
//
//   static final Cache _instance = Cache._(); // Singleton instance
//
//   factory Cache.getInstance() => _instance;
//
//   final List<Result> _cachedResults = [];
//
//   // Method to insert a new result in the cache
//   Future<void> insertResult(Result result) async {
//     _cachedResults.add(result);
//     //print('$result');
//   }
//
//   // Method to get all the results from the cache
//   Future<List<Result>> getResults() async {
//     //print(_cachedResults);
//     return _cachedResults;
//   }
// }
