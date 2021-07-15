import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

abstract class ColorHex {
  static final String blueHex = '#0072E3';
  static final String darkHex = '#011A32';
  static final String greyHex = '#76787A';
  static final String darkGreyHex = '#E5E5E5';
  static final String grey2Hex = '#c6c6c6';
  static final String blackHex = '#000000';
  static final String whiteHex = '#ffffff';
}

enum MColor {
  K_PRIMARY_MAIN,
  K_SECONDARY_MAIN,
  K_LIGHT_PLAIN,
  K_DARK_PLAIN,
  K_PRIMARY_TEXT,
  K_SECONDARY_TEXT,
  K_PRIMARY_BG,
  K_SECONDARY_BG
}

class Vl {
  static Color color({required color}) {
    switch (color) {
      case MColor.K_DARK_PLAIN:
        return colorFromHex(ColorHex.blackHex);
      case MColor.K_LIGHT_PLAIN:
        return colorFromHex(ColorHex.whiteHex);
      case MColor.K_PRIMARY_MAIN:
        return colorFromHex(ColorHex.blueHex);
      case MColor.K_SECONDARY_MAIN:
        return colorFromHex(ColorHex.whiteHex);
      case MColor.K_PRIMARY_TEXT:
        return colorFromHex(ColorHex.darkHex);
      case MColor.K_SECONDARY_TEXT:
        return colorFromHex(ColorHex.greyHex);
      case MColor.K_PRIMARY_BG:
        return colorFromHex(ColorHex.blueHex);
      case MColor.K_SECONDARY_BG:
        return colorFromHex(ColorHex.greyHex);
      default:
        return colorFromHex(ColorHex.whiteHex);
    }
  }
}
