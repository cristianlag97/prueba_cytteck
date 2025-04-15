part of 'widgets.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add_outlined,
              size: size80,
              color: CyttekColor.grey400,
            ),
            const SizedBox(height: size20),
            Text(
              'No hay notas aún',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: CyttekColor.grey700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: size12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: CyttekColor.grey600),
            ),
          ],
        ),
      ),
    );
  }
}
