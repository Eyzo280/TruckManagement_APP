import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FullLookDriverTruck extends StatelessWidget {
  final List listDriversTrucks;
  final int indexDriver;

  FullLookDriverTruck(this.listDriversTrucks, this.indexDriver);

  @override
  Widget build(BuildContext context) {
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
                listDriversTrucks[indexDriver].statusDriver == true
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
                          Text(
                              'Imie: ${listDriversTrucks[indexDriver].firstNameDriver}'),
                          Text(
                              'Nazwisko: ${listDriversTrucks[indexDriver].lastNameDriver}'),
                          Text(
                              'Data Zatrudnienia: ${DateFormat('dd-MM-yyy').format(listDriversTrucks[indexDriver].dateOfEmplotment)}'),
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
                Text(
                    'Przejechane Km: ${listDriversTrucks[indexDriver].distanceTraveled}'),
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