String formatDate(DateTime date) {
  final hour = date.hour % 12;
  final amPm = date.hour >= 12 ? 'PM' : 'AM';
  return '${date.day}/${date.month}/${date.year} $hour:${date.minute.toString().padLeft(2, '0')} $amPm';
}
