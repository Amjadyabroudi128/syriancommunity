import 'package:flutter/cupertino.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class addEvent extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  const addEvent({super.key, required this.onPressed, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      title: title,
      color: color,
    );
  }
}
