import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';

abstract class GetMovies {
  Future<List<MoviesModelEntity>> getMovies();
}
