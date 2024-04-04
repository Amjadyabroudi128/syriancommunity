import 'package:flutter/material.dart';

class sizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
   const sizedBox({super.key, this.height, this.width, this.child});

  @override
  Widget build(BuildContext context) {
  return  SizedBox(
    height: height,
    width: width ,
    child: child,
  );
  }

}