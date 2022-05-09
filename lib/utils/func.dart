import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'package:uuid/uuid.dart';
//import 'validators.dart';

class Func {
  static bool isEmpty(Object o) => isNullEmpty(o);

  static String strEmpty2Dot(Object o) =>
      isNullEmpty(o) ? '...' : Func.toStr(o);

  static bool isNotEmpty(Object o) => isNotNullEmpty(o);

  static bool isNullEmpty(Object o) => o == null || "" == o;

  static bool isListNullOrEmpty(List<Object> o) => o == null || o.isEmpty;

  static bool isNotNullEmpty(Object o) => o != null && o != '';

  static bool isNotNullEmptyAndSpace(String str) =>
      str != null && str != '' && str != ' ';

  static bool isNullEmptyOrFalse(Object o) =>
      o == null || false == o || "" == o;

  static bool isNullEmptyFalseOrZero(Object o) =>
      o == null || false == o || 0 == o || "" == o;

  static int toInt2(Object o) {
    if (isNullEmpty(o)) {
      return 0;
    }
    return int.parse(o.toString());
  }

  static int toInt(Object o) => isNullEmpty(o) ? 0 : int.parse(o.toString());

  static bool toBoolFromObj(Object o) =>
      toBool(isNullEmpty(o) ? 0 : int.parse(o.toString()));

  static bool toBool(int i) => i == 1 ? true : false;

  static bool toBoolSafe(bool b) => b == null ? false : b;

  static bool toBoolFromStr(String s) => isNullEmpty(s)
      ? false
      : s.toUpperCase() == "TRUE"
          ? true
          : false;

  static String toStr(Object o) => isNullEmpty(o) ? "" : o.toString();

  static String toUpperCase(String str) {
    return Func.toStr(str).toUpperCase();
  }

  static String toSpacedStr(Object value,
      {required bool secureMode}//Secure mode ашиглах эсэх
    ) {
    /// Format number with "Decimal Point" digit grouping.
    /// 10000000 -> 1 000 000

    String result = "";
    try {
      //value ??= 0.0;
      double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));
      NumberFormat formatter = NumberFormat("### ##0");
      result = formatter.format(tmpDouble);
    } catch (e) {
      result = "0.00";
    }

    return result;
  }

  static String toFormatedStr(Object value) {
    String result = "";
    try {
      //value ??= 0.0;
      double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));
      NumberFormat formatter = NumberFormat("#,##0");
      result = formatter.format(tmpDouble);
    } catch (e) {
      result = "0.00";
    }

    return result;
  }

  static String toMoneyStr(Object value ) {
    /// Format number with "Decimal Point" digit grouping.
    /// 10000 -> 10,000.00 or 10,000
    /// 10000.22 -> 10,000.22

    String result = "";
    try {
      //value ??= 0.0;
      double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));
      NumberFormat formatter =  NumberFormat("#,##0.00");
      result = formatter.format(tmpDouble);
    } catch (e) {
      result = "0.00";
    }

    return result;
  }

  static String trim(String str) {
    // Бүх whitespace-ийг устгана
    if (isNullEmpty(str)) return "";

    return str.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
  }

  static bool checkMobileNumber(String mobile) {
    String pattern = r'(^\d{8}$)';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(mobile);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static String toDateFormat(String str) {
    // Datetime string-ээс date string-ийг буцаана '2019.01.01T15:13:00.000' to '2019.01.01'
    if (isEmpty(str)) return '';
    str = str.split(' ')[0];
    String formattedDate =
        DateFormat("yyyy-MM-dd").format(DateFormat("MM/dd/yyyy").parse(str));

    return formattedDate;
  }

  static DateTime? toDate(String str) {
    if (isEmpty(str)) return null;
    str = str.split(' ')[0];
    DateTime? dt = null;
    if (str.contains("/"))
      dt = DateFormat("MM/dd/yyyy").parse(str);
    else
      dt = DateFormat("yyyy-MM-dd").parse(str);

    return dt;
  }

  static String toDateStr(DateTime dt) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dt);

    return formattedDate;
  }

  ///String format
  static String format(String format, List<dynamic> args) {
    var retValue = format;

    if (args == null || args.length == 0) {
      return retValue;
    }

    for (int i = 0; i < args.length; i++) {
      retValue = retValue.replaceAll('{' '$i' '}', Func.toStr(args[i]));
    }

    return retValue;
  }

  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static double toDouble(Object objDouble,
      {String thousandSeparator = ",",
      String rightSymbol = "",
      String leftSymbol = ""}) {
    double val = 0;
    var strDouble = Func.toStr(objDouble);

    strDouble = (strDouble == null || strDouble.isEmpty) ? '0' : strDouble;

    strDouble = strDouble
        .replaceAll(thousandSeparator, '')
        .replaceAll(rightSymbol, '')
        .replaceAll(leftSymbol, '');

    try {
      val = double.parse(strDouble);
    } catch (_) {
      val = 0;
    }
    return val;
  }
}
