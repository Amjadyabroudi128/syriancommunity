import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomButton({ super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
        height: 40,
        color: const Color.fromARGB(255, 33, 173, 168),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: Text(title));
    // custom button component to be used when necessary
  }
}