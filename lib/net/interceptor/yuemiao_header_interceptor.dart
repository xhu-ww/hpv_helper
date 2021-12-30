import 'package:dio/dio.dart';

/// 约苗Header
class YMHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Referer'] =
        'https://servicewechat.com/wx2c7f0f3c30d99445/92/page-frame.html';
    super.onRequest(options, handler);
  }
}
