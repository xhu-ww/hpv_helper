import 'package:hpv/utils/json_transform_util.dart';

class YMHospitalInfo {
  int? id;
  String? name;
  String? vaccineCode;
  String? vaccineName;
  String? address;
  String? startTime;
  int? stock;

  DateTime? get startDateTime {
    if (startTime == null) {
      return null;
    }
    return DateTime.tryParse(startTime!);
  }

  YMHospitalInfo.fromJson(Map<String, dynamic> json) {
    id = JsonTransformUtil.parseInt(json['id']);
    name = json['name'];
    vaccineCode = json['vaccineCode'];
    vaccineName = json['vaccineName'];
    address = json['address'];
    startTime = json['startTime'];
    stock = JsonTransformUtil.parseInt(json['stock']);
  }
}
