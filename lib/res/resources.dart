import 'package:flutter/widgets.dart';

// import 'package:app/ui.widgets/load_image.dart';

export 'colors.dart';

// export '1dimens.dart';
// export '1gaps.dart';
// export '1styles.dart';

class Images {
  static asset(String s) {}
// static const Widget arrowRight = LoadAssetImage('ic_arrow_right', height: 16.0, width: 16.0);

}

class Drawables {
  static const String head_address = 'assets/images/';
  static const String bg_splash = '${head_address}bg_splash.png';
  static const String image_network_error =
      "${head_address}image_network_error.png";
  static const String logo = head_address + 'logo.png';
  static const String loginLogo = head_address + 'login_logo.png';
  static const String avatarDef = head_address + 'icon_avatar_def.png';

  static const String miniWeixin = head_address + 'img_miniweixin.jpg';

  static const String default_image = head_address + "default_image.png";
}

class IconFonts {
  IconFonts._();

  /// iconfont:flutter base
  static const String fontFamily = 'iconfont';
  static const IconData pageEmpty = IconData(0xe63c, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe600, fontFamily: fontFamily);
  static const IconData pageNetworkError =
      IconData(0xe678, fontFamily: fontFamily);
  static const IconData pageUnAuth = IconData(0xe65f, fontFamily: fontFamily);
}
