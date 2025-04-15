part of 'widgets.dart';

class ListViewWidget extends ConsumerWidget {
  const ListViewWidget({
    super.key,
    this.notesState,
    this.favoritesState,
    this.showFavorites = true,
  });
  final NotesState? notesState;
  final FavoritesState? favoritesState;
  final bool showFavorites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        notesState?.isLoading == true || favoritesState?.isLoading == true;

    final isChecking =
        notesState?.status == NotesStatus.checking ||
        favoritesState?.status == FavoritesStatus.checking;

    if (isLoading || isChecking) {
      return const ShimmerCardLoading();
    }

    final state = notesState?.notes ?? favoritesState?.favorites ?? [];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Umbral arbitrario: si ancho >= 600, lo consideramos "tablet"
        final isTablet = constraints.maxWidth >= 600;

        if (isTablet) {
          // GridView para tablet
          return TabletView(notes: state, showFavorites: showFavorites);
        } else {
          // ListView para móvil
          return MobileView(notes: state, showFavorites: showFavorites);
        }
      },
    );
  }
}
