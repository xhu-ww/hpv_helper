import 'package:flutter/material.dart';
import 'package:hpv/res/styles.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// 加载失败
class ViewStateErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const ViewStateErrorWidget({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage ?? '加载出错', style: Styles.text2));
  }
}

/// 暂无数据
class ViewStateEmptyWidget extends StatelessWidget {
  const ViewStateEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('暂无数据', style: Styles.text2));
  }
}
