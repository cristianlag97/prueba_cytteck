part of 'widgets.dart';

class MobileView extends ConsumerWidget {
  // final NotesState notesState;
  final List notes;
  final bool showFavorites;

  const MobileView({
    super.key,
    required this.notes,
    required this.showFavorites,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: size40),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: size8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: size16,
              vertical: size8,
            ),
            child: Stack(
              children: [
                NoteCard(
                  showFavorites: showFavorites,
                  note: note,
                  onDelete:
                      () =>
                          ref.read(notesProvider.notifier).deleteNote(note.id),
                  onTap:
                      () => context.pushNamed(
                        PAGES.detail.screenName,
                        pathParameters: {'id': note.id.toString()},
                      ),
                ),
                if (showFavorites)
                  Positioned(
                    top: 0,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        note.status == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: note.status == 1 ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        final newStatus = note.status == 1 ? 0 : 1;

                        ref
                            .read(notesProvider.notifier)
                            .updateNoteStatus(note.id, newStatus);
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
