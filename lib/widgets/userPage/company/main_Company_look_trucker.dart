import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/ColumnCompanyLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_employees/search_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/top_body_CompanyLookDriverTrucks.dart';

class MainCompanyLookTrucker extends StatefulWidget {
  static const routeName = '/MainCompanyLookTrucker';

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
      _firstName, _lastName, _salary, _dateOfEmplotment, _payday, _numberPhone) {
    final newdriver = TruckDriver(
        id: DateTime.now().toString(), // Tymczasowo
        firstName: _firstName,
        lastName: _lastName,
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

  void _openSearchEmployees(BuildContext ctx, CompanyData companyData) {
    Navigator.of(context).pushNamed(SearchEmployees.routeName, arguments: {
      'companyData': companyData,
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, CompanyData>;
    
    final CompanyData companyData = routeArgs['companyData'];

    final appBar = AppBar(
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
                _openSearchEmployees(context, companyData);
                print('Add new Trucker');
              },
            ),
          ),
        ],
      );
      return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.17,
            child: TopBodyCompanyLookDriverTrucks(),),
          
          Container(
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.83,
            child: ColumnCompanyLookDriverTrucks(companyData.uidCompany),
          ),
        ],
      ),
    
      )
      ;
  }
}
