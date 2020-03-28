import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chief/preview_company.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_chief.dart';

class ChiefMainPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  
  void openPagePreviewCompany(BuildContext ctx, userUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return StreamProvider<List<BaseCompanyData>>.value(
        value: DataBase_Chief(uid: userUid).getBaseCompanyData,
        child: PreviewCompany(chiefUid: userUid));
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chief Main'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Zarzadzanie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Podglad Firm'),
              onTap: () {
                openPagePreviewCompany(context, user.uid);
                print('Podglad Firm');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Messages'),
              onTap: () {
                print('Messages');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print('Settings');
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Text('data'),
      ),
    );
  }
}
