import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:flutter/material.dart';

enum ThemeChoice { Light, Dark, Colourful }

Map<ThemeChoice, ThemeData> appThemes = {
  ThemeChoice.Light: ThemeData(
    fontFamily: 'SamoSans',
    primarySwatch: Colors.blue,
    primaryColor: Vl.color(color: MColor.K_PRIMARY_MAIN),
    hintColor: Vl.color(color: MColor.K_PRIMARY_MAIN),
    brightness: Brightness.light,
  ),
  ThemeChoice.Dark: ThemeData(
    fontFamily: 'SamoSans',
    primarySwatch: Colors.blue,
    primaryColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
    hintColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
    brightness: Brightness.dark,
  ),
};
