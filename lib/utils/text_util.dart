import 'dart:convert';

import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import 'date_util.dart';

class StringUtils {
  static String getNoNull(String? value) {
    return value ?? "";
  }

  /// https://github.com/flutter/flutter/issues/18761
  /// 中英文结合时，取消自动换行
  static String getOverflow(dynamic value) {
    return Characters(value?.toString() ?? "")
        .replaceAll(Characters(''), Characters('\u{200B}'))
        .toString();
  }

  static String? getSex(String? sexCode) {
    switch (sexCode) {
      case '1':
        return '男';
      case '2':
        return '女';
      default:
        return sexCode;
    }
  }

  static String getYMDDay(String? dateStr) {
    if (dateStr == null) {
      return "";
    }

    return DateUtil.formatDateStr(dateStr, format: DateFormats.y_mo_d);
  }

  static String getYMDHMDateString(String? dateStr) {
    if (dateStr == null) {
      return "";
    }

    return DateUtil.formatDateStr(dateStr, format: DateFormats.y_mo_d_h_m);
  }

  static String getYMDDayFromDate(DateTime dateTime) {
    return DateUtil.formatDate(dateTime, format: DateFormats.y_mo_d);
  }

  static String getYMFromDate(DateTime dateTime) {
    return DateUtil.formatDate(dateTime, format: DateFormats.y_mo);
  }

  static String getYMDHMFromDate(DateTime dateTime) {
    return DateUtil.formatDate(dateTime, format: DateFormats.y_mo_d_h_m);
  }

  static bool objEquals(dynamic obj1, dynamic obj2) {
    if (obj1 == obj2) return true;
    return jsonEncode(obj1) == jsonEncode(obj2);
  }

  ///金额格式化 #,##0.00 1567,823.88
  static String formatAmount(dynamic amount) {
    return NumberFormat("#,##0.00", "en_US").format(amount);
  }


  static String bankEnd4(String? card) {
    if (card == null) return '';
    if (card.length < 5) return card;
    return card.substring(card.length - 4);
  }
}
