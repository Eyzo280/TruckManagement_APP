import 'package:flutter/material.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers_widgets/truckerLookList.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers_widgets/truckerLookTopStats.dart';

class TruckerLook extends StatelessWidget {
  static const routeName = '/TruckerLook';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kierowcy'),
        centerTitle: true,
        flexibleSpace: appBarLook(context: context),
      ),
      body: Container(
        decoration: bodyLook(context: context),
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TruckerLookTopStats(),
            TruckerLookList(),
          ],
        ),
      ),
    );
  }
}
