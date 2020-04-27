import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/ColumnCompanyLookDriverTrucks.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/search_employees/search_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/top_body_CompanyLookDriverTrucks.dart';

class MainCompanyLookTrucker extends StatefulWidget {
  var companyData;

  MainCompanyLookTrucker(this.companyData);

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

  void _openSearchEmployees(BuildContext ctx, companyData) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return
          /* StreamProvider<List<SearchEmployeesBaseData>>.value(
            value:
                Database_CompanyEmployees().getSearchEmployeesBaseData,
            child: SearchEmployees());
            */
          SearchEmployees(companyData: companyData);
    }));
  }
  

  @override
  Widget build(BuildContext context) {
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
                _openSearchEmployees(context, widget.companyData);
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
            child: ColumnCompanyLookDriverTrucks(widget.companyData.uidCompany),
          ),
        ],
      ),
    
      )
      ;
  }
}
