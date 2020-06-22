import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers_widgets/truckerLookFullInfo.dart';

class TruckerLookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<BaseTruckDriverData> listDriverTruck =
        Provider.of<List<BaseTruckDriverData>>(context) ?? null;

    return Flexible(
      flex: 6,
      fit: FlexFit.loose,
      child: listDriverTruck == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount: listDriverTruck.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey.shade100,
                      child: ListTile(
                        leading: Container(
                            padding: EdgeInsets.all(3),
                            child: Image.asset('images/image-512.png')),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Imie:'),
                            Text('Pensja:'),
                            Text('Status:'),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Hero(
                              tag: 'Name' + index.toString(),
                              child: Text(listDriverTruck[index].firstName),
                            ),
                            Text('${listDriverTruck[index].salary} zl'),
                            Hero(
                              tag: 'Status' + index.toString(),
                              child: Text(
                                  listDriverTruck[index].statusDriver == true
                                      ? 'W trasie'
                                      : 'Wolne'),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return TruckerLookFullInfo(
                                    index: index,
                                    driverTruck: listDriverTruck[index]);
                              },
                            ));
                          },
                          icon: Icon(Icons.folder_open),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
