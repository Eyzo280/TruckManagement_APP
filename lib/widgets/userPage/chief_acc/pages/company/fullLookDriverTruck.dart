import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';

class FullLookDriverTruck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final driverTuck = Provider.of<FullTruckDriverData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('NameDriver'),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Status:'),
                driverTuck.statusDriver == null
                    ? Text('Brak danych')
                    : driverTuck.statusDriver == true
                        ? Text('W Trasie')
                        : Text('Wolne'),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 150,
                      child: Card(
                        elevation: 3,
                        child: Center(
                          child: Text('Image'),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(driverTuck.firstNameDriver == null
                              ? Text('Brak danych')
                              : 'Imie: ${driverTuck.firstNameDriver}'),
                          Text(driverTuck.lastNameDriver == null
                              ? Text('Brak danych')
                              : 'Nazwisko: ${driverTuck.lastNameDriver}'),
                          Text(driverTuck.dateOfEmplotment == null
                              ? Text('Brak danych')
                              : 'Data Zatrudnienia: ${DateFormat('dd-MM-yyy').format(driverTuck.dateOfEmplotment)}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                Text(driverTuck.distanceTraveled == null
                    ? Text('Brak danych')
                    : 'Przejechane Km: ${driverTuck.distanceTraveled}'),
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 175,
                  child: Card(
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'Wykres przejechanych kilometrow z ostatnich 6 mies',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                Text('Obecna Ciezarowka'),
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 175,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Ciezarowka: Scania'),
                            Text('Model: R500'),
                            Text('Rok Produkcji: 2019'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Tablice:'),
                            Text('WS 30S3'),
                            Text('Przebieg: 50k'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
