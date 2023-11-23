// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';

abstract class HomeState {
  final List<MoviesModelEntity>? moviesList;
  HomeState({
    this.moviesList,
  });
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {

}

class HomeErrorState extends HomeState {
  HomeErrorState({
    required List<MoviesModelEntity> movieList,
  }) : super(moviesList: movieList);
}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required List<MoviesModelEntity> movieList,
  }) : super(moviesList: movieList);
}
