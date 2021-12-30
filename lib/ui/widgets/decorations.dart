import 'package:flutter/material.dart';
import 'package:hpv/res/colors.dart';

/// 卡片装饰
BoxDecoration getCardBoxDecoration(
    {Color color = Colors.white, double radius = 5}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}

/// 圆角装饰
BoxDecoration getOutLineDecoration(
    {Color borderColor = Colours.theme_color, double radius = 8}) {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderColor, width: 0.5),
    borderRadius: BorderRadius.circular(radius),
  );
}