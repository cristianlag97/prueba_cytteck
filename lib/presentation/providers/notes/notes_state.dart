part of 'notes.dart';

enum NotesStatus { checking, empty, loaded }

class NotesState {
  final List<Note> notes;
  final Note? note;
  final NotesStatus status;
  final String errorMessage;
  final bool isLoading;

  NotesState({
    this.notes = const [],
    this.note,
    this.status = NotesStatus.checking,
    this.errorMessage = '',
    this.isLoading = true,
  });

  NotesState copyWith({
    List<Note>? notes,
    Note? note,
    NotesStatus? status,
    String? errorMessage,
    bool? isLoading,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      note: note ?? this.note,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
