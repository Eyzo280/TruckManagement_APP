import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/Chief_main_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/Company_main.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class ChiefSelectPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openChiefMain(BuildContext ctx) {
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (ctx) {
          return StreamProvider<User>.value(
            value: AuthService().user,
            child: ChiefMainPage());
        },
      ),
    );
  }

  void openPageCompany(BuildContext ctx, uidCompany) {
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (ctx) {
          return StreamProvider<CompanyData>.value(
            value: Database_CompanyEmployees(uid: uidCompany).getCompanyData,
            child: CompanyMain(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uidCompanys = Provider.of<List<ChiefUidCompanys>>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.add), onPressed: (){}),
        title: Center(child: Text('Wybor Firmy')),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut();
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: RaisedButton(
                onPressed: () {
                  openChiefMain(context);
                },
                child: Text('Glowny Panel'),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                child: Container(
                  width: 200, //
                  height: 500, // trzeba ustawic responsywnosc itp
                  child: ListView.builder(
                    itemCount: uidCompanys.length,
                    itemBuilder: (context, index) {
                      return RaisedButton(
                        onPressed: uidCompanys[index].active == true ? () {
                          openPageCompany(
                              context, uidCompanys[index].uidCompanys);
                        } : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                                'Nazwa Firmy - ${uidCompanys[index].nameCompany}'),
                            Icon(Icons.radio_button_checked,
                            color: uidCompanys[index].active == true ? Colors.green : Colors.red,
                            size: 15,),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
