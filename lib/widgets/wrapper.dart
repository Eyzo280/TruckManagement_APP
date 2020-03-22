import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/Authenticate/authenticate.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/select_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return SelectPage(snapshot.data);
          }else {
            return Loading();
          }
        });
       //ChiefMainBazaDanych();
    }
  }
}
