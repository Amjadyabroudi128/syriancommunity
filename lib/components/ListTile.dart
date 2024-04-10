import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYlist extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  const MYlist({super.key, this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      iconColor: Colors.black,
      title: title,
    );
  }
}
