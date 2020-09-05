import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapCompanyMain extends StatefulWidget {
  @override
  _MapCompanyMainState createState() => _MapCompanyMainState();
}

class _MapCompanyMainState extends State<MapCompanyMain> {
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
    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: _cameraPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
        ),
      ),
    );
  }
}
