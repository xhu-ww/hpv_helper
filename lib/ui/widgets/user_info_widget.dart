import 'package:flutter/material.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';

import 'decorations.dart';

typedef RequestUserInfoCallback = Function(String tk, String cookie);

class UserInfoWidget extends StatefulWidget {
  final UserInfo? userInfo;
  final RequestUserInfoCallback onRequestUserInfoCallback;

  const UserInfoWidget({
    Key? key,
    required this.userInfo,
    required this.onRequestUserInfoCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool _showUserInfo = false;
  final _tkTextController = TextEditingController();
  final _cookieTextController = TextEditingController();

  void _onSubmit() {
    var tk = _tkTextController.text;
    var cookie = _cookieTextController.text;
    if (tk.isNotEmpty && cookie.isNotEmpty) {
      widget.onRequestUserInfoCallback.call(tk, cookie);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userInfo = widget.userInfo;
    return Container(
      decoration: getCardBoxDecoration(color: Colours.main_bg_color),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildTextField(
            title: 'TK',
            controller: _tkTextController,
            onSubmitted: _onSubmit,
          ),
          const SizedBox(height: 4),
          _buildTextField(
            title: 'Cookie',
            controller: _cookieTextController,
            onSubmitted: _onSubmit,
          ),
          const SizedBox(height: 12),
          const Text('个人预约信息', style: Styles.headline2),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  children: [
                    _buildTextItem('姓名', content: userInfo?.name),
                    _buildTextItem('身份证号',
                        content: userInfo?.idCardNo, showInfo: _showUserInfo),
                    _buildTextItem('联系方式',
                        content: userInfo?.address, showInfo: _showUserInfo),
                  ],
                ),
              ),
              IconButton(
                tooltip: '隐藏或显示用户信息',
                onPressed: () {
                  setState(() {
                    _showUserInfo = !_showUserInfo;
                  });
                },
                icon: Icon(
                  _showUserInfo ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                ),
              ),
              IconButton(
                tooltip: '刷新用户信息',
                onPressed: _onSubmit,
                icon: const Icon(Icons.refresh, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    TextEditingController? controller,
    Function? onSubmitted,
  }) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        style: Styles.text3,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          onSubmitted?.call();
        },
        decoration: InputDecoration(
          labelText: title,
          contentPadding: EdgeInsets.zero,
          hintText: '请输入$title,可抓包微信小程序获得',
          labelStyle: Styles.themeText3,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colours.color_ann),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colours.color_ann),
          ),
          hintStyle: Styles.hintText3,
        ),
      ),
    );
  }

  Widget _buildTextItem(String title, {String? content, bool showInfo = true}) {
    var value = showInfo ? content : content?.replaceAll(RegExp(r'.'), "*");
    return Text(
      '$title：${value ?? ''}',
      style: Styles.text3,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
