import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/ColumnChiefLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/top_body_ChiefLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services_ChiefEmployees/database_ChiefEmployees.dart';

class MainChiefLookTrucker extends StatefulWidget {

  @override
  _ChiefLookTruckerState createState() => _ChiefLookTruckerState();
}

class _ChiefLookTruckerState extends State<MainChiefLookTrucker> {
/*
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
      _firstNameDriver, _lastNameDriver, _salary, _dateOfEmplotment, _payday, _numberPhone) {
    final newdriver = TruckDriver(
        id: DateTime.now().toString(), // Tymczasowo
        firstNameDriver: _firstNameDriver,
        lastNameDriver: _lastNameDriver,
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



*/
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
  
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
                //showCreatorNewDriverTruck(context);
                print('Add new Trucker');
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TopBodyChiefLookDriverTrucks(),
          Container(
            height: 250,
            child: ColumnChiefLookDriverTrucks(),
          ),
        ],
      ),
    
      )
      ;
  }
}
