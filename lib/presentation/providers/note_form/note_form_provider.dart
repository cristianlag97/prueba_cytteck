part of 'note_form.dart';

final notesFormProvider = StateNotifierProvider.autoDispose<
  CreateNoteFormNotifier,
  CreateNoteFormState
>((ref) {
  final notifier = ref.watch(notesProvider.notifier);
  return CreateNoteFormNotifier(
    noteCreateCallback: notifier.createNote,
    noteUpdateCallback: notifier.updateNote,
  );
});
