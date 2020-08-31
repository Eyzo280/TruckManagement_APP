import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';
import 'widgets/drawer.dart';

class TruckerPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openSearchCompany(BuildContext ctx, DriverTruck user) {
    Navigator.of(ctx).pushNamed(
      TruckerSearchCompany.routeName,
      arguments: {
        'userData': user,
      },
    );
  }

  void _openChats(BuildContext ctx, String driverUid) {
    Navigator.of(ctx).pushNamed(Chats.routeName, arguments: {
      'userUid': driverUid,
    });
  }

  @override
  Widget build(BuildContext context) {
    final Trucker user = Provider.of<UserData>(context).data ?? null;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panel Główny',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: const Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut(context);
              },
            ),
          ),
        ],
      ),
      drawer: DrawerTrucker(
        uid: user.uid,
        nickName: user.nickName,
      ),
      // backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  margin: EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: Text('1'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset('images/maps.JPG'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
