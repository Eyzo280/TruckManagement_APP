import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/map.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/track.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/unloading.dart';
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
            child: Track(),
          ),
          // Map
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: TruckerMap(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
