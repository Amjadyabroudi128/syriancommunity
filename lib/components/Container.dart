import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/myImages.dart';
class Containers {
  static Container location = Container(
    height: 300,
    width: 370,
    child: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(50.82062318563144, -0.12208351759729541),
        zoom: 14,
      ),
      markers: {
        Marker(

            markerId: MarkerId("college"),
            position: LatLng(50.82062318563144, -0.12208351759729541),
            draggable: true,
            onDragEnd: (value) {
            }
        )
      },
    ),
  );
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