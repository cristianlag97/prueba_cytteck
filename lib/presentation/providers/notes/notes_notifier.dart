part of 'notes.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  NotesNotifier({
    required this.notesRepository,
    required this.favoritesNotifier,
  }) : super(NotesState()) {
    getNotes();
  }

  final NoteRepository notesRepository;
  final FavoritesNotifier favoritesNotifier;

  Future<void> createNote(String title, String description) async {
    try {
      state = state.copyWith(isLoading: true);
      await notesRepository.addNote(title, description);
      final updatedNotes = await notesRepository.getNotes();
      state = state.copyWith(
        notes: updatedNotes,
        isLoading: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al crear la nota',
        isLoading: false,
      );
    }
  }

  Future<void> getNotes() async {
    try {
      final notes = await notesRepository.getNotes();
      if (notes.isEmpty) {
        state = state.copyWith(
          status: NotesStatus.empty,
          isLoading: false,
          errorMessage: '',
        );
      } else {
        state = state.copyWith(
          notes: notes,
          status: NotesStatus.loaded,
          isLoading: false,
          errorMessage: '',
        );
      }
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al cargar las notas',
        isLoading: false,
      );
    }
  }

  Future<void> getNoteById(int id) async {
    try {
      state = state.copyWith(isLoading: true);
      final note = await notesRepository.getNoteById(id);
      state = state.copyWith(note: note, isLoading: false, errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al cargar la nota',
        isLoading: false,
      );
    }
  }

  Future<void> deleteNote(int noteId) async {
    try {
      state = state.copyWith(isLoading: true);
      await notesRepository.deleteNote(noteId);
      await favoritesNotifier.deleteFavorite(noteId);
      final updatedNotes = await notesRepository.getNotes();
      state = state.copyWith(
        notes: updatedNotes,
        isLoading: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al eliminar la nota',
        isLoading: false,
      );
    }
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      await notesRepository.updateNote(id, title, description);
      final updatedNotes = await notesRepository.getNotes();
      state = state.copyWith(
        notes: updatedNotes,
        isLoading: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al actualizar la nota',
        isLoading: false,
      );
    }
  }

  Future<void> updateNoteStatus(int noteId, int status) async {
    try {
      state = state.copyWith(isLoading: true);
      await notesRepository.updateStatusNote(noteId, status);
      final updatedNotes = await notesRepository.getNotes();
      state = state.copyWith(
        notes: updatedNotes,
        isLoading: false,
        errorMessage: '',
      );

      // La actualización de favoritos
      if (status == 1) {
        // Si el estado es 1, agregar a favoritos
        final updatedNote = updatedNotes.firstWhere(
          (note) => note.id == noteId,
        );
        await favoritesNotifier.createFavorites(
          updatedNote.id,
          updatedNote.title,
          updatedNote.description,
        );
      } else {
        // Si el estado es 0, eliminar de favoritos
        await favoritesNotifier.deleteFavorite(noteId);
      }
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } on Exception catch (_) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado. Intenta de nuevo.',
        isLoading: false,
      );
    }
  }
}
