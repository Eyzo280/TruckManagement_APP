import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/Company_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/invites/invites.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/main_Company_look_trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/search_employees/search_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class CompanyMain extends StatelessWidget {
  final String uidCompany;

  CompanyMain({this.uidCompany});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          // Chat
          Chats.routeName: (ctx) => StreamProvider<List<PeerChat>>.value(
                value:
                    Chat(mainUid: uidCompany, peopleUid: null).getUserChats(),
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
          MainCompanyLookTrucker.routeName: (ctx) =>
              StreamProvider<List<BaseTruckDriverData>>.value(
                  value: Database_CompanyEmployees(uid: uidCompany)
                      .getBaseDataEmployees,
                  child: MainCompanyLookTrucker()),
        },
        home: StreamProvider<CompanyData>.value(
          value: Database_CompanyEmployees(uid: uidCompany).getCompanyData,
          child: CompanyPage(),
        ));
  }
}
