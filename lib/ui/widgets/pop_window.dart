import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';

class PopWindow {
  final Color _backgroundColor = Colors.white;
  final double _arrowHeight = 12.0;
  final double _menuWidth = 180.0;
  final double _itemHeight = 44.0;

  late BuildContext context;
  VoidCallback? dismissCallback;
  ValueChanged<int>? onItemClick;
  Color? labelColor;
  OverlayEntry? _entry;

  bool _isShow = false;
  late Size _screenSize;
  late Rect _showRect;
  late int _itemCount;

  PopWindow({
    required this.context,
    this.dismissCallback,
    this.onItemClick,
    this.labelColor,
  });

  double get _menuHeight => _itemHeight * _itemCount;

  void show({required GlobalKey widgetKey, required List<String> items}) {
    _itemCount = items.length;
    _showRect = _getWidgetGlobalRect(widgetKey);
    _screenSize = window.physicalSize / window.devicePixelRatio;

    var leftTopOffset = _calculateOffset(context);
    _entry = OverlayEntry(
      builder: (context) => _buildPopupMenuLayout(leftTopOffset, items),
    );

    Overlay.of(context)?.insert(_entry!);
    _isShow = true;
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  // 左上角
  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect.left + _showRect.width / 2.0 - _menuWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + _menuWidth > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - _menuWidth - 10;
      if (tempDx > 10) dx = tempDx;
    }
    var dy = _showRect.bottom + _arrowHeight;
    return Offset(dx, dy);
  }

  LayoutBuilder _buildPopupMenuLayout(Offset offset, List<String> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dismiss();
          },
          onVerticalDragStart: (DragStartDetails details) {
            dismiss();
          },
          onHorizontalDragStart: (DragStartDetails details) {
            dismiss();
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: _menuWidth,
                  height: _menuHeight,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5, //阴影范围
                        spreadRadius: 0.5, //阴影浓度
                        color: Colours.main_bg_color, //阴影颜色
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      items.length,
                      (index) {
                        String item = items[index];
                        return _buildItem(item, onTap: () {
                          dismiss();
                          onItemClick?.call(index);
                        });
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _showRect.left + _showRect.width / 2.0 - 12,
                top: offset.dy - _arrowHeight,
                child: CustomPaint(
                  size: Size(24.0, _arrowHeight),
                  painter: _TrianglePainter(
                    isDown: false,
                    color: _backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double get screenWidth {
    double width = window.physicalSize.width;
    double ratio = window.devicePixelRatio;
    return width / ratio;
  }

  void itemClicked() {
    dismiss();
  }

  void dismiss() {
    if (!_isShow) {
      return;
    }

    _entry?.remove();
    _isShow = false;
    if (dismissCallback != null) {
      dismissCallback!();
    }
  }

  Widget _buildItem(String item, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: _itemHeight,
        width: _menuWidth,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colours.main_bg_color),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          item,
          style: Styles.headline2.copyWith(decoration: TextDecoration.none),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

// 画弹出菜单下面的三角形
class _TrianglePainter extends CustomPainter {
  bool isDown;
  Color color;

  _TrianglePainter(
      {this.isDown = true, this.color = const Color.fromARGB(0, 0, 0, 0)});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.strokeWidth = 2.0;
    _paint.color = color;
    _paint.style = PaintingStyle.fill;

    Path path = Path();
    if (isDown) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1);
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
