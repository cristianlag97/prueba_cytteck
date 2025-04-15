import 'package:go_router/go_router.dart';
import 'package:prueba_cyttek/core/config/routes/app_routes_utlis.dart';

import '../../../presentation/presentation.dart';
import 'screen/not_found_screen.dart';

class AppRoutes {
  AppRoutes._();

  static final router = GoRouter(
    initialLocation: PAGES.splash.screenPath,
    routes: [
      GoRoute(
        path: PAGES.splash.screenPath,
        name: PAGES.splash.screenName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: PAGES.home_nav.screenPath,
        name: PAGES.home_nav.screenName,
        builder: (context, state) => const HomeFavoritesView(),
      ),
      GoRoute(
        path: PAGES.home.screenPath,
        name: PAGES.home.screenName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: PAGES.create.screenPath,
        name: PAGES.create.screenName,
        builder: (context, state) => const CreateNoteScreen(),
      ),
      GoRoute(
        path: PAGES.edit.screenPath,
        name: PAGES.edit.screenName,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CreateNoteScreen(noteId: id);
        },
      ),
      GoRoute(
        path: PAGES.detail.screenPath,
        name: PAGES.detail.screenName,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return DetailScreen(id: int.parse(id));
        },
      ),
      GoRoute(
        path: PAGES.favorites.screenPath,
        name: PAGES.favorites.screenName,
        builder: (context, state) => const FavoritesScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
