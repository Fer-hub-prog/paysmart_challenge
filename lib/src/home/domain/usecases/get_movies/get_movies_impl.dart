import 'package:paysmart_challenge/src/home/data/home_repository.dart';
import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';
import 'package:paysmart_challenge/src/home/domain/usecases/get_movies/get_movies.dart';
import 'package:paysmart_challenge/src/home/home_locator.dart';

class GetMoviesImpl implements GetMovies {
  final _homeRepository = homeLocator.get<HomeRepository>();

  @override
  Future<List<MoviesModelEntity>> getMovies() async {
    try {
      final result = await _homeRepository.getMovies();
      final data = result.data["results"];
      if (data != null) {
        return data
            .map<MoviesModelEntity>((movie) => MoviesModelEntity.fromMap(movie))
            .toList();
      } else {
        return <MoviesModelEntity>[];
      }
    } catch (e) {
      return throw Exception("erro ao pegar filmes");
    }
  }
}
