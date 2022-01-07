import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hpv/res/styles.dart';

/// 从现在开始到结束时间的倒计时， 分，时，天
class TimerText extends StatefulWidget {
  final String? title;
  final DateTime endDateTime;

  /// [endTimeString]为空则按当前时间计算 并定时更新
  const TimerText({Key? key, this.title, required this.endDateTime})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  Timer? timer;
  late DateTime endDateTime;
  String timeDescription = '';

  @override
  void initState() {
    super.initState();
    endDateTime = widget.endDateTime;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        var startTime = DateTime.now();
        setState(() {
          timeDescription = calculateTime(
            startTime: startTime,
            endDateTime: endDateTime,
          );
        });
        if (startTime.isAfter(endDateTime)) {
          timer.cancel();
        }
      }
    });
  }

  String calculateTime({
    required DateTime startTime,
    required DateTime endDateTime,
  }) {
    if (startTime.isAfter(endDateTime)) {
      return '已过秒杀开始日期';
    }
    var duration = endDateTime.difference(startTime);
    var totalSeconds = duration.inSeconds;
    int hour = totalSeconds / 60 ~/ 60;
    int min = ((totalSeconds / 60) % 60).toInt();
    int seconds = totalSeconds % 60;
    return '$hour小时$min分钟$seconds秒';
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Styles.text4,
        children: [
          TextSpan(text: widget.title ?? ""),
          TextSpan(
            text: timeDescription,
            style: const TextStyle(fontSize: 10, color: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
