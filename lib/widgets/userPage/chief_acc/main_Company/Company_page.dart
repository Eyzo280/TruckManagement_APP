import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/main_Company/drawer.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/main_Company/lastTracks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/main_Company/map.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/main_Company/topBody.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets//chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/invites/invites.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/main_company_look_trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/search_employees/search_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/tracks/add_New_Track.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/tracks/select_Preview.dart';

class CompanyPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openChiefLookTrucker(BuildContext ctx, CompanyData companyData) {

    Navigator.of(ctx).pushNamed(MainCompanyLookTrucker.routeName, arguments: {'companyData': companyData});
  }

  

  

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Firma - ' + companyData.nameCompany),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: [0.001, 1],
              colors: [
                Theme.of(context).textTheme.display1.color,
                Theme.of(context).textTheme.display2.color,
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerCompanyMain(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0.001, 1],
            colors: [
              Theme.of(context).textTheme.display1.color,
              Theme.of(context).textTheme.display2.color,
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TopBodyCompanyMain(),
            LastTracksCompanyMain(),
            MapCompanyMain()
          ],
        ),
      ),
    );
  }
}
