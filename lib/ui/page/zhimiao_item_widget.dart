import 'package:flutter/material.dart';
import 'package:hpv/model/entity/zhimiao_hospital_info.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';
import 'package:hpv/ui/widgets/decorations.dart';
import 'package:hpv/ui/widgets/timer_text.dart';
import 'package:hpv/utils/text_util.dart';

class ZMItemWidget extends StatefulWidget {
  final ZMHospitalInfo hospitalInfo;

  const ZMItemWidget({
    Key? key,
    required this.hospitalInfo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZMItemWidgetState();
}

class _ZMItemWidgetState extends State<ZMItemWidget> {
  @override
  Widget build(BuildContext context) {
    var hospitalInfo = widget.hospitalInfo;
    var jiujiaDate = hospitalInfo.jiuJiaProduct?.startDate;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: getCardBoxDecoration(color: Colours.main_bg_color),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(hospitalInfo.cname),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    _buildTextItem("电话号码", hospitalInfo.tel),
                    const SizedBox(height: 2),
                    _buildTextItem(
                      "四价预约时间",
                      hospitalInfo.siJiaProduct?.date,
                      showWaring: true,
                    ),
                    const SizedBox(height: 2),
                    _buildTextItem(
                      "九价预约时间",
                      hospitalInfo.jiuJiaProduct?.date,
                      showWaring: true,
                    ),
                  ],
                ),
              ),
              jiujiaDate == null
                  ? const SizedBox()
                  : _buildPanicBuyingWidget(jiujiaDate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String? title) {
    return Text(
      StringUtils.getNoNull(title),
      style: Styles.headline2,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTextItem(
    String title,
    dynamic value, {
    bool showWaring = false,
  }) {
    if (showWaring) {
      return RichText(
        text: TextSpan(
          style: Styles.text3,
          children: [
            TextSpan(text: '$title：'),
            TextSpan(
              text: '${value ?? ''}',
              style: Styles.text3.copyWith(color: Colors.red),
            ),
          ],
        ),
      );
    }
    return Text(
      '$title：${value ?? ''}',
      style: Styles.text3,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatusWidget({required String content}) {
    Color textColor = Colours.deep_theme_color;
    return Container(
      width: 66,
      height: 20,
      alignment: Alignment.center,
      decoration:
          getCardBoxDecoration(radius: 9, color: textColor.withAlpha(31)),
      child: Text(
        content,
        style: TextStyle(color: textColor, fontSize: 11),
      ),
    );
  }

  // 秒杀 抢购
  Widget _buildPanicBuyingWidget(DateTime startDateTime) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 2),
        _buildStatusWidget(content: '预约秒杀'),
        const SizedBox(height: 4),
        TimerText(title: '倒计时：', endDateTime: startDateTime),
      ],
    );
  }
}
