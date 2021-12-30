import 'package:flutter/cupertino.dart';
import 'package:hpv/utils/toast_utils.dart';

import '../view_state/view_state.dart';

class BaseModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 默认状态
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError({error, String? errorMessage}) {
    viewState = ViewState.error;
    debugPrint(error.toString());
  }

  void showErrorToast({error, String? errorMessage}) {
    MyToast.showErrorToast(error: error, errorMessage: errorMessage);
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
