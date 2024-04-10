import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYlist extends StatelessWidget {
  final Widget? leading;
  const MYlist({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      iconColor: Colors.black,
    );
  }
}
