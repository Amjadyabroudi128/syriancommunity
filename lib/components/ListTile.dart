import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYlist extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  const MYlist({super.key, this.leading, this.title, this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: trailing,
      leading: leading,
      title: title,
      onTap: onTap,
    );
  }
}
