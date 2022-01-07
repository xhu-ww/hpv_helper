import 'package:flutter/material.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/ui/view_model/base/provider_widget.dart';
import 'package:hpv/ui/view_model/view_state/view_state.dart';
import 'package:hpv/ui/view_model/view_state/view_state_widget.dart';
import 'package:hpv/ui/view_model/zhimiao_view_model.dart';
import 'package:hpv/ui/widgets/user_info_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'zhimiao_item_widget.dart';

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

  Widget _buildMainWidget(ZMViewModel model, {required double maxWidth}) {
    switch (model.viewState) {
      case ViewState.busy:
        return const ViewStateBusyWidget();
      case ViewState.empty:
        return const ViewStateEmptyWidget();
      case ViewState.error:
        return const ViewStateErrorWidget();
      case ViewState.idle:
        var crossAxisCount = maxWidth ~/ 360;
        if (crossAxisCount == 0) crossAxisCount = 1;
        var cellWidth = (maxWidth - 16 * crossAxisCount - 16) / crossAxisCount;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UserInfoWidget(
            //   userInfo: UserInfo(
            //     name: '王文',
            //     phone: '18380426764',
            //     idCard: '51112310029329485',
            //   ),
            //   onRequestUserInfoCallback: (tk, cookie) {},
            // ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16,
                  childAspectRatio: cellWidth / 100,
                  mainAxisSpacing: 16,
                  crossAxisCount: crossAxisCount,
                ),
                itemCount: model.list.length,
                itemBuilder: (context, index) => ZMItemWidget(
                  hospitalInfo: model.list[index],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
    }
  }
}
