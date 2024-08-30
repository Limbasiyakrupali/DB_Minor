import 'package:db_minor/model/jsonmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "first.db");

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE IF NOT EXISTS catagories(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT NOT NULL, author TEXT NOT NULL)";
        db.execute(query);
      },
    );
  }

  //  Uint8List? image
  Future<void> addDb(
    String quote,
    String author,
  ) async {
    if (database != null) {
      String query = "INSERT INTO catagories(quote,author) VALUES(?,?);";
      await database!.rawInsert(query, [quote, author]);
    } else {
      initDB();
    }
  }

  Future<void> removeDB(int id) async {
    if (database != null) {
      String query = "DELETE FROM catagories WHERE id=?;";
      List args = [id];
      await database!.rawDelete(query, args);
    } else {
      initDB();
    }
  }

  Future<void> removeAllDB() async {
    if (database != null) {
      String query = "DELETE FROM catagories;";
      await database!.rawDelete(query);
    } else {
      initDB();
    }
  }

  Future<List<Jsonmodel>> getAllData() async {
    if (database != null) {
      String query = "SELECT * FROM catagories;";
      List<Map<String, Object?>> result = await database!.rawQuery(query);
      return result.map((map) => Jsonmodel.fromMap(data: map)).toList();
    } else {
      initDB();
      return [];
    }
  }

  Future<List<Jsonmodel>> searchCategory({required String data}) async {
    if (database == null) {
      await initDB();
    }

    String query =
        "SELECT * FROM categories WHERE category_name LIKE '%$data%';";
    List<Map<String, dynamic>> searchCategory = await database!.rawQuery(query);

    List<Jsonmodel> allSearchCategory =
        searchCategory.map((e) => Jsonmodel.fromMap(data: e)).toList();
    return allSearchCategory;
  }
}
