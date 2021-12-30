import 'package:flutter/cupertino.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info_entity.dart';
import 'package:hpv/net/service/zhimiao_service.dart';

import 'base/base_list_model.dart';

class ZMViewModel extends BaseListModel<ZMHospitalInfo> {
  @override
  Future<List<ZMHospitalInfo>> loadData() async {
    try {
      await zmService.getHospitalList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
