import 'package:flutter/material.dart';

import '../../../core.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: size80,
              color: CyttekColor.greyColor,
            ),
            const SizedBox(height: size16),
            const Text(
              'Página no encontrada',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: size8),
            const Text(
              'Lo sentimos, no pudimos encontrar la ruta solicitada.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
