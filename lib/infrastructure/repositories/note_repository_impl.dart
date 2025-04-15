import 'package:prueba_cyttek/domain/datasource/note_datasource.dart';
import 'package:prueba_cyttek/domain/entities/note.dart';
import 'package:prueba_cyttek/domain/repositories/note_repository.dart';
import 'package:prueba_cyttek/infrastructure/datasource/note_datasource_impl.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl({NoteDatasource? noteDatasource})
    : noteDatasource = noteDatasource ?? NoteDatasourceImpl();

  final NoteDatasource noteDatasource;

  @override
  Future<void> addNote(String title, String description) {
    return noteDatasource.addNote(title, description);
  }

  @override
  Future<void> deleteNote(int id) {
    return noteDatasource.deleteNote(id);
  }

  @override
  Future<Note> getNoteById(int id) {
    return noteDatasource.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() {
    return noteDatasource.getNotes();
  }

  @override
  Future<void> updateNote(int id, String title, String description) {
    return noteDatasource.updateNote(id, title, description);
  }

  @override
  Future<void> updateStatusNote(int id, int status) {
    return noteDatasource.updateStatusNote(id, status);
  }
}
