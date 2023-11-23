import 'package:dio/io.dart';

class RestClient extends DioForNative {
  RestClient() {
    options.baseUrl = "https://api.themoviedb.org/3/";
    options.connectTimeout = const Duration(seconds: 60);
    options.receiveTimeout = const Duration(seconds: 60);
    options.queryParameters = {"api_key": "bb4a9e4f78583423f01468872e77bc9c"};
  }
}
