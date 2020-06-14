import 'package:flutter/material.dart';

class MapCompanyMain extends StatefulWidget {
  @override
  _MapCompanyMainState createState() => _MapCompanyMainState();
}

class _MapCompanyMainState extends State<MapCompanyMain> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: Container(
        // color: Colors.white,
        child: Center(
            child: Image.asset(
          'images/maps.JPG',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        )),
      ),
    );
  }
}
