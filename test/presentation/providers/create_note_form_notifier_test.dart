import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_cyttek/presentation/providers/note_form/note_form.dart';
import 'package:prueba_cyttek/core/packages/formz_package/description.dart'
    as custom;

void main() {
  group('CreateNoteFormNotifier', () {
    test('starts with empty state', () {
      final container = ProviderContainer();
      final state = container.read(notesFormProvider);

      expect(state.title.value, '');
      expect(state.description.value, '');
    });

    test('updates title and description', () {
      final container = ProviderContainer();
      final notifier = container.read(notesFormProvider.notifier);

      notifier.onTitleChanged('Mi título');
      notifier.onDescriptionChanged('Mi descripción');

      final state = container.read(notesFormProvider);
      expect(state.title.value, 'Mi título');
      expect(state.description.value, 'Mi descripción');
    });

    test('updates title and description', () async {
      final container = ProviderContainer();
      final notifier = container.read(notesFormProvider.notifier);

      notifier.onTitleChanged('Título');
      notifier.onDescriptionChanged('');

      final result = await notifier.onFormSubmitted();
      final state = container.read(notesFormProvider);

      expect(result, false);
      expect(state.description.error, custom.DescriptionError.empty);
    });
  });
}
