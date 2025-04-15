part of 'screens.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(notesProvider.notifier).getNoteById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final note = ref.watch(notesProvider).note;
    final isLoading = ref.watch(notesProvider).isLoading;
    final textTheme = Theme.of(context).textTheme;

    if (isLoading) {
      return ShimmerDetailLoading();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            PAGES.edit.screenName,
            pathParameters: {'id': widget.id.toString()},
          );
        },
        tooltip: 'Editar nota',
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: Text(
          note?.title ?? '',
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '${note?.id}# ${note?.title ?? ''}',
                      style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (note?.status == 1)
                    const Icon(Icons.favorite, color: Colors.red),
                ],
              ),
              const SizedBox(height: size8),
              if (note?.createdAt != null)
                Text(
                  'Creado en: ${formatDate(note!.createdAt)}',
                  style: textTheme.labelMedium,
                ),
              const SizedBox(height: size12),
              Text(note?.description ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
