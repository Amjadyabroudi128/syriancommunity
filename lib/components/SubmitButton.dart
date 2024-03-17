import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final ButtonStyle? style;
  const CustomButton({ super.key, required this.onPressed, required this.title, this.color, this.style,});

  @override
  Widget build(BuildContext context) {

    return TextButton(
        style: style,
        onPressed: onPressed,
        child: Text(title));
    // custom button component to be used when necessary
  }
}