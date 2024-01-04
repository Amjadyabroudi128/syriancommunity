import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController myController;
  const CustomTextForm
  ({ required this.hinttext,
  required this.myController,

});
@override
Widget build(BuildContext context) {
  return TextField(
    controller: myController,
    decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.black
            )
        )
    ),
  );
  // custom text field
}
}