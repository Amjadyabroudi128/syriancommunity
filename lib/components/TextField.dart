import 'package:flutter/material.dart';
import '../themes/fontSize.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController? myController;
  final int? maxLines;
  final TextDirection? textDirection;
  CustomTextForm
  ({super.key,   required this.hinttext,
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
     ),
  );
  // custom text field
}
}