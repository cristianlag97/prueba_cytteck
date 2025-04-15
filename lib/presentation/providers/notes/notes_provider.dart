part of 'notes.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  final notesRepository = NoteRepositoryImpl();
  final favoritesNotifier = ref.watch(favoritesProvider.notifier);
  return NotesNotifier(
    notesRepository: notesRepository,
    favoritesNotifier: favoritesNotifier,
  );
});
