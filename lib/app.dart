import 'package:flutter/material.dart';
import 'core/core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      routerConfig: AppRoutes.router,
      theme: AppTheme.instance.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
