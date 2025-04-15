import 'dart:convert';

class Favorites {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  Favorites({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Favorites copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    int? isFavorite,
  }) {
    return Favorites(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) =>
      Favorites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Favorites(id: $id, title: $title, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Favorites other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }
}
