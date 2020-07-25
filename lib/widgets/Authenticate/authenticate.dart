import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/select_register.dart';
import 'package:truckmanagement_app/widgets/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage("images/Background-Image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: showSignIn == true
              ? SignIn(
                  toggleView: toggleView,
                  deviceSize: deviceSize,
                )
              : Card(
                child: SelectRegister(
                    toggleView: toggleView,
                    deviceSize: deviceSize,
                  ),
              ),
        ),
      ),
    );
  }
}
