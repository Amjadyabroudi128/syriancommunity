import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController? myController;
  final int? maxLines;
  final TextDirection? textDirection;
  final Widget? suffixIcon;
  final bool? obscureText;
  CustomTextForm
  ({super.key,   required this.hinttext,
   this.myController, this.maxLines, this.textDirection, this.suffixIcon, this.obscureText,

});
@override
Widget build(BuildContext context) {
  return TextField(
    textDirection: textDirection,
    maxLines: maxLines,
    controller: myController,
    decoration: InputDecoration(
        hintText: hinttext,
        suffixIcon: suffixIcon
     ),
    obscureText: obscureText ?? false,
  );
  // custom text field
}
}