import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hpv/utils/json_transform_util.dart';

class YMApiInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ResponseData? respData;
    try {
      var json = JsonTransformUtil.jsonDecode(response.data);
      respData = ResponseData.fromJson(json);
    } catch (e) {
      debugPrint("---------ApiInterceptor: ${e.toString()}");
    }

    // 如果json格式不为标准格式，则不做处理
    if (respData == null) {
      super.onResponse(response, handler);
      return;
    }
    if (respData.success) {
      response.data = respData.data;
      super.onResponse(response, handler);
    } else {
      throw NotSuccessException.fromRespData(respData);
    }
  }
}

class ResponseData {
  bool? ok;
  String? message;
  dynamic data;

  bool get success => ok ?? false;

  ResponseData.fromJson(Map<String, dynamic> json) {
    message = json['msg'];
    data = json['data'];
    ok = json['ok'] ?? false;
  }
}

class NotSuccessException implements Exception {
  String? message;

  NotSuccessException.fromRespData(ResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return message ?? '未知错误';
  }
}
