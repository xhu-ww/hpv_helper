import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_model.dart';

///只有刷新的列表数据页面
abstract class BaseListModel<T> extends BaseModel {
  /// 页面数据
  List<T> list = [];
  final refreshController = RefreshController(initialRefresh: false);

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      refreshController.refreshCompleted();
      if (data.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
      }
    } catch (e) {
      if (init) {
        list.clear();
      }
      refreshController.refreshFailed();
      setError(error: e);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
