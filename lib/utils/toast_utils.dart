import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hpv/net/interceptor/zhimiao_api_interceptor.dart';

/// Toast工具类
class MyToast {
  /// 网络请求时 弹窗错误信息
  static void showErrorToast({error, String? errorMessage}) {
    String? _errorMessage = errorMessage;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.cancel:
          _errorMessage = '网络连接超时';
          break;
        case DioErrorType.response:
          _errorMessage = error.message;
          break;
        case DioErrorType.other:
          var exception = error.error;
          if (exception is SocketException) {
            _errorMessage = '网络连接超时';
          } else {
            _errorMessage = error.message;
          }
          break;
      }
    } else if (error is NotSuccessException) {
      _errorMessage = error.message;
    }

    if (_errorMessage?.isNotEmpty ?? false) {
      EasyLoading.showError(_errorMessage!);
    }
  }
}
