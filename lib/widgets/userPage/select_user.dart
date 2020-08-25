import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/forwarder_acc/forwarder_main.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_main.dart';

class SelectUser extends StatefulWidget {
  //final data;

  //SelectUser(this.data);
  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false) ?? null;

    print('Problem');
    if (user == null) {
      return Loading();
    } else if (user.data.type == 'Chief') {
      return StreamProvider<List<ChiefUidCompanys>>.value(
          value: DatabaseService(uid: user.data.uid).getUidCompanys,
          child: ChiefSelectPage());
    } else if (user.data.type == 'Forwarder') {
      return ForwarderMain();
    } else if (user.data.type == 'Trucker') {
      return TruckerMain();
    } else {
      return ErrorPage();
    }
  }
}
