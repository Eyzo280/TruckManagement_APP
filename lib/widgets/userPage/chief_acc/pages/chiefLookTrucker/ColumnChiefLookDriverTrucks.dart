import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/truckDriver.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/fullLookDriverTruck.dart';

class ColumnChiefLookDriverTrucks extends StatelessWidget {
  final List<TruckDriver> listDriversTrucks;

  ColumnChiefLookDriverTrucks(this.listDriversTrucks);

  void openFullLookDriverTruck(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return FullLookDriverTruck();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDriversTrucks.length,
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
                    child: Text(
                      listDriversTrucks[index].nameDriver,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      '${listDriversTrucks[index].salary} zl',
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(listDriversTrucks[index].statusDriver == true
                        ? 'W trasie'
                        : 'Wolne'),
                  ),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.folder_open),
                  onPressed: () {
                    openFullLookDriverTruck(ctx);
                  }),
            ),
          ),
        );
      },
    );
  }
}
