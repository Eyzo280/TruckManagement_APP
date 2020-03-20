import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief_Employees.dart';

import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/fullLookDriverTruck.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services_ChiefEmployees/database_ChiefEmployees.dart';

class ColumnChiefLookDriverTrucks extends StatelessWidget {

  void openFullLookDriverTruck(BuildContext ctx, userdata, index) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return FullLookDriverTruck(userdata, index);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<List<TruckDriver>>(
        stream: Database_ChiefEmployees(uid: user.uid).getDataEmployees,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Card(
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
                                      snapshot.data[index].firstNameDriver,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  child: FittedBox(
                                    child: Text(
                                      snapshot.data[index].lastNameDriver,
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
                              '${snapshot.data[index].salary} zl',
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Text(
                                snapshot.data[index].statusDriver == true
                                    ? 'W trasie'
                                    : 'Wolne'),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.folder_open),
                          onPressed: () {
                            openFullLookDriverTruck(ctx, snapshot.data, index);
                          }),
                    ),
                  ),
                );
              },
            );
          } else
            print(snapshot.data.toString());
          return Text('data');
        });
  }
}
