import 'package:prueba_cyttek/domain/datasource/note_datasource.dart';
import 'package:prueba_cyttek/domain/entities/note.dart';
import 'package:prueba_cyttek/infrastructure/models/notes.dart';

import '../../core/core.dart';

class NoteDatasourceImpl extends NoteDatasource {
  @override
  Future<bool> addNote(String title, String description) async {
    try {
      final db = await DatabaseService.instance.database;
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
      final db = await DatabaseService.instance.database;

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
      final db = await DatabaseService.instance.database;

      final data = await db.query(
        DatabaseService.instance.notesTableName,
        where: '${DatabaseService.instance.notesIdColumnName} = ?',
        whereArgs: [id],
      );

      if (data.isNotEmpty) {
        final noteMap = data.first;
        final note = Notes.fromMap(noteMap);
        return Note(
          id: note.id,
          title: note.title,
          description: note.description,
          createdAt: note.createdAt,
          status: note.status,
        );
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
      final db = await DatabaseService.instance.database;
      final data = await db.query(DatabaseService.instance.notesTableName);
      final notes = data.map((e) => Notes.fromMap(e)).toList();
      return notes
          .map(
            (e) => Note(
              id: e.id,
              title: e.title,
              description: e.description,
              createdAt: e.createdAt,
              status: e.status,
            ),
          )
          .toList();
    } catch (e) {
      throw CustomError(
        GeneralError.unknownError,
        'Error al obtener las notas: $e',
      );
    }
  }

  @override
  Future<void> updateNote(int id, String title, String description) async {
    try {
      final db = await DatabaseService.instance.database;
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
      final db = await DatabaseService.instance.database;
      final updatedCount = await db.update(
        DatabaseService.instance.notesTableName,
        {DatabaseService.instance.noteStatusColumnName: status},
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
}
