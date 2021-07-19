import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget boldText(String text,
    {double size: 18,
    color,
    textAlign: TextAlign.start,
    fontWeight: FontWeight.bold}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: size,
      color:
          !blankOrNull(color) ? color : Vl.color(color: MColor.K_PRIMARY_TEXT),
    ),
  );
}

Widget regularText(String text,
    {double size: 18,
    Color? color,
    double lineHeight: 2,
    int maxLines = 5,
    textAlign: TextAlign.left}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: size,
        letterSpacing: .1,
        height: lineHeight,
        color: GetUtils.isNullOrBlank(color)!
            ? Vl.color(color: MColor.K_SECONDARY_TEXT)
            : color),
  );
}

Widget regularErrorText(String text, {double size: 18}) {
  return regularText(text, size: 16, color: Colors.deepOrange[700]!);
}
