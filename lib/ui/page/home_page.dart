import 'package:flutter/material.dart';
import 'package:hpv/model/business_type.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';
import 'package:hpv/ui/page/yuemiao_page.dart';
import 'package:hpv/ui/page/zhimiao_page.dart';
import 'package:hpv/ui/widgets/decorations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedBusinessType = BusinessTypeEnum.yuemiao;

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
        title: const Text('约苗 & 知苗易约', style: Styles.headline1),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTopMenuAction() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: getOutLineDecoration(radius: 16),
      child: Row(
        children: const [
          SizedBox(width: 16),
          Text('仅限成都市', style: Styles.headline2),
          SizedBox(width: 16),
        ],
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
              height: double.infinity,
              child: IndexedStack(
                index: _selectedBusinessType.index,
                children: const [YMPage(), ZMPage()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
