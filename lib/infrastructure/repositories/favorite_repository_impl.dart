import 'package:prueba_cyttek/domain/domain.dart';
import 'package:prueba_cyttek/infrastructure/datasource/favorite_datasource_impl.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  FavoriteRepositoryImpl({FavoriteDatasource? favoriteDatasource})
    : favoriteDatasource = favoriteDatasource ?? FavoriteDatasourceImpl();

  final FavoriteDatasource favoriteDatasource;

  @override
  Future<void> addFavorite(int noteId, String title, String description) {
    return favoriteDatasource.addFavorite(noteId, title, description);
  }

  @override
  Future<void> deleteFavorite(int id) {
    return favoriteDatasource.deleteFavorite(id);
  }

  @override
  Future<Favorite> getFavoriteById(int id) {
    return favoriteDatasource.getFavoriteById(id);
  }

  @override
  Future<List<Favorite>> getFavorites() {
    return favoriteDatasource.getFavorites();
  }
}
