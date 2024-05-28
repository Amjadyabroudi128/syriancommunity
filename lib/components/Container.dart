import 'package:flutter/material.dart';
import 'package:syrianadmin/components/icons.dart';


class Containers {
  static Container image = Container(
    height: 250,
    decoration: BoxDecoration(
      image:  DecorationImage(
        image: AssetImage(myIcons.logo),
        fit: BoxFit.cover,
      ),
    ),
  );
}