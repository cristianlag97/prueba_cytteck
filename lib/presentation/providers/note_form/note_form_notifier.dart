part of 'note_form.dart';

class CreateNoteFormNotifier extends StateNotifier<CreateNoteFormState> {
  CreateNoteFormNotifier({
    required this.noteCreateCallback,
    required this.noteUpdateCallback,
  }) : super(CreateNoteFormState());

  final Function(String, String) noteCreateCallback;
  final Future<void> Function({
    required int id,
    required String title,
    required String description,
  })
  noteUpdateCallback;

  void onTitleChanged(String title) {
    final newTitle = Title.dirty(title);
    state = state.copyWith(
      title: newTitle,
      isValid: Formz.validate([newTitle, state.description]),
    );
  }

  void onDescriptionChanged(String description) {
    final newDescription = Description.dirty(description);
    state = state.copyWith(
      description: newDescription,
      isValid: Formz.validate([newDescription, state.title]),
    );
  }

  Future<bool> onFormSubmitted({int? id}) async {
    _touchEveryField();

    if (!state.isValid) {
      return false;
    }

    state = state.copyWith(isPosting: true);

    try {
      if (id != null) {
        await noteUpdateCallback(
          id: id,
          title: state.title.value,
          description: state.description.value,
        );
      } else {
        await noteCreateCallback(state.title.value, state.description.value);
      }
      state = state.copyWith(
        title: const Title.pure(),
        description: const Description.pure(),
        isPosting: false,
        errorMessage: '',
      );
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message);
      return false;
    } on Exception catch (_) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado. Intenta de nuevo.',
      );
      return false;
    }
  }

  void _touchEveryField() {
    final title = Title.dirty(state.title.value);
    final description = Description.dirty(state.description.value);

    state = state.copyWith(
      isFormPosting: true,
      title: title,
      description: description,
      isValid: Formz.validate([title, description]),
      errorMessage: '',
    );
  }
}
