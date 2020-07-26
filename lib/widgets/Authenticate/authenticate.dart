import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/select_register.dart';
import 'package:truckmanagement_app/widgets/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String showPage = 'SignIn';

  void toggleView(String val) {
    setState(() {
      showPage = val;
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
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    margin: const EdgeInsets.all(25),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      height: showPage == 'SignIn'
                          ? 430
                          : showPage == 'Register'
                              ? 460
                              : showPage == 'Chief' ? 650 : 550,
                      width: showPage == 'SignIn'
                          ? 350
                          : showPage == 'Register' ? 300 : 350,
                      child: ListView(
                        children: <Widget>[
                          showPage == 'SignIn'
                              ? SignIn(
                                  toggleView: toggleView,
                                  deviceSize: deviceSize,
                                )
                              : SelectRegister(
                                  toggleView: toggleView,
                                  deviceSize: deviceSize,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showPage == 'SignIn' ? 1 : 0,
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                      child: const Text(
                        'Kontakt',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: showPage != 'SignIn'
                          ? null
                          : () {
                              print('Kontakt');
                            },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
