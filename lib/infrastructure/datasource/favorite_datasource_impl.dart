import 'package:prueba_cyttek/domain/datasource/favotire_datasource.dart';
import 'package:prueba_cyttek/domain/entities/favorite.dart';
import 'package:prueba_cyttek/infrastructure/models/favorites.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/core.dart';

class FavoriteDatasourceImpl extends FavoriteDatasource {
  @override
  Future<void> addFavorite(int noteId, String title, String description) async {
    if (title.isEmpty || description.isEmpty) {
      throw CustomError(
        GeneralError.invalidInput,
        'El título y la descripción no pueden estar vacíos',
      );
    }
    try {
      final db = await _getDatabase();
      await db.insert(DatabaseService.instance.favoriteTableName, {
        DatabaseService.instance.favoriteIdColumnName: noteId,
        DatabaseService.instance.favoriteTitleColumnName: title,
        DatabaseService.instance.favoriteDescriptionColumnName: description,
        DatabaseService.instance.favoriteCreateAtColumnName:
            DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al agregar el favorito: $e',
      );
    }
  }

  @override
  Future<void> deleteFavorite(int id) async {
    try {
      final db = await _getDatabase();
      final deletedCount = await db.delete(
        DatabaseService.instance.favoriteTableName,
        where: '${DatabaseService.instance.favoriteIdColumnName} = ?',
        whereArgs: [id],
      );
      if (deletedCount == 0) {
        throw CustomError(
          GeneralError.notFound,
          'No se encontró la nota con id $id para eliminar',
        );
      }
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al eliminar la favorito: $e',
      );
    }
  }

  @override
  Future<Favorite> getFavoriteById(int id) async {
    try {
      final db = await _getDatabase();

      final data = await db.query(
        DatabaseService.instance.favoriteTableName,
        where: '${DatabaseService.instance.favoriteIdColumnName} = ?',
        whereArgs: [id],
      );

      if (data.isNotEmpty) {
        return _mapToFavorite(data.first);
      } else {
        throw CustomError(
          GeneralError.notFound,
          'No se encontró la nota con id $id',
        );
      }
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al obtener la nota: $e',
      );
    }
  }

  @override
  Future<List<Favorite>> getFavorites() async {
    try {
      final db = await _getDatabase();
      final data = await db.query(DatabaseService.instance.favoriteTableName);
      return data.map((e) => _mapToFavorite(e)).toList();
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al obtener las notas: $e',
      );
    }
  }

  Future<Database> _getDatabase() async {
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

  Favorite _mapToFavorite(Map<String, dynamic> data) {
    final favorite = Favorites.fromMap(data);
    return Favorite(
      id: favorite.id,
      title: favorite.title,
      description: favorite.description,
      createdAt: favorite.createdAt,
    );
  }
}
