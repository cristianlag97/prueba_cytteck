part of 'screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);

    // Verificar si hay un error y mostrar un SnackBar
    if (notesState.errorMessage.isNotEmpty) {
      // Mostrar un SnackBar con el mensaje de error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(notesState.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    if (notesState.isLoading && notesState.status == NotesStatus.checking) {
      return Scaffold(body: const ShimmerCardLoading());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(PAGES.create.screenName);
        },
        child: const Icon(Icons.add),
      ),
      body:
          notesState.notes.isEmpty
              ? EmptyHome(message: 'Crea tu primera nota tocando el botón "+"')
              : ListViewWidget(notesState: notesState),
    );
  }
}
