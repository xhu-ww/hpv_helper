import 'package:hpv/utils/json_transform_util.dart';

class ProductInfo {
  int? id;
  String? text;
  String? price;
  String? date;
  bool enable = false;

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = JsonTransformUtil.parseInt(json['id']);
    text = json['text'];
    price = json['price'];
    date = json['date'];
    enable = json['enable'] ?? false;
  }

  //  "12-20 00:00 至 02-28 00:00"
  DateTime? get startDate {
    var dateStr = date;
    try {
      if (dateStr == null) {
        return null;
      }
      var startDateStr = dateStr.split('至').first.trim();
      var currentYear = DateTime.now().year;
      dateStr = '$currentYear-$startDateStr';
      return DateTime.tryParse(dateStr);
    } catch (e) {
      return null;
    }
  }
}
