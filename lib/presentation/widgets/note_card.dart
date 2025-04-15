part of 'widgets.dart';

class NoteCard extends StatelessWidget {
  final dynamic note;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool showFavorites;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
    this.showFavorites = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: size16, vertical: size8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size12),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          '${note.id}# ${note.title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing:
            showFavorites
                ? IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    // Confirmación opcional
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (_) => AlertDialog.adaptive(
                            title: const Text('Eliminar nota'),
                            content: const Text(
                              '¿Estás seguro que quieres eliminar esta nota?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                    );
                    if (confirmed != true) return;

                    onDelete();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nota eliminada')),
                    );
                  },
                )
                : null,
      ),
    );
  }
}
