import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/Chief_main_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chief/create_company.dart';
import 'package:truckmanagement_app/widgets/userPage/company/Company_main.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';

class ChiefSelectPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openPageCompany(BuildContext ctx, String companyUid) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) {
          return StreamProvider<CompanyData>.value(
              value: Database_Company(uid: companyUid).getCompanyData,
              child: StreamProvider<List<Track>>.value(
                  value: Database_Company(companyUid: companyUid)
                      .streamActiveTracks,
                  child: CompanyMain()));
        },
      ),
    );
  }

  void openCreateCompany(BuildContext ctx, chiefUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
      return CreateCompany(chiefUid: chiefUid);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);
    final uidCompanys = Provider.of<List<ChiefUidCompanys>>(context) ?? [];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              openCreateCompany(context, user.uid);
            }),
        title: Center(child: Text('Wybor Firmy')),
        centerTitle: true,
        flexibleSpace: appBarLook(context: context),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: bodyLook(context: context),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChiefMainPage();
                      },
                    ),
                  );
                },
                child: Text('Glowny Panel'),
              ),
            ),
            Flexible(
              fit: uidCompanys != [] ? FlexFit.tight : FlexFit.loose,
              child: uidCompanys != []
                  ? SingleChildScrollView(
                      child: Container(
                        width: 200, //
                        height: 500, // trzeba ustawic responsywnosc itp
                        child: ListView.builder(
                          itemCount: uidCompanys.length,
                          itemBuilder: (context, index) {
                            return RaisedButton(
                              onPressed: uidCompanys[index].active == true
                                  ? () {
                                      openPageCompany(context,
                                          uidCompanys[index].uidCompanys);
                                    }
                                  : null,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                      'Nazwa Firmy - ${uidCompanys[index].nameCompany}'),
                                  Icon(
                                    Icons.radio_button_checked,
                                    color: uidCompanys[index].active == true
                                        ? Colors.green
                                        : Colors.red,
                                    size: 15,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
