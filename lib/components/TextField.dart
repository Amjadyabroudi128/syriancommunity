import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? hinttext;
  final TextEditingController? myController;
  final int? maxLines;
  final TextDirection? textDirection;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? label;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Color? prefixIconColor;
  const CustomTextForm({super.key,  this.hinttext,
   this.myController, this.maxLines, this.textDirection,
    this.suffixIcon, this.obscureText = false, this.minLines,
    this.keyboardType, this.prefixIcon, this.label, this.labelText, this.validator, this.prefixIconColor, });
@override
Widget build(BuildContext context) {
  return TextFormField(
    validator: validator,
    keyboardType: keyboardType,
    minLines: minLines,
    textDirection: textDirection,
    maxLines: maxLines,
    controller: myController,
    decoration: InputDecoration(
        hintText: hinttext,
        suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      prefixIconColor: prefixIconColor ,
      label: label,
     ),

    obscureText: obscureText,
  );
  // custom text field
}
}