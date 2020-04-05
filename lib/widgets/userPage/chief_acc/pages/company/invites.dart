import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class Invitations extends StatelessWidget {
  final companyUid;

  Invitations({this.companyUid});

  @override
  Widget build(BuildContext context) {
    final invBaseData = Provider.of<List<InvBaseData>>(context);
    final appBar = AppBar(
      title: Text('Zaproszenia'),
    );
    return invBaseData == null ? Loading() : Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: invBaseData.length,
        itemBuilder: (context, index) {
        return Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text('nazwa'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )),
                      margin: EdgeInsets.only(top: 0),
                      elevation: 5,
                      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.add_a_photo),
                        title: Container(
                          color: Colors.blueGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('Salary:'),
                                  Text('dsadsa'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Znaj j.Obcych:'),
                                  Text('Nie'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Kursy:'), // do jakich krajow sa kursy
                                  Text('PL, DE'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: FittedBox(
                            child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.open_in_new),
                                onPressed: () {
                                  print('Pokaz szczegoly');
                                }),
                            FlatButton(
                                onPressed: () {
                                  Database_CompanyEmployees(companyUid: companyUid).acceptInv(driverUid: invBaseData[index].invUid, firstNameDriver: invBaseData[index].firstNameDriver, lastNameDriver: invBaseData[index].lastNameDriver, numberPhone: invBaseData[index].numberPhone);
                                  print('Akceptuj');
                                },
                                child: Text('Akceptuj'))
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
