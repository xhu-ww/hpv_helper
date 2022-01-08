import 'package:dio/dio.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/model/entity/yuemiao_hospital_info.dart';
import 'package:hpv/net/interceptor/yuemiao_header_interceptor.dart';
import 'package:hpv/net/interceptor/zhimiao_api_interceptor.dart';
import 'package:hpv/utils/json_transform_util.dart';

final YMService ymService = YMService._internal();

class YMService {
  late Dio _dio;

  YMService._internal() {
    var options = BaseOptions(
      baseUrl: 'https://miaomiao.scmttec.com',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll([
      YMHeaderInterceptor(),
      YMApiInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  void _setHeaderInfo({required String tk, required String cookie}) {
    _dio.options.headers['tk'] = tk;
    _dio.options.headers['cookie'] = cookie;
  }

  /// 获取九价医院列表
  Future<List<YMHospitalInfo>> getHospitalList() async {
    var response = await _dio.get(
      '/seckill/seckill/list.do',
      queryParameters: {
        'offset': 0,
        'limit': 20,
        'regionCode': 5101,
      },
    );
    var data = response.data;
    if (data == null) {
      return [];
    } else {
      return JsonTransformUtil.transformList(data)
          .map((e) => YMHospitalInfo.fromJson(e))
          .toList();
    }
  }

  Future<UserInfo?> getUserInfo({
    required String tk,
    required String cookie,
  }) async {
    _setHeaderInfo(tk: tk, cookie: cookie);
    var response = await _dio.get('/seckill/linkman/findByUserId.do');
    var data = response.data;
    if (data == null) {
      return null;
    } else {
      var list = JsonTransformUtil.transformList(data)
          .map((e) => UserInfo.fromJson(e))
          .toList();
      return list.isEmpty ? null : list.first;
    }
  }

  // 预约疫苗  seckillId={seckillId}&linkmanId={linkmanId}&idCardNo={idCardNo}&vaccineIndex={vaccineIndex
  Future reservation({
    required String tk,
    required String cookie,
    required int? seckillId,
    required int? linkmanId,
    required String? idCardNo,
    required String? vaccineIndex,
  }) async {
    _setHeaderInfo(tk: tk, cookie: cookie);
    await _dio.get(
      '/seckill/seckill/subscribe.do',
      queryParameters: {
        'seckillId': seckillId,
        'linkmanId': linkmanId,
        'idCardNo': idCardNo,
        'vaccineIndex': vaccineIndex,
      },
    );
  }
}
