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
    if (showSignIn == true) {
      return SignIn(toggleView: toggleView, deviceSize: deviceSize,);
    } else {
      return SelectRegister(toggleView: toggleView, deviceSize: deviceSize,);
    }
  }
}
