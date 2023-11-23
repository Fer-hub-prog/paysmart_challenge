import 'package:dio/dio.dart';
import 'package:paysmart_challenge/core/rest_client.dart';
import 'package:paysmart_challenge/src/home/data/home_repository.dart';
import 'package:paysmart_challenge/src/home/home_locator.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _restClient = homeLocator.get<RestClient>();

  @override
  Future<Response> getMovies() async {
   return await _restClient.get(
        "movie/upcoming",
        queryParameters: {"language": "pt-BR"},
      );
      
  }
}
