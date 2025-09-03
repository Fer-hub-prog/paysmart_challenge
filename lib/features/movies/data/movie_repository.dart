import 'package:paysmart_challenge/core/result.dart';

import 'tmdb_api.dart';
import 'models/movie.dart';
import '../../movies/data/models/genre.dart';

class MovieRepository {
  final TmdbApi api;
  List<Genre> _genresCache = [];
  MovieRepository(this.api);
  Future<Result<(List<Movie> movies, int page, int totalPages)>> upcoming(
      int page) async {
    try {
      final res = await api.getUpcoming(page: page);
      final data = res.data as Map<String, dynamic>;
      final movies =
          (data['results'] as List).map((j) => Movie.fromJson(j)).toList();

      return Ok((movies, data['page'], data['total_pages']));
    } catch (e) {
      return Err(e);
    }
  }

  Future<Result<(List<Movie> movies, int page, int totalPages)>> search(
      String q, int page) async {
    try {
      final res = await api.searchMovies(query: q, page: page);
      final data = res.data as Map<String, dynamic>;
      final movies =
          (data['results'] as List).map((j) => Movie.fromJson(j)).toList();
      return Ok((movies, data['page'], data['total_pages']));
    } catch (e) {
      return Err(e);
    }
  }

  Future<Result<Movie>> details(int id) async {
    try {
      final res = await api.getMovieDetails(id);
      return Ok(Movie.fromJson(res.data));
    } catch (e) {
      return Err(e);
    }
  }

  Future<List<Genre>> genres() async {
    if (_genresCache.isNotEmpty) return _genresCache;
    final res = await api.getGenres();
    final list =
        (res.data['genres'] as List).map((j) => Genre.fromJson(j)).toList();
    _genresCache = list;
    return list;
  }
}
