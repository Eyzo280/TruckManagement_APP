/*
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/register_chief.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/register_driverTruck.dart';

class SelectRegister extends StatefulWidget {
  final Function toggleView;

  SelectRegister({this.toggleView});

  @override
  _SelectRegisterState createState() => _SelectRegisterState();
}

class _SelectRegisterState extends State<SelectRegister> {
  String selected_register = '';

  @override
  Widget build(BuildContext context) {
    if (selected_register == '') {
      return Scaffold(
          appBar: AppBar(
            title: Text('Rodzaj konta'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        selected_register = 'Chief';
                      });
                    },
                    child: Text('Szef'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        selected_register = 'Forwarder';
                      });
                    },
                    child: Text('Spedytor'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        selected_register = 'DriverTruck';
                      });
                    },
                    child: Text('Kierowca'),
                  ),
                ],
              ),
            ),
          ));
    } else {
      if (selected_register == 'Chief') {
        return RegisterChief(
          toggleView: widget.toggleView,
        );
      } else if (selected_register == 'Forwarder') {
        //return;
      } else if (selected_register == 'DriverTruck') {
        
        return RegisterDriverTruck(
          toggleView: widget.toggleView,
        );
      }
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/register_chief.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/register_forwarder.dart';
import 'package:truckmanagement_app/widgets/Authenticate/Register/register_trucker.dart';

class SelectRegister extends StatefulWidget {
  final Function toggleView;
  final Size deviceSize;

  SelectRegister({
    this.toggleView,
    this.deviceSize,
  });

  @override
  _SelectRegisterState createState() => _SelectRegisterState();
}

class _SelectRegisterState extends State<SelectRegister> {
  String typeRegister = '';

  Widget buttonTypeRegister(BuildContext context, String type) {
    return Container(
      height: widget.deviceSize.width * 0.15,
      width: widget.deviceSize.width * 0.4,
      margin: EdgeInsets.all(25),
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          if (type == 'Chief') {
            setState(() {
              typeRegister = 'Chief';
            });
          } else if (type == 'Forwarder') {
            setState(() {
              typeRegister = 'Forwarder';
            });
          } else if (type == 'Trucker') {
            setState(() {
              typeRegister = 'Trucker';
            });
          }
        },
        child: Text(
          type,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return typeRegister == 'Chief'
        ? RegisterChief(
            deviceSize: widget.deviceSize,
            toggleView: widget.toggleView,
          )
        : typeRegister == 'Forwarder'
            ? RegisterForwarder(
                deviceSize: widget.deviceSize,
                toggleView: widget.toggleView,
              )
            : typeRegister == 'Trucker'
                ? RegisterTrucker(
                    deviceSize: widget.deviceSize,
                    toggleView: widget.toggleView,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Card(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          child: Column(
                            children: <Widget>[
                              buttonTypeRegister(context, 'Chief'),
                              buttonTypeRegister(context, 'Forwarder'),
                              buttonTypeRegister(context, 'Trucker'),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: FlatButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
  }
}
