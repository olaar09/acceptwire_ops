import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mTextField(String label,
    {Function? onChanged,
    isPassword: false,
    double fontSize = 16,
    double textBoxPadding = 16,
    hintText = '',
    TextEditingController? controller,
    String? error,
    keyboardType: TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.length > 0 ? regularText('$label') : SizedBox(),
        TextInput(
            onChanged: onChanged,
            keyboardType: keyboardType,
            fontSize: fontSize,
            controller: controller,
            hintText: hintText,
            textBoxPadding: textBoxPadding,
            isPassword: isPassword),
        GetUtils.isNullOrBlank(error)! ? SizedBox() : regularErrorText('$error')
      ],
    ),
  );
}
