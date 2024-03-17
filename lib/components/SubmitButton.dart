import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final ShapeBorder? shapeBorder;
  final EdgeInsetsGeometry? padding;
  const CustomButton({ super.key, required this.onPressed, required this.title, this.color, this.shapeBorder, this.padding});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      padding: padding,
        height: 40,
        color: color,
        textColor: Colors.white,
        shape: shapeBorder,
        onPressed: onPressed,
        child: Text(title));
    // custom button component to be used when necessary
  }
}