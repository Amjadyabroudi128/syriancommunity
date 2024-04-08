import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final ButtonTextTheme? textTheme;
  const CustomButton({ super.key, required this.onPressed, required this.title, this.color, this.padding, this.textColor, this.textTheme,});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        padding: padding,
        height: 40,
        color: color,
        textColor: textColor,
        onPressed: onPressed,
        textTheme: textTheme,
        child: Text(title));
    // custom button component to be used when necessary
  }
}