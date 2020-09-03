import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TruckerMap extends StatefulWidget {
  @override
  _TruckerMapState createState() => _TruckerMapState();
}

class _TruckerMapState extends State<TruckerMap> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void didChangeDependencies() async {
    final locDat = await Location().getLocation();

    _cameraPosition = CameraPosition(
      target: LatLng(locDat.latitude, locDat.longitude),
      zoom: _cameraPosition.zoom,
    );

    print(locDat.longitude);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
