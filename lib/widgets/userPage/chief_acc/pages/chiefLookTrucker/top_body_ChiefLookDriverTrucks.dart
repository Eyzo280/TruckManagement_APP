import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief_Employees.dart';

class TopBodyChiefLookDriverTrucks extends StatefulWidget {
  @override
  _TopBodyChiefLookDriverTrucksState createState() => _TopBodyChiefLookDriverTrucksState();
}

class _TopBodyChiefLookDriverTrucksState extends State<TopBodyChiefLookDriverTrucks> {
  List<BaseTruckDriverData> listDriverTrucks = [];

  // Nalezne kierowcy kazdego z osobna
  List<Map<String, Object>> get listDueDrivers {
    return List.generate(
      listDriverTrucks.length,
      (index) {
        int due = 0;
        due = listDriverTrucks[index].earned -
            listDriverTrucks[index].paid;
        return {
          'NameDriver': listDriverTrucks[index].firstNameDriver + ' ' + listDriverTrucks[index].lastNameDriver.substring(0,1),
          'DueDriver': due
        };
      },
    );
  }

  // Lista do TopBody ile wolych kierowcow, kto najlepszy, ile razem jest naleznego itp.
  List<Map<String, Object>> get listToTopBody {
    
    return List.generate(1, (index) {
      int wolnych = 0;
      int wTrasie = 0;
      double przejechanekilomertynajkierowcy = 0;
      String najlepszyTrucker =
          ''; // Tymczasowo bedzie polegac na tym kto przejechal najwiecej kilometrow
      int nalezne = 0;

      // Petla ktora ustawia ile jest wolnych pracownikow, W Trasie
      for (var i = 0; i < listDriverTrucks.length; i++) {
        if (listDriverTrucks[i].statusDriver == false) {
          wolnych = wolnych + 1;
        } else if (listDriverTrucks[i].statusDriver == true) {
          wTrasie = wTrasie + 1;
        }
        nalezne = nalezne + listDueDrivers[i]['DueDriver'];

        // na bazie danych chyba wystarczylo by uzyc Where Max
        if (listDriverTrucks[i].distanceTraveled >
            przejechanekilomertynajkierowcy) {
          przejechanekilomertynajkierowcy =
              listDriverTrucks[i].distanceTraveled;
          najlepszyTrucker = listDueDrivers[i]['NameDriver'];
        }
      }

      /*  zrobilem w powyzszej petli to samo
      for (var i = 0; i < listDueDrivers.length; i++) {
        nalezne = nalezne + listDueDrivers[i]['DueDriver'];
      }
      */

      return {
        'Wolnych': wolnych,
        'W trasie': wTrasie,
        'Najlepszy': najlepszyTrucker,
        'Nalezne': nalezne,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final listDriverTuck = Provider.of<List<BaseTruckDriverData>>(context);
    listDriverTrucks = listDriverTuck;

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
