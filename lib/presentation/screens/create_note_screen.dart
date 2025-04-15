part of 'screens.dart';

class CreateNoteScreen extends ConsumerStatefulWidget {
  final int? noteId;
  const CreateNoteScreen({super.key, this.noteId});

  @override
  ConsumerState<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends ConsumerState<CreateNoteScreen> {
  late final CreateNoteFormNotifier formNotifier;
  Note? editingNote;

  @override
  void initState() {
    super.initState();
    formNotifier = ref.read(notesFormProvider.notifier);

    // Si traemos un ID, precargamos el form
    if (widget.noteId != null) {
      final allNotes = ref.read(notesProvider).notes;
      final idx = allNotes.indexWhere((n) => n.id == widget.noteId);
      if (idx != -1) {
        editingNote = allNotes[idx];
        // precarga el formulario justo después del build
        Future.microtask(() {
          formNotifier.onTitleChanged(editingNote!.title);
          formNotifier.onDescriptionChanged(editingNote!.description);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.noteId != null && editingNote != null;
    final textTheme = Theme.of(context).textTheme;
    final notesForm = ref.watch(notesFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Editar Nota' : 'Crear Nota',
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _handleFormSubmission(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(size16),
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Título',
              initialValue: editingNote?.title,
              errorText:
                  notesForm.isFormPosting ? notesForm.title.errorMessage : null,
              onChanged: ref.read(notesFormProvider.notifier).onTitleChanged,
            ),
            const SizedBox(height: size16),
            CustomTextFormField(
              label: 'Descripción',
              initialValue: editingNote?.description,
              errorText:
                  notesForm.isFormPosting
                      ? notesForm.description.errorMessage
                      : null,
              maxLines: 6,
              onChanged:
                  ref.read(notesFormProvider.notifier).onDescriptionChanged,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleFormSubmission(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final notesForm = ref.read(notesFormProvider);
    if (notesForm.isPosting) return;

    final isValid = await ref
        .read(notesFormProvider.notifier)
        .onFormSubmitted(id: widget.noteId);

    if (isValid) {
      if (!context.mounted) return;
      // Mostrar SnackBar para éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nota creada/actualizada correctamente'),
          backgroundColor: Colors.green,
        ),
      );
      context.pushReplacement(PAGES.home_nav.screenPath);
    } else {
      if (!context.mounted) return;
      // Mostrar SnackBar para error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear o actualizar la nota'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
