import 'dart:convert' as convert;

class JsonTransformUtil {
  /// 用于分页的JSON  data -> content
  static List<dynamic> transformListFromContent(dynamic json) {
    if (json == null) {
      return [];
    }
    var content = json['content'];
    return (content is List<dynamic>) ? content : [];
  }

  static dynamic jsonDecode(dynamic json) {
    if (json is String) {
      return convert.jsonDecode(json);
    }
    return json;
  }

  static List<dynamic> transformList(dynamic json) =>
      (json is List<dynamic>) ? json : [];

  static Map<String, dynamic> transformMap(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    } else if (json is String) {
      return convert.jsonDecode(json);
    } else {
      return {};
    }
  }

  static double parseDouble(dynamic value) {
    return parseDoubleOrNull(value) ?? 0;
  }

  static double? parseDoubleOrNull(dynamic value) {
    if (value is String) {
      return double.tryParse(value);
    } else if (value is num) {
      return value.toDouble();
    } else {
      return null;
    }
  }

  static int parseInt(dynamic value) {
    if (value == null) {
      return 0;
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is double) {
      return value.toInt();
    } else {
      return value;
    }
  }

  static int? parseIntOrNull(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is num) {
      return value.toInt();
    } else {
      return null;
    }
  }
}
