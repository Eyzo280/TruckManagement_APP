import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/fullLookDriverTruck.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class ColumnCompanyLookDriverTrucks extends StatelessWidget {
  final String companyUid;

  ColumnCompanyLookDriverTrucks(this.companyUid);

  void openFullLookDriverTruck(BuildContext ctx, driver, companyUid, index) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return StreamProvider<FullTruckDriverData>.value(
        value: Database_CompanyEmployees(uid: driver, companyUid: companyUid).getFullDataEmployees,
        child: FullLookDriverTruck());
    }));
  }

  @override
  Widget build(BuildContext context) {
    final listDriverTuck = Provider.of<List<BaseTruckDriverData>>(context);

            return listDriverTuck.isEmpty ? Text('data') : ListView.builder(
              itemCount: listDriverTuck.length,
              itemBuilder: (ctx, index) {
                return Container(
                  color: Colors.blueGrey,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(20)),
                                child: Container(
                                    color: Colors.blue,
                                    child: Center(
                                        child: Text(listDriverTuck[index].firstNameDriver +
                                            ' ' +
                                            listDriverTuck[index].lastNameDriver))),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Opacity(opacity: 0.0),
                            ),
                          ],
                        ),
                      ),
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
                        child: ListTile(
                          leading: Icon(Icons.add_a_photo),
                          title: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Imie i Nazwisko:',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text('Pensja:'),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text('Status:'),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      child: FittedBox(
                                        child: Text(
                                          listDriverTuck[index].firstNameDriver,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      child: FittedBox(
                                        child: Text(
                                          listDriverTuck[index].lastNameDriver,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  '${listDriverTuck[index].salary} zl',
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                    listDriverTuck[index].statusDriver == true
                                        ? 'W trasie'
                                        : 'Wolne'),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.folder_open),
                              onPressed: () {
                                openFullLookDriverTruck(
                                    ctx, listDriverTuck[index].uidDriver, companyUid, index);
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );

  }
}
