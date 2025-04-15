import 'package:flutter/material.dart';
import 'package:prueba_cyttek/presentation/presentation.dart';

class HomeFavoritesView extends StatefulWidget {
  const HomeFavoritesView({super.key});

  @override
  State<HomeFavoritesView> createState() => _HomeFavoritesViewState();
}

class _HomeFavoritesViewState extends State<HomeFavoritesView> {
  int currentIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), FavoritesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
