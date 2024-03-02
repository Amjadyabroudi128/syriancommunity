import 'package:flutter/material.dart';

class sizedBox extends StatelessWidget {
  final double? height;
  const sizedBox({super.key, this.height});

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    height: 10,
  );
  }

}