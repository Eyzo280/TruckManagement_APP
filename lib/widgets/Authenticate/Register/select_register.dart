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
