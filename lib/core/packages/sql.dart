import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Database? _db;

  final String databaseName = 'master_db.db';
  //* Notes
  final String notesTableName = 'notes';
  final String notesIdColumnName = 'id';
  final String notesTitleColumnName = 'title';
  final String notesDescriptionColumnName = 'description';
  final String noteCreateAtColumnName = 'createAt';
  final String noteStatusColumnName = 'status';

  //* Favorite
  final String favoriteTableName = 'favorite';
  final String favoriteIdColumnName = 'id';
  final String favoriteTitleColumnName = 'title';
  final String favoriteDescriptionColumnName = 'description';
  final String favoriteCreateAtColumnName = 'createAt';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, databaseName);
    final database = await openDatabase(
      databasePath,
      version: 3,
      onCreate: (db, version) async {
        // Crear la tabla de notas
        await db.execute('''
          CREATE TABLE $notesTableName (
            $notesIdColumnName INTEGER PRIMARY KEY,
            $notesTitleColumnName TEXT NOT NULL,
            $notesDescriptionColumnName TEXT NOT NULL,
            $noteCreateAtColumnName TEXT DEFAULT CURRENT_TIMESTAMP,
            $noteStatusColumnName INTEGER NOT NULL
          )
        ''');

        // Crear la tabla de favoritos
        await db.execute('''
        CREATE TABLE $favoriteTableName (
          $favoriteIdColumnName INTEGER PRIMARY KEY,
          $favoriteTitleColumnName TEXT NOT NULL,
          $favoriteDescriptionColumnName TEXT NOT NULL,
          $favoriteCreateAtColumnName TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
      },
    );
    return database;
  }
}
