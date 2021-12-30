import 'package:flutter/material.dart';
import 'package:hpv/res/colors.dart';

class HDivider extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsetsGeometry? margin;

  const HDivider({
    Key? key,
    this.color = Colours.main_bg_color,
    this.height = 0.8,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color,
      height: height,
    );
  }
}

class VDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  final EdgeInsetsGeometry? margin;

  const VDivider({
    Key? key,
    this.color = Colours.main_bg_color,
    this.height = 8,
    this.width = 1,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color,
      width: width,
      height: height,
    );
  }
}
