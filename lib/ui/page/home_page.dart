import 'package:flutter/material.dart';
import 'package:hpv/model/business_type.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';
import 'package:hpv/ui/page/zhimiao_page.dart';
import 'package:hpv/ui/widgets/decorations.dart';
import 'package:hpv/ui/widgets/dialog_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedBusinessType = BusinessTypeEnum.yuemiao;

  /// 选择地区
  void _selectAddress() {
    DialogHelper.showRightWindow(
        context: context, child: Container(), title: '选择地区');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.main_bg_color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [_buildTopMenuAction()],
        title: const Text('消息', style: Styles.headline1),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTopMenuAction() {
    var key = GlobalKey();
    return GestureDetector(
      onTap: _selectAddress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        key: key,
        decoration: getOutLineDecoration(radius: 16),
        child: Row(
          children: const [
            SizedBox(width: 8),
            Text('成都市', style: Styles.headline2),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colours.color_title,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: double.infinity,
      child: Row(
        children: [
          Container(
            width: 220,
            decoration: getCardBoxDecoration(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: BusinessTypeEnum.values.map((type) {
                bool selected = type == _selectedBusinessType;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() => _selectedBusinessType = type);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colours.main_bg_color,
                      gradient: selected
                          ? LinearGradient(colors: [
                              Colours.theme_color,
                              Colours.theme_color.withOpacity(0.5)
                            ])
                          : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      getBusinessTypeDesc(type),
                      style: selected
                          ? Styles.headline2.copyWith(color: Colors.white)
                          : Styles.headline2,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              decoration: getCardBoxDecoration(),
              padding: const EdgeInsets.all(16),
              height: double.infinity,
              child: const ZMPage(),
            ),
          ),
        ],
      ),
    );
  }
}
