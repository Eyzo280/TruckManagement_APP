import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/Company_page.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/advertisement/addNew.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/applications/applications.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/invites/invites.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/searchDriver.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Active/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Finished/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/select_Preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';
import './providers/applications.dart' as providers;
import 'pages/advertisement/advertisement.dart';

class CompanyMain extends StatelessWidget {
  static const routeName = '/company/';

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context) ?? null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: providers.Applications(),
        ),
      ],
      child: MaterialApp(
        theme: basicTheme(),
        routes: {
          // Applications
          '/Applications/': (ctx) => Applications(uidCompany: companyData.uid,),
          // Advertisement
          '/advertisement/': (ctx) => Advertisement(),
          '/advertisement/AddAdvertisement': (ctx) => AddAdvertisement(),

          // Chat
          Chats.routeName: (ctx) => StreamProvider<List<PeerChat>>.value(
                value: Chat(mainUid: companyData.uid, peopleUid: null)
                    .getUserChats(),
                child: Chats(),
              ),
          // Wyszukiwarka Pracownikow
          SearchDriver.routeName: (ctx) => SearchDriver(),
          // Zaproszenia
          Invitations.routeName: (ctx) {
            return Invitations(companyUid: companyData.uid);
          },
          // Podglad pracownikow firmy
          TruckerLook.routeName: (ctx) =>
              StreamProvider<List<BaseTruckDriverData>>.value(
                value:
                    Database_Company(uid: companyData.uid).getBaseDataEmployees,
                child: TruckerLook(),
              ),
          TracksManagement.routeName: (ctx) {
            return TracksManagement();
          },
          TracksActive.routeName: (ctx) {
            final listTracks = Provider.of<List<Track>>(context);
            return TracksActive(
              companyUid: companyData.uid,
              listTracks: listTracks,
            );
          },
          TracksFinished.routeName: (ctx) => TracksFinished(
                companyData: companyData,
              ),
        },
        home: companyData == null
            ? Loading()
            : CompanyPage(
                companyData: companyData,
              ),
      ),
    );
  }
}
