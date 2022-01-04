import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hpv/model/entity/product_info.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info_entity.dart';
import 'package:hpv/net/interceptor/zhimiao_header_interceptor.dart';
import 'package:hpv/utils/json_transform_util.dart';

final ZMService zmService = ZMService._internal();

class ZMService {
  late Dio _dio;

  ZMService._internal() {
    var options = BaseOptions(
      baseUrl: 'https://cloud.cn2030.com',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll([
      ZMHeaderInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  /// 获取九价医院列表
  Future<List<ZMHospitalInfo>> getHospitalList() async {
    var response = await _dio.get(
      '/sc/wx/HandlerSubscribe.ashx',
      queryParameters: {
        'act': 'CustomerList',
        'city': json.encode(["四川省", "成都市", ""]),
        'lat': 30.642419815063477,
        'lng': 104.0431137084961,
        'id': 0,
        'cityCode': 510100,
        'product': 1
      },
    );
    var data = response.data;
    if (data == null) {
      return [];
    } else {
      var json = JsonTransformUtil.jsonDecode(data);
      return JsonTransformUtil.transformList(json['list'])
          .map((e) => ZMHospitalInfo.fromJson(e))
          .toList();
    }
  }

  /// 获取医院预约详细信息
  Future getHospitalDetail({required int? id}) async {
    var response = await _dio.get(
      '/sc/wx/HandlerSubscribe.ashx',
      queryParameters: {
        'act': 'GetCustSubscribeDateAll',
        'id': id,
        'pid': 1,
        'month': 202201,
      },
    );
    // var data = response.data;
    // if (data == null) {
    //   return [];
    // } else {
    //   var json = jsonDecode(data);
    //   return JsonTransformUtil.transformList(json['list'])
    //       .map((e) => ZMHospitalInfo.fromJson(e))
    //       .toList();
    // }
  }

  Future<List<ProductInfo>> getHospitalProduct({required int? id}) async {
    var response = await _dio.get(
      '/sc/wx/HandlerSubscribe.ashx',
      queryParameters: {
        'act': 'CustomerProduct',
        'id': id,
      },
    );
    var data = response.data;
    if (data == null) {
      return [];
    } else {
      var json = JsonTransformUtil.jsonDecode(data);
      return JsonTransformUtil.transformList(json['list'])
          .map((e) => ProductInfo.fromJson(e))
          .toList();
    }
  }
}
