import 'package:flutter/material.dart';
import 'package:hpv/model/entity/user_info.dart';
import 'package:hpv/res/colors.dart';
import 'package:hpv/res/styles.dart';

import 'decorations.dart';

class UserInfoWidget extends StatefulWidget {
  final UserInfo userInfo;

  const UserInfoWidget({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool _showUserInfo = false;

  @override
  Widget build(BuildContext context) {
    var userInfo = widget.userInfo;
    return Container(
      decoration: getCardBoxDecoration(color: Colours.main_bg_color),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text('个人预约信息', style: Styles.headline2),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  children: [
                    _buildTextItem('姓名', content: userInfo.name),
                    _buildTextItem('手机号',
                        content: userInfo.phone, showInfo: _showUserInfo),
                    _buildTextItem('身份证号',
                        content: userInfo.idCard, showInfo: _showUserInfo),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showUserInfo = !_showUserInfo;
                  });
                },
                icon: Icon(
                  _showUserInfo ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                ),
              )
            ],
          ),
        ],
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
