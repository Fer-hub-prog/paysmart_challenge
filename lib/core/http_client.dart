import 'package:dio/dio.dart';
import 'env.dart';

class HttpClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      queryParameters: {
        'api_key': Env.apiKey,
        'language': 'pt-BR',
      },
    ),
  );

  static Dio get instance => _dio;
}
