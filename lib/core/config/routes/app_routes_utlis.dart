enum PAGES { splash, home_nav, home, create, edit, detail, favorites }

extension AppScreenExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.splash:
        return '/splash';
      case PAGES.home_nav:
        return '/';
      case PAGES.home:
        return '/home';
      case PAGES.create:
        return '/create';
      case PAGES.edit:
        return '/create/:id';
      case PAGES.detail:
        return '/detail:id';
      case PAGES.favorites:
        return '/favorites';
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.splash:
        return 'Splash_Screen';
      case PAGES.home_nav:
        return 'Home_Nav';
      case PAGES.home:
        return 'Home_Screen';
      case PAGES.create:
        return 'Create_Screen';
      case PAGES.edit:
        return 'Edit_Screen';
      case PAGES.detail:
        return 'Detail_Screen';
      case PAGES.favorites:
        return 'Favorites_Screen';
    }
  }
}
