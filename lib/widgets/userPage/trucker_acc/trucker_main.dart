import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/advertisements.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/applications.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/screens/application.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/screens/myAppliactions.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/services_Trucker/database_Trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_page.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';
import 'screens/advertisements.dart';

class TruckerMain extends StatelessWidget {
  final userData;

  TruckerMain({this.userData});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TruckerAdvertisements(),
        ),
        ChangeNotifierProvider.value(
          value: Applications(),
        )
      ],
      child: MaterialApp(
        theme: basicTheme(),
        routes: {
          // Advertisement
          '/TruckerNewApplication/': (ctx) => TruckerNewApplication(),
          // Drawer
          '/Advertisements/': (ctx) => Advertisements(),
          '/MyApplications/': (ctx) => MyApplications(),
          //
          '/searchCompany': (ctx) =>
              StreamProvider<List<BaseSearchCompany>>.value(
                value: DataBase_Trucker().getBaseSearchCompany,
                child: TruckerSearchCompany(),
              ),
          '/Chats': (ctx) => StreamProvider<List<PeerChat>>.value(
                value:
                    Chat(mainUid: userData.uid, peopleUid: null).getUserChats(),
                child: Chats(),
              ),
        },
        home: TruckerPage(),
      ),
    );
  }
}
