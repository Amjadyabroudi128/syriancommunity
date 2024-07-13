import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'icons.dart';

class goBack extends StatelessWidget {
  final VoidCallback? onPressed;
  const goBack({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: myIcons.goBack
    );
  }
}
