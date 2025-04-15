import 'package:sqflite/sqflite.dart';

import '../core.dart';

Future<Database> getDatabase() async {
  try {
    final db = await DatabaseService.instance.database;
    if (!db.isOpen) {
      throw CustomError(
        GeneralError.databaseError,
        'La base de datos no está inicializada correctamente.',
      );
    }
    return db;
  } catch (e) {
    throw CustomError(
      GeneralError.databaseError,
      'No se pudo conectar a la base de datos: $e',
    );
  }
}
