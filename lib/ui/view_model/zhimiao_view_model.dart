import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hpv/model/entity/product_info.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info.dart';
import 'package:hpv/net/service/zhimiao_service.dart';

import 'base/base_list_model.dart';

class ZMViewModel extends BaseListModel<ZMHospitalInfo> {
  Map<int, Timer> appointmentTaskMap = {};

  @override
  Future<List<ZMHospitalInfo>> loadData() async {
    List<ZMHospitalInfo> list = [];
    var tempList = await zmService.getHospitalList();
    for (var info in tempList) {
      var products = await _getDetail(info.id);
      bool hasTargetProduct = false;
      for (ProductInfo product in products) {
        if (product.text?.startsWith('九价人乳头') ?? false) {
          info.jiuJiaProduct = product;
          hasTargetProduct = product.startDate != null;
        }

        if (product.text?.startsWith('四价人乳头') ?? false) {
          info.siJiaProduct = product;
          hasTargetProduct = product.startDate != null;
        }
      }

      if (hasTargetProduct) {
        list.add(info);
      }
    }
    return list;
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

  /// 添加预约任务
  void addAppointmentTask(ZMHospitalInfo hospitalInfo) {
    var id = hospitalInfo.id;
    if (id == null) {
      return;
    }
    if (appointmentTaskMap.containsKey(id)) {
      var timer = appointmentTaskMap[id];
      timer?.cancel();
    }
    appointmentTaskMap[id] = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {},
    );
  }

  @override
  void dispose() {
    appointmentTaskMap.forEach((key, value) {
      value.cancel();
    });
    super.dispose();
  }
}
