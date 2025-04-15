class Favorite {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description}';
  }
}
