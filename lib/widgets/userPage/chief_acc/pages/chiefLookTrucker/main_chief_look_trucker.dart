import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/truckDriver.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/ColumnChiefLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/TextFieldCreateNewTrucker.dart';

class ChiefLookTrucker extends StatefulWidget {
  final List<TruckDriver> listDriversTrucks;

  ChiefLookTrucker({this.listDriversTrucks});

  @override
  _ChiefLookTruckerState createState() => _ChiefLookTruckerState();
}

class _ChiefLookTruckerState extends State<ChiefLookTrucker> {
  // Funkcja, pokazujaca Widget TextFieldCreateNewTrucker
  void showCreatorNewDriverTruck(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TextFieldCreateNewTrucker(addNewDriverTruck);
        });
  }

  // Dodaje nowego Kierowce w firmie
  void addNewDriverTruck(
      _namedriver, _salary, _dateOfEmplotment, _payday, _numberPhone) {
    final newdriver = TruckDriver(
        id: DateTime.now().toString(), // Tymczasowo
        nameDriver: _namedriver,
        salary: double.parse(_salary),
        earned: 0,
        paid: 0,
        distanceTraveled: 0,
        statusDriver: false,
        costDriver: 0,
        numberPhone: _numberPhone,
        dateOfEmplotment: _dateOfEmplotment,
        payday: _payday);

    setState(() {
      widget.listDriversTrucks.add(newdriver);
      print('Dodawanie DriverTruck 2/2');
    });
  }

  // Nalezne kierowcy kazdego z osobna
  List<Map<String, Object>> get listDueDrivers {
    return List.generate(
      widget.listDriversTrucks.length,
      (index) {
        int due = 0;
        due = widget.listDriversTrucks[index].earned -
            widget.listDriversTrucks[index].paid;
        return {
          'NameDriver': widget.listDriversTrucks[index].nameDriver,
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
      int przejechanekilomertynajkierowcy = 0;
      String najlepszyTrucker =
          ''; // Tymczasowo bedzie polegac na tym kto przejechal najwiecej kilometrow
      int nalezne = 0;

      // Petla ktora ustawia ile jest wolnych pracownikow, W Trasie
      for (var i = 0; i < widget.listDriversTrucks.length; i++) {
        if (widget.listDriversTrucks[i].statusDriver == false) {
          wolnych = wolnych + 1;
        } else if (widget.listDriversTrucks[i].statusDriver == true) {
          wTrasie = wTrasie + 1;
        }
        nalezne = nalezne + listDueDrivers[i]['DueDriver'];

        // na bazie danych chyba wystarczylo by uzyc Where Max
        if (widget.listDriversTrucks[i].distanceTraveled >
            przejechanekilomertynajkierowcy) {
          przejechanekilomertynajkierowcy =
              widget.listDriversTrucks[i].distanceTraveled;
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Kierowcy'),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showCreatorNewDriverTruck(context);
                print('Add new Trucker');
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
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
          ),
          Container(
            height: 250,
            child: ColumnChiefLookDriverTrucks(widget.listDriversTrucks),
          ),
        ],
      ),
    );
  }
}
