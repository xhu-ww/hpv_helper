import 'dart:async';

import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/model/entity/yuemiao_hospital_info.dart';
import 'package:hpv/net/service/yuemiao_service.dart';

import 'base/base_list_model.dart';

class YMViewModel extends BaseListModel<YMHospitalInfo> {
  UserInfo? _userInfo;
  Map<int, Timer> appointmentTaskMap = {};

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

  /// 添加预约任务
  void addAppointmentTask(YMHospitalInfo hospitalInfo) {
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
      (timer) {

      },
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
