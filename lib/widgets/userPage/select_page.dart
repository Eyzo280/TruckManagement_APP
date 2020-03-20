import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_mainBazaDanych.dart';
import 'package:truckmanagement_app/widgets/userPage/forwarder_acc/forwarder_main.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_main.dart';

class SelectPage extends StatefulWidget {
  final UserData data;

  SelectPage(this.data);
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  @override
  Widget build(BuildContext context) {
    final UserData userData = widget.data;

    if (userData.typeUser == 'Chief') {
      return ChiefMainBazaDanych();
    } else if (userData.typeUser == 'Forwarder') {
      return ForwarderMain();
    } else if (userData.typeUser == 'DriverTruck') {
      return TruckerMain();
    } else {
      return ErrorPage();
    }
  }
}