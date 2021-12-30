import 'package:dio/dio.dart';

/// 知苗Header
class ZMHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options
      ..headers['Referer'] =
          'https://servicewechat.com/wx2c7f0f3c30d99445/92/page-frame.html'
      ..headers['Connection'] = 'keep-alive'
      ..headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
