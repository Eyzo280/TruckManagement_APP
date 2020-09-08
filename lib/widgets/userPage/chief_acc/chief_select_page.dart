import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chief.dart';
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

  /*
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
  */

  void openCreateCompany(BuildContext ctx, chiefUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
      return CreateCompany(chiefUid: chiefUid);
    }));
  }

  Widget selectHome({BuildContext context, Chief user}) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              openCreateCompany(context, user.uid);
            }),
        title: Center(child: Text('Wybor Firmy')),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
                color: Theme.of(context).canvasColor,
                child: Text('Glowny Panel'),
              ),
            ),
            Flexible(
              fit: user.companys != [] ? FlexFit.tight : FlexFit.loose,
              child: user.companys != []
                  ? SingleChildScrollView(
                      child: Container(
                        width: 200, //
                        height: 500, // trzeba ustawic responsywnosc itp
                        child: ListView.builder(
                          itemCount: user.companys.length,
                          itemBuilder: (ctx, index) {
                            return RaisedButton(
                              onPressed: () {
                                //openPageCompany(context, user.companys[index][key]);
                                Navigator.of(ctx).pushNamed(
                                  CompanyMain.routeName,
                                  arguments: {
                                    'uid': user.companys[index].keys.first
                                        .toString(),
                                  },
                                );
                              },
                              color: Theme.of(context).canvasColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                      'Nazwa Firmy - '), // ${user.companys[index].values.first}
                                  Icon(
                                    Icons.radio_button_checked,
                                    color: user.companys[index][key] == true
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

  @override
  Widget build(BuildContext context) {
    final Chief user = Provider.of<UserData>(context).data;
    // final uidCompanys = Provider.of<List<ChiefUidCompanys>>(context) ?? [];
    return MaterialApp(
      theme: basicTheme(),
      routes: {
        '/chief/': (ctx) => ChiefMainPage(),
        '/company/': (ctx) {
          final routeArgs =
              ModalRoute.of(ctx).settings.arguments as Map<String, dynamic>;
          final uid = routeArgs['uid'];
          return StreamProvider<CompanyData>.value(
            value: Database_Company(uid: uid).getCompanyData,
            child: CompanyMain(),
          );
        },
      },
      home: selectHome(context: context, user: user),
    );
  }
}
