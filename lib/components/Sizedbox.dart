import 'package:flutter/material.dart';

class sizedBox extends StatelessWidget {
  final double? height;
  final double? width;
   const sizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
  return  SizedBox(
    height: 10,
    width: width ,
  );
  }

}