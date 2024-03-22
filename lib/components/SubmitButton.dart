import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  const CustomButton({ super.key, required this.onPressed, required this.title, this.color, this.padding, this.textColor,});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      padding: padding,
        height: 40,
        color: color,
        textColor: textColor,
        onPressed: onPressed,
        child: Text(title));
    // custom button component to be used when necessary
  }
}