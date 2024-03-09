import 'package:flutter/material.dart';
import '../themes/fontSize.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController? myController;
  final int? maxLines;
  final TextDirection? textDirection;
  const CustomTextForm
  ({  required this.hinttext,
   this.myController, this.maxLines, this.textDirection,

});
@override
Widget build(BuildContext context) {
  return TextField(
    textDirection: textDirection,
    maxLines: maxLines,
    controller: myController,
    decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyles.hintText
     ),
  );
  // custom text field
}
}