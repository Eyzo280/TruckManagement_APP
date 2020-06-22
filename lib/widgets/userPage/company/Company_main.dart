import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/Company_page.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company_look_trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/invites/invites.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_employees/search_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Active/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Finished/preview.dart';

class CompanyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);
    return MaterialApp(
        theme: basicTheme(),
        routes: {
          // Chat
          Chats.routeName: (ctx) => StreamProvider<List<PeerChat>>.value(
                value: Chat(mainUid: companyData.uidCompany, peopleUid: null)
                    .getUserChats(),
                child: Chats(),
              ),
          // Wyszukiwarka Pracownikow
          SearchEmployees.routeName: (ctx) => SearchEmployees(),
          // Zaproszenia
          Invitations.routeName: (ctx) {
            final routeArgs =
                ModalRoute.of(ctx).settings.arguments as Map<String, String>;

            final companyUid = routeArgs['companyUid'];
            return Invitations(companyUid: companyUid);
          },
          // Podglad pracownikow firmy
          TruckerLook.routeName: (ctx) =>
              StreamProvider<List<BaseTruckDriverData>>.value(
                  value: Database_CompanyEmployees(uid: companyData.uidCompany)
                      .getBaseDataEmployees,
                  child: TruckerLook()),
          TracksActive.routeName: (ctx) {
            final listTracks = Provider.of<List<Track>>(context);
            return TracksActive(
              companyUid: companyData.uidCompany,
              listTracks: listTracks,
            );
          },
          TracksFinished.routeName: (ctx) => TracksFinished(
                companyData: companyData,
              ),
        },
        home: StreamProvider<CompanyData>.value(
          value: Database_CompanyEmployees(uid: companyData.uidCompany)
              .getCompanyData,
          child: CompanyPage(),
        ));
  }
}
