import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  const CustomButton({ super.key, required this.onPressed, required this.title, this.color});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
        height: 40,
        color: color,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: Text(title));
    // custom button component to be used when necessary
  }
}