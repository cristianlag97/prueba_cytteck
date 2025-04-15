part of 'favorites.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
      final favoritesRepository = FavoriteRepositoryImpl();
      return FavoritesNotifier(favoriteRepository: favoritesRepository);
    });
