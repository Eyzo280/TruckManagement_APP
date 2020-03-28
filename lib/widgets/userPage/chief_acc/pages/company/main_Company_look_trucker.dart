import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/ColumnCompanyLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/top_body_CompanyLookDriverTrucks.dart';

class MainCompanyLookTrucker extends StatefulWidget {
  final String companyUid;

  MainCompanyLookTrucker(this.companyUid);

  @override
  _CompanyLookTruckerState createState() => _CompanyLookTruckerState();
}

class _CompanyLookTruckerState extends State<MainCompanyLookTrucker> {
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
          TopBodyCompanyLookDriverTrucks(),
          Container(
            height: 250,
            child: ColumnCompanyLookDriverTrucks(widget.companyUid),
          ),
        ],
      ),
    
      )
      ;
  }
}
