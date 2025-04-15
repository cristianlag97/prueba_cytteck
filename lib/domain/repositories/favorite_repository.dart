import 'package:prueba_cyttek/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(int noteId, String title, String description);
  Future<Favorite> getFavoriteById(int id);
  Future<List<Favorite>> getFavorites();
  Future<void> deleteFavorite(int id);
}
