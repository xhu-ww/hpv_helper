import 'package:hpv/model/entity/product_info.dart';
import 'package:hpv/utils/json_transform_util.dart';

class ZMHospitalInfo {
  int? id;
  String? cname;
  String? tel;
  String? address;
  String? notice;
  int? province;
  int? city;
  int? county;

  ProductInfo? siJiaProduct;
  ProductInfo? jiuJiaProduct;

  ZMHospitalInfo.fromJson(Map<String, dynamic> json) {
    id = JsonTransformUtil.parseInt(json['id']);
    cname = json['cname'];
    address = json['addr'];
    tel = json['tel'];
    notice = json['notice'];
    province = JsonTransformUtil.parseInt(json['province']);
    city = JsonTransformUtil.parseInt(json['city']);
    county = JsonTransformUtil.parseInt(json['county']);
  }
}
