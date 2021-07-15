import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:flutter/material.dart';

Widget iconsSize(String path, {double size: 20}) {
  return CircleAvatar(
    backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
    child: Image.asset(
      path,
      width: size,
      height: size,
    ),
  );
}

Widget normalSize(String path, {double height: 80, double width: 80}) {
  return Image.asset(
    path,
    width: width,
    height: height,
  );
}

Widget normalSizeNetwork(String path, {double height: 80, double width: 80}) {
  return Container(
    width: width,
    height: height,
    child: Image.network(
      path,
      fit: BoxFit.cover,
    ),
  );
}
