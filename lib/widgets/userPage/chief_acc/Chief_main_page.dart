import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chief/preview_company.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_chief.dart';

class ChiefMainPage extends StatelessWidget {
  final user;

  ChiefMainPage(this.user);

  final AuthService _auth = AuthService();
  
  void openPagePreviewCompany(BuildContext ctx, userUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return StreamProvider<List<BaseCompanyData>>.value(
        value: DataBase_Chief(uid: userUid).getBaseCompanyData,
        child: PreviewCompany(chiefUid: userUid));
    }));
  }

  // Powrot do wyboru firmy
  void openSelectPage(BuildContext ctx, uid) {
    Navigator.pushReplacement(ctx, MaterialPageRoute(
      builder: (ctx) {
        return StreamProvider<List<ChiefUidCompanys>>.value(
          value: DatabaseService(uid: uid).getUidCompanys,
          child: ChiefSelectPage(),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chief Main'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut(context);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                                      child: Text(
                      user.displayName ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(width: MediaQuery.of(context).size.height * 0.1, height: MediaQuery.of(context).size.height * 0.1, decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://i.imgur.com/BoN9kdC.png'), fit: BoxFit.fill), shape: BoxShape.circle),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text('ID: ${user.uid}'),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.chrome_reader_mode),
              title: Text('Zmien Zarzadzanie'),
              onTap: () {
                openSelectPage(context, user.uid);
                print('Zmien Zarzadzanie');
              },
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
