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

  CameraPosition _cameraPosition = null;

  @override
  void didChangeDependencies() async {
    await Location().getLocation().catchError((err) {
      print(err);
    }).then((val) {
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(val.latitude, val.longitude),
          zoom: 15,
        );
      });
      print(val.longitude);
    });

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _cameraPosition == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
  }
}
