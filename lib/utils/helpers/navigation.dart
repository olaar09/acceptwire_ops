import 'package:flutter/material.dart';
import 'package:get/get.dart';

void navOfAllPage({required context, required route}) {
  Navigator.pushNamedAndRemoveUntil(
      context, route, (Route<dynamic> route) => false);
}

void navToPage({required context, required route, required data}) {
  Navigator.pushNamed(context, route, arguments: data);
}

void navToBack({required context, required data}) {
  Navigator.pop(context, data);
}

bool hasBack({required context}) {
  return Navigator.canPop(context);
}

void navOfPage({required context, required route, required data}) {
  Navigator.pushReplacementNamed(context, route, arguments: data);
}
