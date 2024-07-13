import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'icons.dart';

class goBack extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  const goBack({super.key, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon!
    );
  }
}
