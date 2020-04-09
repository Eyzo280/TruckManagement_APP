import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/forwarder_acc/forwarder_main.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_main.dart';

class SelectUser extends StatefulWidget {
  final UserData data;

  SelectUser(this.data);
  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {

  @override
  Widget build(BuildContext context) {
    final UserData userData = widget.data;

    print('Problem');
    if (userData.typeUser == 'Chief') {
      return StreamProvider<List<ChiefUidCompanys>>.value(
        value: DatabaseService(uid: userData.uid).getUidCompanys,
        child: ChiefSelectPage());
    } else if (userData.typeUser == 'Forwarder') {
      return ForwarderMain();
    } else if (userData.typeUser == 'DriverTruck') {
      return StreamProvider<DriverTruck>.value(
        value: DatabaseService(uid: userData.uid).dataDriver,
        child: TruckerMain());
    } else {
      return ErrorPage();
    }
  }
}