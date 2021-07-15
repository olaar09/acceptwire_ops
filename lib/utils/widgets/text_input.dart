import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hintText;
  final Function? validator;
  final Function? onChanged;
  final bool isPassword;
  final TextEditingController? controller;
  final bool autoFocus;
  final Widget? titleWidget;
  final double letterSpacing;
  final TextInputType keyboardType;
  final Color? bgColor;
  final double textBoxPadding;
  final double fontSize;

  TextInput(
      {required this.hintText,
      this.validator,
      required this.onChanged,
      this.isPassword = false,
      this.controller,
      this.autoFocus = false,
      this.letterSpacing = 0,
      this.titleWidget,
      this.textBoxPadding = 16,
      this.fontSize = 16,
      this.bgColor,
      this.keyboardType = TextInputType.text});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  FocusNode focusNode = FocusNode();
  Color borderColor = Vl.color(color: MColor.K_SECONDARY_BG);

  onFocusChanges() {
    setState(() {
      if (borderColor == Vl.color(color: MColor.K_SECONDARY_BG)) {
        borderColor = Vl.color(color: MColor.K_PRIMARY_BG);
      } else {
        borderColor = Vl.color(color: MColor.K_SECONDARY_BG);
      }
    });
  }

  @override
  void initState() {
    focusNode.addListener(() => this.onFocusChanges());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.titleWidget ?? Container(),
          // Container(
          //   child: Text(
          //     hintText,
          //     style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          //   ),
          // ),
          CupertinoTextField(
            controller: widget.controller,
            placeholder: widget.hintText,
            autofocus: widget.autoFocus,
            focusNode: focusNode,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
                color: GetUtils.isNullOrBlank(this.widget.bgColor)!
                    ? Colors.transparent
                    : this.widget.bgColor,
                border: Border.all(
                    color: GetUtils.isNullOrBlank(this.borderColor)!
                        ? Colors.grey[500]!
                        : this.borderColor)),
            padding: EdgeInsets.all(this.widget.textBoxPadding),
            style: TextStyle(
                fontSize: widget.fontSize,
                color: Vl.color(color: MColor.K_DARK_PLAIN),
                fontWeight: FontWeight.normal,
                letterSpacing: widget.letterSpacing),
            placeholderStyle: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.blue),
            obscureText: widget.isPassword ? true : false,
            onChanged: (String text) => widget.onChanged!(text),
            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
