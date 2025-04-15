part of 'favorites.dart';

enum FavoritesStatus { checking, empty, loaded }

class FavoritesState {
  final List<Favorite> favorites;
  final Favorite? favorite;
  final FavoritesStatus status;
  final String errorMessage;
  final bool isLoading;

  FavoritesState({
    this.favorites = const [],
    this.favorite,
    this.status = FavoritesStatus.checking,
    this.errorMessage = '',
    this.isLoading = true,
  });

  FavoritesState copyWith({
    List<Favorite>? favorites,
    Favorite? favorite,
    FavoritesStatus? status,
    String? errorMessage,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favorite: favorite ?? this.favorite,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
