import 'package:get_it/get_it.dart';
import 'package:paysmart_challenge/core/rest_client.dart';
import 'package:paysmart_challenge/src/home/data/home_repository.dart';
import 'package:paysmart_challenge/src/home/data/home_repository_impl.dart';
import 'package:paysmart_challenge/src/home/domain/usecases/get_movies/get_movies.dart';
import 'package:paysmart_challenge/src/home/domain/usecases/get_movies/get_movies_impl.dart';

final homeLocator = GetIt.instance;
void homeSetup() {
  homeLocator.registerSingleton<RestClient>(RestClient());
  homeLocator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  homeLocator.registerLazySingleton<GetMovies>(() => GetMoviesImpl());
}
