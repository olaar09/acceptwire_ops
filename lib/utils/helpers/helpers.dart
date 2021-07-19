import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

bool blankOrNull(dynamic obj) {
  var checkBlank = GetUtils.isNullOrBlank(obj);
  if (checkBlank != null) return checkBlank;
  return true;
}

String removeTrailingZeros(double num) {
  return num.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
}

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

void looseFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

getPlatform() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  }

  return 'others';
}

Future<bool> isFileExists(String path) async {
  String fullPath = await getFilePath(path);
  return checkFileExists(fullPath);
}

Future<String> getFilePath(uniqueFileName) async {
  String path = '';
  // print('downloading.. ${dir.path}/$uniqueFileName');

  return path;
}

bool checkFileExists(String path) {
  return FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;
}

DateTime getTimeObj(String dateTimeString) {
  return DateTime.parse(dateTimeString);
}

DateTime getDateObj(String dateTimeString) {
  return DateTime.parse(dateTimeString);
}

getTimeOnly(DateTime dateTime) {
  return DateFormat.Hms().format(dateTime);
}

formatTimeDate(DateTime dateTime) {
  return DateFormat('yy.MM.dd').format(dateTime); //kk:mm
}

bool hasTimeExpired(time) {
  var now = new DateTime.now();
  return getTimeObj(time).isBefore(now);
}

formatMoney(number) {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  return '₦${oCcy.format(number)}';
}
