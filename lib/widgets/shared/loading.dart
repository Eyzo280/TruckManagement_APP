import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: const AssetImage("images/Background-Image.jpg"),
                  fit: BoxFit.cover),
            ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 80,
          ),
        ),
      ),
    );
  }
}
