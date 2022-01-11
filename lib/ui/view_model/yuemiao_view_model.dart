import 'package:flutter/widgets.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/model/entity/yuemiao_hospital_info.dart';
import 'package:hpv/net/service/yuemiao_service.dart';

import 'base/base_list_model.dart';

class YMViewModel extends BaseListModel<YMHospitalInfo> {
  UserInfo? _userInfo;
  Map<int, Timer> appointmentTaskMap = {};

  String? _tk;
  String? _cookie;

  UserInfo? get userInfo => _userInfo;

  @override
  Future<List<YMHospitalInfo>> loadData() {
    return ymService.getHospitalList();
  }

  void loadUserInfo({required String tk, required String cookie}) async {
    _tk = tk;
    _cookie = cookie;
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

  void reservation({
    required int? seckillId,
    required String? vaccineIndex,
  }) async {
    try {
      if (_tk == null || _cookie == null || userInfo == null) {
        showErrorToast(errorMessage: '需要填写【TK】、【Cookie】后，获取用户信息');
        return;
      }
      await ymService.reservation(
          tk: _tk!,
          cookie: _cookie!,
          seckillId: seckillId,
          idCardNo: userInfo?.idCardNo,
          linkmanId: userInfo?.userId,
          vaccineIndex: vaccineIndex);
    } catch (e) {
      showErrorToast(error: e);
      debugPrint(e.toString());
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
