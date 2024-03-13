import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
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
  }
}
