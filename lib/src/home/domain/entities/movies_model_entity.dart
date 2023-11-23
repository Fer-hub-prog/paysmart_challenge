import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoviesModelEntity {
  final int id;
  final String title;
  final String posterPath;
  MoviesModelEntity({
    required this.id,
    required this.title,
    required this.posterPath,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'posterPath': posterPath,
    };
  }

  factory MoviesModelEntity.fromMap(Map<String, dynamic> map) {
    return MoviesModelEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesModelEntity.fromJson(String source) => MoviesModelEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
