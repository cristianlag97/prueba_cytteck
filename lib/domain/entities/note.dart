class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final int status;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description, createdAt: $createdAt, isFavorite: $status}';
  }
}
