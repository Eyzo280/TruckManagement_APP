import 'package:flutter/material.dart';

class TopBodyChiefLookDriverTrucks extends StatelessWidget {
  final List<Map<String, Object>> listToTopBody;

  TopBodyChiefLookDriverTrucks(this.listToTopBody);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Wolnych:'),
                  Text('${listToTopBody[0]['Wolnych']}'),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('W trasie:'),
                  Text('${listToTopBody[0]['W trasie']}'),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Najlepszy:'),
                  Text('${listToTopBody[0]['Najlepszy']}'),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Nalezne:'),
                  Text('${listToTopBody[0]['Nalezne']} zl'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
