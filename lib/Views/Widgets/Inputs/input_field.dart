import 'package:flutter/material.dart';

import '../../Constants/fonts/fonts.dart';
import '../../Constants/style/style.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  TextEditingController inputController = TextEditingController();
  String? hintText;
  IconData? prefixicon;
  dynamic suffixicon;
  bool? showPassword;
  int maxchar = 20;
  String? defultValue;
  int maxLines;
  TextDirection textDirection = TextDirection.rtl;
  TextAlign textAlign = TextAlign.right;
  TextInputType? keyboardType;
  InputField({
    Key? key,
    this.hintText,
    this.prefixicon,
    this.suffixicon,
    required this.inputController,
    this.showPassword,
    required this.maxchar,
    this.defultValue,
    this.maxLines = 1,
    this.textDirection = TextDirection.rtl,
    this.textAlign = TextAlign.right,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = InputDecoration(
      prefixIcon: Icon(
        prefixicon,
        color: Colors.grey,
        size: 25,
      ),
      suffixIcon: suffixicon,
      hintText: hintText,
      hintTextDirection: textDirection,
      border: border,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: keyboardType,
        textAlign: textAlign,
        obscureText: showPassword ?? false,
        decoration: inputDecoration,
        cursorHeight: 25,
        style: inputStyle,
        controller: inputController,
        maxLength: maxchar,
        maxLines: maxLines,
      ),
    );
  }
}
