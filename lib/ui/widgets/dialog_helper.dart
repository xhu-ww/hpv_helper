import 'package:flutter/material.dart';
import 'package:hpv/res/styles.dart';

import 'divider.dart';

class DialogHelper {
  ///弹出右侧窗口
  static Future<T?> showRightWindow<T>({
    required BuildContext context,
    required child,
    bool barrierDismissible = true,
    double widthFlex = 2.6,
    Color bgColor = Colors.white,
    bool useRootNavigator = false,
    String? title,
  }) async {
    return showGeneralDialog<T>(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return LayoutBuilder(
              builder: (ctx, constraints) {
                return Container(
                  color: bgColor,
                  height: double.infinity,
                  width: constraints.maxWidth / widthFlex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 8, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title, style: Styles.headline1),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.cancel),
                              )
                            ],
                          ),
                        ),
                      if (title != null) const HDivider(),
                      Expanded(child: child),
                    ],
                  ),
                );
              },
            );
          }),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}
