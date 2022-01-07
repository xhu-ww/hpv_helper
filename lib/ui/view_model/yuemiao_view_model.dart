import 'package:flutter/widgets.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/model/entity/yuemiao_hospital_info.dart';
import 'package:hpv/net/service/yuemiao_service.dart';

import 'base/base_list_model.dart';

class YMViewModel extends BaseListModel<YMHospitalInfo> {
  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  @override
  Future<List<YMHospitalInfo>> loadData() {
    return ymService.getHospitalList();
  }

  void loadUserInfo({required String tk, required String cookie}) async {
    try {
      var user = await ymService.getUserInfo(tk: tk, cookie: cookie);
      _userInfo = user;
    } catch (e) {
      _userInfo = null;
      showErrorToast(error: e);
    } finally {
      notifyListeners();
    }
  }
}
