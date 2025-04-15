part of 'screens.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);

    if (favoritesState.isLoading &&
        favoritesState.status == FavoritesStatus.checking) {
      return Scaffold(body: const ShimmerCardLoading());
    }

    return Scaffold(
      body:
          favoritesState.favorites.isEmpty
              ? EmptyHome(message: 'añade tu primera nota desde inicio')
              : ListViewWidget(
                favoritesState: favoritesState,
                showFavorites: false,
              ),
    );
  }
}
