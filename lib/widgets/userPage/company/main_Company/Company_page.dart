import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/drawer.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/lastTracks.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/map.dart';
import 'package:truckmanagement_app/widgets/userPage/company/main_Company/topBody.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/searchDriver.dart';

class CompanyPage extends StatelessWidget {
  final CompanyData companyData;

  CompanyPage({this.companyData});

  final AuthService _auth = AuthService();

  void openChiefLookTrucker(BuildContext ctx, CompanyData companyData) {
    Navigator.of(ctx).pushNamed(SearchDriver.routeName,
        arguments: {'companyData': companyData});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(companyData.nameCompany),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerCompanyMain(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TopBodyCompanyMain(companyData: companyData),
            LastTracksCompanyMain(),
            MapCompanyMain()
          ],
        ),
      ),
    );
  }
}
