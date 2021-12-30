import 'package:dio/dio.dart';
import 'package:hpv/net/interceptor/yuemiao_header_interceptor.dart';

final YMService ymService = YMService._internal();

class YMService {
  late Dio _dio;

  YMService._internal() {
    var options = BaseOptions(
      baseUrl: '',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll([
      YMHeaderInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
