import 'package:dio/dio.dart';
import '../../../core/http_client.dart';


class TmdbApi {
final Dio _dio = HttpClient.instance;


Future<Response> getUpcoming({int page = 1}) {
return _dio.get('/movie/upcoming', queryParameters: {'page': page});
}


Future<Response> searchMovies({required String query, int page = 1}) {
return _dio.get('/search/movie', queryParameters: {'query': query, 'page': page, 'include_adult': false});
}


Future<Response> getMovieDetails(int id) {
return _dio.get('/movie/$id');
}


Future<Response> getGenres() {
return _dio.get('/genre/movie/list');
}
}