
import 'package:flutter/material.dart';
class AppSizing{
  static double myWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double sWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.69;
  static double imageWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.50;
}