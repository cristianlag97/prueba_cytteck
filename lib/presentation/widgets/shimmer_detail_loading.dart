part of 'widgets.dart';

class ShimmerDetailLoading extends StatelessWidget {
  const ShimmerDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de Nota')),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Placeholder for title
            Container(height: 20, width: double.infinity, color: Colors.white),
            const SizedBox(height: 10),
            // Placeholder for subtitle
            Container(height: 15, width: 150, color: Colors.white),
            const SizedBox(height: 20),
            // Placeholder for description
            Container(height: 15, width: double.infinity, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 15, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
