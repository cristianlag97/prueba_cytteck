import 'package:prueba_cyttek/domain/datasource/note_datasource.dart';
import 'package:prueba_cyttek/domain/entities/note.dart';
import 'package:prueba_cyttek/infrastructure/models/notes.dart';

import '../../core/core.dart';
import '../../core/helpers/get_database.dart';

class NoteDatasourceImpl extends NoteDatasource {
  @override
  Future<bool> addNote(String title, String description) async {
    if (title.isEmpty || description.isEmpty) {
      throw CustomError(
        GeneralError.invalidInput,
        'El título y la descripción no pueden estar vacíos',
      );
    }
    try {
      final db = await getDatabase();
      await db.insert(DatabaseService.instance.notesTableName, {
        DatabaseService.instance.notesTitleColumnName: title,
        DatabaseService.instance.notesDescriptionColumnName: description,
        DatabaseService.instance.noteCreateAtColumnName:
            DateTime.now().toIso8601String(),
        DatabaseService.instance.noteStatusColumnName: 0,
      });
      return true;
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al agregar la nota: $e',
      );
    }
  }

  @override
  Future<void> deleteNote(int id) async {
    try {
      final db = await getDatabase();
      final deletedCount = await db.delete(
        DatabaseService.instance.notesTableName,
        where: '${DatabaseService.instance.notesIdColumnName} = ?',
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
        'Error al eliminar la nota: $e',
      );
    }
  }

  @override
  Future<Note> getNoteById(int id) async {
    try {
      final db = await getDatabase();
      final data = await db.query(
        DatabaseService.instance.notesTableName,
        where: '${DatabaseService.instance.notesIdColumnName} = ?',
        whereArgs: [id],
      );
      if (data.isNotEmpty) {
        return _mapToNote(data.first);
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
  Future<List<Note>> getNotes() async {
    try {
      final db = await getDatabase();
      final data = await db.query(DatabaseService.instance.notesTableName);
      return data.map(_mapToNote).toList();
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al obtener las notas: $e',
      );
    }
  }

  @override
  Future<void> updateNote(int id, String title, String description) async {
    if (title.isEmpty || description.isEmpty) {
      throw CustomError(
        GeneralError.invalidInput,
        'El título y la descripción no pueden estar vacíos',
      );
    }
    try {
      final db = await getDatabase();
      final updatedCount = await db.update(
        DatabaseService.instance.notesTableName,
        {
          DatabaseService.instance.notesTitleColumnName: title,
          DatabaseService.instance.notesDescriptionColumnName: description,
        },
        where: '${DatabaseService.instance.notesIdColumnName} = ?',
        whereArgs: [id],
      );
      if (updatedCount == 0) {
        throw CustomError(
          GeneralError.notFound,
          'No se encontró la nota con id $id para actualizar',
        );
      }
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al actualizar la nota: $e',
      );
    }
  }

  @override
  Future<void> updateStatusNote(int id, int status) async {
    try {
      final db = await getDatabase();
      final updatedCount = await db.update(
        DatabaseService.instance.notesTableName,
        {DatabaseService.instance.noteStatusColumnName: status},
        where: '${DatabaseService.instance.notesIdColumnName} = ?',
        whereArgs: [id],
      );
      if (updatedCount == 0) {
        throw CustomError(
          GeneralError.notFound,
          'No se encontró la nota con id $id para cambiar el estado',
        );
      }
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al cambiar el estado de la nota: $e',
      );
    }
  }

  Note _mapToNote(Map<String, dynamic> data) {
    final note = Notes.fromMap(data);
    return Note(
      id: note.id,
      title: note.title,
      description: note.description,
      createdAt: note.createdAt,
      status: note.status,
    );
  }
}
