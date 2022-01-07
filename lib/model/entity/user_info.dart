import 'package:hpv/utils/json_transform_util.dart';

class UserInfo {
  int? id;
  int? userId;
  String? idCardNo;
  String? name;
  String? address;

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = JsonTransformUtil.parseInt(json['id']);
    userId = JsonTransformUtil.parseInt(json['userId']);
    idCardNo = json['idCardNo'];
    name = json['name'];
    address = json['address'];
  }
}
