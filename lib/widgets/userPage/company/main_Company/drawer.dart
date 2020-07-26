import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/invites/invites.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/searchDriver.dart';


class DrawerCompanyMain extends StatelessWidget {
  final AuthService _auth = AuthService();

  // Powrot do wyboru firmy
  void _openSelectPage(BuildContext ctx, companyUid) {
    Navigator.pushReplacement(ctx, MaterialPageRoute(
      builder: (ctx) {
        String method(String str) {
          return str.substring(0, str.length - 2);
        } // Teraz problemem jest ze gdyby ktos mial ponad 9 firm to bedzie odejmowac tylko dwie koncowe litery i bedzie blad

        return StreamProvider<List<ChiefUidCompanys>>.value(
          value: DatabaseService(uid: method(companyUid)).getUidCompanys,
          child: ChiefSelectPage(),
        );
      },
    ));
  }

  void _openInvitations(BuildContext ctx, companyUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return /* StreamProvider<List<InvBaseData>>.value(
            value:
                Database_CompanyEmployees(companyUid: companyUid).getInvBaseData,
            child: Invitations(companyUid: companyUid));
            */
          Invitations(companyUid: companyUid);
    }));
  }

  void _openChats(ctx, companyUid) {
    Navigator.of(ctx).pushNamed(Chats.routeName, arguments: {
      'userUid': companyUid,
    });
  }

  void _openSearchEmployees(BuildContext ctx, CompanyData companyData) {
    Navigator.of(ctx).pushNamed(SearchDriver.routeName, arguments: {
      'companyData': companyData,
    });
  }

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Marek S.',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        icon: Icon(
                          MaterialCommunityIcons.logout,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () async {
                          print('Logout');
                          return await _auth.signOut(context);
                        })
                  ],
                ),
                Row(
                  children: <Widget>[],
                )
              ],
            ),
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
          ListTile(
            leading: Icon(Icons.chrome_reader_mode),
            title: Text('Zmien Zarzadzanie'),
            onTap: () {
              _openSelectPage(context, companyData.uid);
              print('Zmien Zarzadzanie');
            },
          ),
          ListTile(
            // leading: Icon(MaterialCommunityIcons.email_open),
            leading: Icon(Icons.assignment_ind),
            title: Text(
              'Zaproszenia',
            ),
            onTap: () {
              _openInvitations(context, companyData.uid);
              print('Zaproszenia');
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () {
              _openChats(context, companyData.uid);
              print('Chat');
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Szukaj Pracownikow'),
            onTap: () {
              _openSearchEmployees(context, companyData);
              print('Szukaj Pracownikow');
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.train_car),
            title: Text('Szukaj Kursow'),
            onTap: () {
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ;
                  },
                ),
              );
              */
              print('Szukaj Kursow');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              print('Settings');
            },
          ),
        ],
      ),
    );
  }
}
