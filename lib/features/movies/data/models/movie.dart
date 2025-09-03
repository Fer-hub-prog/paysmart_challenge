class Movie {
final int id;
final String title;
final String? posterPath;
final String? backdropPath;
final List<int> genreIds; // na listagem
final List<dynamic>? genres; // no details pode vir como objetos
final String? overview;
final String? releaseDate;


Movie({
required this.id,
required this.title,
this.posterPath,
this.backdropPath,
required this.genreIds,
this.genres,
this.overview,
this.releaseDate,
});


factory Movie.fromJson(Map<String, dynamic> json) => Movie(
id: json['id'],
title: json['title'] ?? json['name'] ?? '-',
posterPath: json['poster_path'],
backdropPath: json['backdrop_path'],
genreIds: (json['genre_ids'] as List?)?.map((e) => e as int).toList() ?? const [],
genres: json['genres'],
overview: json['overview'],
releaseDate: json['release_date'],
);
}