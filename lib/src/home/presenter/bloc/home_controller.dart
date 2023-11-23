import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paysmart_challenge/src/home/domain/usecases/get_movies/get_movies.dart';
import 'package:paysmart_challenge/src/home/home_locator.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_event.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_state.dart';

class HomeController extends Bloc<HomeEvent, HomeState> {
  final _getMoviesService = homeLocator.get<GetMovies>();
  HomeController() : super(HomeInitialState()) {
    on<HomeInitialEvent>(_getMovies);
  }
  Future<void> _getMovies(HomeInitialEvent event, emit) async {
    final listMovies = await _getMoviesService.getMovies();
    emit(HomeLoadingState());
    if (listMovies.isEmpty) {
      emit(HomeErrorState(movieList: []));
    } else {
      emit(HomeSuccessState(movieList: listMovies));
    }
  }
}
