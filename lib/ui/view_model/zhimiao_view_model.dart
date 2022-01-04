import 'package:flutter/cupertino.dart';
import 'package:hpv/model/entity/product_info.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info_entity.dart';
import 'package:hpv/net/service/zhimiao_service.dart';

import 'base/base_list_model.dart';

class ZMViewModel extends BaseListModel<ZMHospitalInfo> {
  @override
  Future<List<ZMHospitalInfo>> loadData() {
    return zmService.getHospitalList();
  }

  Future syncDetailData() async {
    for (var e in list) {
      var products = await _getDetail(e.id);
      e.setProducts(products);
    }
    notifyListeners();
  }

  // 每次请求间隔1秒，避免被判断为异常请求
  Future<List<ProductInfo>> _getDetail(int? id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var list = await zmService.getHospitalProduct(id: id);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
