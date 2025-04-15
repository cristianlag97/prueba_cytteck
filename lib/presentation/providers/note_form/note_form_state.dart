part of 'note_form.dart';

class CreateNoteFormState {
  final bool isPosting;
  final bool isFormPosting;
  final bool isValid;
  final Title title;
  final Description description;
  final String errorMessage;

  CreateNoteFormState({
    this.isPosting = false,
    this.isFormPosting = false,
    this.isValid = false,
    this.title = const Title.pure(),
    this.description = const Description.pure(),
    this.errorMessage = '',
  });

  CreateNoteFormState copyWith({
    bool? isPosting,
    bool? isFormPosting,
    bool? isValid,
    Title? title,
    Description? description,
    String? errorMessage,
  }) {
    return CreateNoteFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosting: isFormPosting ?? this.isFormPosting,
      isValid: isValid ?? this.isValid,
      title: title ?? this.title,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'CreateNoteFormState(isPosting: $isPosting, isFormPosting: $isFormPosting, isValid: $isValid, title: $title, description: $description)';
  }
}
