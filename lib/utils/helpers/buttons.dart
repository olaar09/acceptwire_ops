import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:get/get.dart';

Function onPress = () => {};

button(String text,
    {Color color = Colors.white,
    borderColor: Colors.white,
    textColor: Colors.black,
    double horizontal: 12.0,
    double vertical: 20,
    bool loading = false,
    double? fontSize: 18.0,
    Function? onPressed}) {
  return Container(
    decoration: BoxDecoration(),
    child: ElevatedButton(
      onPressed: () => onPressed!(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Text(
          '$text',
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: loading
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(
          width: 1,
          color: loading ? Colors.grey : borderColor,
        )),
      ),
    ),
  );
}

primaryButton(
  String text, {
  Function? onPressed,
  bool loading = false,
  double vertical: 20,
  fontSize: 18.0,
  double horizontal: 12.0,
}) {
  var cl = Vl.color(color: MColor.K_PRIMARY_MAIN);
  return button(text,
      textColor: Colors.white,
      color: cl,
      loading: loading,
      borderColor: cl,
      fontSize: fontSize,
      vertical: vertical,
      horizontal: horizontal,
      onPressed: onPressed);
}

Widget leadingBtn(BuildContext context) {
  return hasBack(context: context)
      ? IconButton(
          onPressed: () {
            navToBack(context: context, data: null);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Vl.color(color: MColor.K_DARK_PLAIN),
          ),
        )
      : Container();
}
