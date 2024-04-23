import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYlist extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final VoidCallback? onTap;
  const MYlist({super.key, this.leading, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      onTap: onTap,
    );
  }
}
