import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/myImages.dart';
class Containers {

  static Container image = Container(
    height: 250,
    decoration: BoxDecoration(
      image:  DecorationImage(
        image: AssetImage(myImages.logo),
        fit: BoxFit.cover,
      ),
    ),
  );
}