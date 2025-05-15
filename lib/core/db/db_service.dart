import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseService {
  static final DataBaseService _instance = DataBaseService._internal();
  static Database? _database;

  DataBaseService._internal();

  factory DataBaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    databaseFactory = databaseFactoryFfi;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'example_photo_database.db');

    print(path);
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS photos(id INTEGER PRIMARY KEY AUTOINCREMENT, photoId INTEGER UNIQUE)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertPhoto(Map<String, dynamic> photo) async {
    final db = await database;
    final id = db.insert(
      'photos',
      photo,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // notifyListeners();
    return id;
  }

  Future<List<int>> getFavoritePhotoIds() async {
    final db = await database;

    final result = await db.query('photos');

    return result.map((row) => row['photoId'] as int).toList();
  }

  //   Future<List<Map<String, dynamic>>> getPhotos() async {
  //   final db = await database;
  //   return await db.query('photos');
  // }

  // Future<int> updatePhoto(Map<String, dynamic> photo) async {
  //   final db = await database;
  //   final rowsAffected = await db.update(
  //     'photos',
  //     photo,
  //     where: 'id = ?',
  //     whereArgs: [photo['id']],
  //   );
  //   // If you want to notify listeners of changes after update:
  //   // notifyListeners();
  //   return rowsAffected;
  // }

  Future<int> deletePhoto(int id) async {
    final db = await database;
    final rowAffected = await db.delete(
      'photos',

      where: 'photoId =?',
      whereArgs: [id],
    );
    return rowAffected;
  }

  // Future<int> deletePhoto(int id) async {
  //   final db = await database;
  //   final rowsAffected = await db.delete(
  //     'photos',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //   // If you want to notify listeners of changes after deletion:
  //   // notifyListeners();
  //   return rowsAffected;
  // }
}
