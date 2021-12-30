import 'package:flutter/material.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info_entity.dart';
import 'package:hpv/res/styles.dart';
import 'package:hpv/ui/view_model/base/provider_widget.dart';
import 'package:hpv/ui/view_model/view_state/view_state.dart';
import 'package:hpv/ui/view_model/view_state/view_state_widget.dart';
import 'package:hpv/ui/view_model/zhimiao_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZMPage extends StatefulWidget {
  const ZMPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZMPageState();
}

class _ZMPageState extends State<ZMPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ZMViewModel>(
      model: ZMViewModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        Widget child;
        switch (model.viewState) {
          case ViewState.busy:
            child = const ViewStateBusyWidget();
            break;
          case ViewState.empty:
            child = const ViewStateEmptyWidget();
            break;
          case ViewState.error:
            child = const ViewStateErrorWidget();
            break;
          case ViewState.idle:
            child = ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                return _buildItem(model.list[index]);
              },
            );
            break;
        }

        return SmartRefresher(
          controller: model.refreshController,
          header: const ClassicHeader(),
          onRefresh: () => model.refresh(),
          child: child,
        );
      },
    );
  }

  Widget _buildItem(ZMHospitalInfo hospitalInfo) {
    return Text(
      hospitalInfo.cname ?? "",
      style: Styles.headline1,
    );
  }
}
