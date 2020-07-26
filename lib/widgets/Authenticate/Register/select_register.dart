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
      margin: const EdgeInsets.all(25),
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          if (type == 'Chief') {
            setState(() {
              typeRegister = 'Chief';
              widget.toggleView('Chief');
            });
          } else if (type == 'Forwarder') {
            setState(() {
              typeRegister = 'Forwarder';
              widget.toggleView('Forwarder');
            });
          } else if (type == 'Trucker') {
            setState(() {
              typeRegister = 'Trucker';
              widget.toggleView('Trucker');
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
                    children: <Widget>[
                      buttonTypeRegister(context, 'Chief'),
                      buttonTypeRegister(context, 'Forwarder'),
                      buttonTypeRegister(context, 'Trucker'),
                      Container(
                        margin: const EdgeInsets.all(25),
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: () {
                            widget.toggleView('SignIn');
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  );
  }
}
