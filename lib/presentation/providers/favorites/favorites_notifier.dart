part of 'favorites.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  FavoritesNotifier({required this.favoriteRepository})
    : super(FavoritesState()) {
    getFavorites();
  }

  final FavoriteRepository favoriteRepository;

  Future<void> createFavorites(
    int noteId,
    String title,
    String description,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      await favoriteRepository.addFavorite(noteId, title, description);
      final updatedNotes = await favoriteRepository.getFavorites();
      state = state.copyWith(favorites: updatedNotes, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } on Exception catch (_) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al crear la nota',
        isLoading: false,
      );
    }
  }

  Future<void> getFavorites() async {
    try {
      final notes = await favoriteRepository.getFavorites();
      if (notes.isEmpty) {
        state = state.copyWith(status: FavoritesStatus.empty, isLoading: false);
      } else {
        state = state.copyWith(
          favorites: notes,
          status: FavoritesStatus.loaded,
          isLoading: false,
        );
      }
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al cargar las notas',
        isLoading: false,
      );
    }
  }

  Future<void> getFavoriteById(int id) async {
    try {
      state = state.copyWith(isLoading: true);
      final note = await favoriteRepository.getFavoriteById(id);
      state = state.copyWith(favorite: note, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al cargar la nota',
        isLoading: false,
      );
    }
  }

  Future<void> deleteFavorite(int noteId) async {
    try {
      state = state.copyWith(isLoading: true);
      await favoriteRepository.deleteFavorite(noteId);
      final updatedNotes = await favoriteRepository.getFavorites();
      state = state.copyWith(favorites: updatedNotes, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al eliminar la nota',
        isLoading: false,
      );
    }
  }
}
