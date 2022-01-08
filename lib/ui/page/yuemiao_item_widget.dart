import 'package:flutter/material.dart';
import 'package:hpv/model/entity/yuemiao_hospital_info.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';
import 'package:hpv/ui/widgets/decorations.dart';
import 'package:hpv/ui/widgets/timer_text.dart';
import 'package:hpv/utils/text_util.dart';

class YMItemWidget extends StatefulWidget {
  final YMHospitalInfo hospitalInfo;

  // 预约
  final ValueChanged<YMHospitalInfo> onReservationCallback;

  const YMItemWidget({
    Key? key,
    required this.hospitalInfo,
    required this.onReservationCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YMItemWidgetState();
}

class _YMItemWidgetState extends State<YMItemWidget> {
  @override
  Widget build(BuildContext context) {
    var hospitalInfo = widget.hospitalInfo;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: getCardBoxDecoration(color: Colours.main_bg_color),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(hospitalInfo.name),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    _buildTextItem("地址", hospitalInfo.address),
                    const SizedBox(height: 2),
                    _buildTextItem("疫苗名称", hospitalInfo.vaccineName),
                    const SizedBox(height: 2),
                    _buildTextItem("预约时间", hospitalInfo.startTime),
                  ],
                ),
              ),
              _buildPanicBuyingWidget(hospitalInfo.startDateTime),
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
  Widget _buildPanicBuyingWidget(DateTime? startDateTime) {
    if (startDateTime == null) {
      return const SizedBox();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 2),
        GestureDetector(
          onTap: () {
            widget.onReservationCallback.call(widget.hospitalInfo);
          },
          child: _buildStatusWidget(content: '预约秒杀'),
        ),
        const SizedBox(height: 4),
        TimerText(title: '倒计时：', endDateTime: startDateTime),
      ],
    );
  }
}
