import 'dart:convert';

class Notes {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final int status;

  Notes({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  Notes copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    int? status,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createAt'] as String),
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notes(id: $id, title: $title, description: $description, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(covariant Notes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        status.hashCode;
  }
}
