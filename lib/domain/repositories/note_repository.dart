import 'package:prueba_cyttek/domain/entities/note.dart';

abstract class NoteRepository {
  Future<void> addNote(String title, String description);
  Future<void> updateNote(int id, String title, String description);
  Future<void> updateStatusNote(int id, int status);
  Future<Note> getNoteById(int id);
  Future<List<Note>> getNotes();
  Future<void> deleteNote(int id);
}
