import 'package:flutter/material.dart';
import 'package:hpv/ui/view_model/base/provider_widget.dart';
import 'package:hpv/ui/view_model/view_state/view_state.dart';
import 'package:hpv/ui/view_model/view_state/view_state_widget.dart';
import 'package:hpv/ui/view_model/yuemiao_view_model.dart';
import 'package:hpv/ui/widgets/user_info_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'yuemiao_item_widget.dart';

class YMPage extends StatefulWidget {
  const YMPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YMPageState();
}

class _YMPageState extends State<YMPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<YMViewModel>(
      model: YMViewModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        return LayoutBuilder(
          builder: (ctx, constraints) {
            return SmartRefresher(
              controller: model.refreshController,
              header: const ClassicHeader(),
              onRefresh: () => model.refresh(),
              child: _buildMainWidget(model, maxWidth: constraints.maxWidth),
            );
          },
        );
      },
    );
  }

  Widget _buildMainWidget(YMViewModel model, {required double maxWidth}) {
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
        var crossAxisCount = maxWidth ~/ 360;
        if (crossAxisCount == 0) crossAxisCount = 1;
        var cellWidth = (maxWidth - 16 * crossAxisCount - 16) / crossAxisCount;
        child = GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 16,
            childAspectRatio: cellWidth / 100,
            mainAxisSpacing: 16,
            crossAxisCount: crossAxisCount,
          ),
          itemCount: model.list.length,
          itemBuilder: (context, index) => YMItemWidget(
            hospitalInfo: model.list[index],
            onReservationCallback: (hospitalInfo) {
              model.reservation(vaccineIndex: hospitalInfo.vaccineCode,seckillId:hospitalInfo.id);
            },
          ),
        );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfoWidget(
          userInfo: model.userInfo,
          onRequestUserInfoCallback: (tk, cookie) {
            model.loadUserInfo(tk: tk, cookie: cookie);
          },
        ),
        Expanded(child: child),
        const SizedBox(height: 16),
      ],
    );
  }
}
