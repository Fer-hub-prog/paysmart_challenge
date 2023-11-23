
import 'package:dio/dio.dart';

abstract class HomeRepository {
  Future<Response> getMovies();
  
}