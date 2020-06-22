/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';

class SearchEmployees extends StatefulWidget {
  static const routeName = '/SearchEmployees';

  @override
  _SearchEmployeesState createState() => _SearchEmployeesState();
}

class _SearchEmployeesState extends State<SearchEmployees> {
  Firestore _firestore = Firestore.instance;
  List<SearchDriverData> _employees = [];
  bool _loadingEmployees = true;
  int _per_page = 8;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreEmployees = false;
  bool _moreEmployeesAbailable = true;
  List sentInvitations = [];
  bool statusSentInvitations = false;

  _getEmployees({@required CompanyData companyData}) async {
    await _firestore
        .collection('Companys')
        .document(companyData.uidCompany)
        .collection('SentInvitations')
        .getDocuments()
        .then((snap) {
      for (var i in snap.documents) {
        sentInvitations.add(i.documentID);
      }
      statusSentInvitations = true;
    });
    if (statusSentInvitations = true) {
      Query q = _firestore
          .collection('Drivers')
          .where('totalDistanceTraveled',
              isGreaterThanOrEqualTo:
                  kmOd.value.text != '' ? int.parse(kmOd.value.text) : 0)
          .where('totalDistanceTraveled',
              isLessThanOrEqualTo: kmDo.value.text != ''
                  ? int.parse(kmDo.value.text)
                  : 999999999)
          .orderBy('totalDistanceTraveled')
          .limit(_per_page);

      setState(() {
        _loadingEmployees = true;
      });
      QuerySnapshot querySnapshot = await q.getDocuments();
      _employees = querySnapshot.documents.map((doc) {
        return SearchDriverData(
          driverUid: doc.documentID ?? null,
          dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
                  doc.data['dateOfEmplotment'].seconds * 1000) ??
              null,
          drivingLicense: doc.data['drivingLicense'] ?? null,
          drivingLicenseFrom: DateTime.fromMillisecondsSinceEpoch(
                  doc.data['drivingLicenseFrom'].seconds * 1000) ??
              null,
          firstName: doc.data['firstName'] ?? null,
          knownLanguages: doc.data['knownLanguages'] ?? null,
          lastName: doc.data['lastName'] ?? null,
          numberPhone: doc.data['numberPhone'] ?? null,
          totalDistanceTraveled: doc.data['totalDistanceTraveled'] ?? null,
          type: doc.data['type'] ?? null,
        );
      }).toList();
      _lastDocument =
          querySnapshot.documents[querySnapshot.documents.length - 1];

      setState(() {
        _loadingEmployees = false;
      });
    } else
      print('Problem z odczytem "SentInvitations" Firmy');
  }

  _getMoreEmployees() async {
    print("_getMoreEmployees called");

    if (_moreEmployeesAbailable == false) {
      print("No More Employees");
      return;
    }

    if (_gettingMoreEmployees == true) {
      return;
    }

    _gettingMoreEmployees = true;

    Query q = _firestore
        .collection('Drivers')
        .where('totalDistanceTraveled',
            isGreaterThanOrEqualTo:
                kmOd.value.text != '' ? int.parse(kmOd.value.text) : 0)
        .where('totalDistanceTraveled',
            isLessThanOrEqualTo:
                kmDo.value.text != '' ? int.parse(kmDo.value.text) : 999999999)
        .orderBy('totalDistanceTraveled')
        .startAfter([_lastDocument.data['totalDistanceTraveled']]).limit(
            _per_page);

    QuerySnapshot querySnapshot = await q.getDocuments();

    if (querySnapshot.documents.length < _per_page) {
      _moreEmployeesAbailable = false;
    }

    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];

    _employees.addAll(querySnapshot.documents.map((doc) {
      return SearchDriverData(
        driverUid: doc.documentID ?? null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
                doc.data['dateOfEmplotment'].seconds * 1000) ??
            null,
        drivingLicense: doc.data['drivingLicense'] ?? null,
        drivingLicenseFrom: DateTime.fromMillisecondsSinceEpoch(
                doc.data['drivingLicenseFrom'].seconds * 1000) ??
            null,
        firstName: doc.data['firstName'] ?? null,
        knownLanguages: doc.data['knownLanguages'] ?? null,
        lastName: doc.data['lastName'] ?? null,
        numberPhone: doc.data['numberPhone'] ?? null,
        totalDistanceTraveled: doc.data['totalDistanceTraveled'] ?? null,
        type: doc.data['type'] ?? null,
      );
    }).toList());

    setState(() {});

    _gettingMoreEmployees = false;
  }

  @override
  void initState() {
    super.initState();
    // _getEmployees();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreEmployees();
      }
    });
  }

  final _formkey = GlobalKey<FormState>();
  bool filtrActive = false;

  String dropdownValue = 'Wybierz';
  final kmOd = TextEditingController();
  final kmDo = TextEditingController();

  Widget Filter({@required CompanyData companyData}) {
    return Form(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              'Filtr',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Przejechane km'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: TextFormField(
                        key: _formkey,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Od'),
                        keyboardType: TextInputType.number,
                        controller: kmOd,
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Do'),
                        keyboardType: TextInputType.number,
                        controller: kmDo,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _moreEmployeesAbailable = true;
                  _gettingMoreEmployees = false;
                  _getEmployees(companyData: companyData);
                  Navigator.of(context).pop();
                });
              },
              child: Text('Zastosuj'),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilter({@required BuildContext ctx, @required CompanyData companyData}) {
    Future<void> future = showModalBottomSheet<void>(
        context: ctx,
        builder: (_) {
          return Filter(companyData: companyData);
        });
    future.then((void value) {
      setState(() {});
    });
  }

  void _openFullDataEmployee(ctx, sendInv, driverData, companyData) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
      return FullDataEmployee(sendInv, driverData, companyData);
    }));
  }

  // Wysylanie Zaproszenia

  void _sendInv(
      {companyData,
      employeesData
      }) {
    if (companyData != null && employeesData != null) {
      Database_Company(companyUid: companyData.uidCompany)
          .sendInvite(
        companyData: companyData,
        employeesData: employeesData,
      );
      sentInvitations.add(employeesData.driverUid);
      setState(() {});
      print('Wyslano Zaproszenie');
    } else {
      print('Problem z wyslaniem zaproszenia. Brak Uid firmy i pracownika.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, CompanyData>;

    final CompanyData companyData = routeArgs['companyData'];
    // final SearchDriverData = Provider.of<List<SearchDriverData>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wyszukiwarka Firmy',
            style: TextStyle(
              color: Theme.of(context).canvasColor,
            )),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: null, // standardowa
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    if (dropdownValue != 'Wybierz') {
                      _getEmployees(companyData: companyData);
                    }
                  });
                },
                items: <String>['Wybierz', 'Driver', 'Spedytorzy']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              dropdownValue != 'Wybierz'
                  ? IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        _openFilter(ctx: context, companyData: companyData);
                        print('Pokaz Filtr');
                      })
                  : SizedBox()
            ],
          )
        ],
      ),
      body: dropdownValue == 'Wybierz' && filtrActive == false
          ? Center(child: Text('Prosze wybrac typ wyszukiwania'))
          : _employees.length == 0
              ? Loading()
              :
              // Trzeba dodac spedytorow

              ListView.builder(
                  controller: _scrollController,
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(20)),
                                  child: Container(
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text('Nazwa'),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Opacity(opacity: 0.0),
                              ),
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )),
                            margin: EdgeInsets.only(top: 0),
                            elevation: 5,
                            color: Colors.red,
                            child: ListTile(
                              leading: Icon(Icons.add_a_photo),
                              title: Container(
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text('Przejechane km:'),
                                        Text(_employees[index]
                                            .totalDistanceTraveled
                                            .toString()),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('Znaj j.Obcych:'),
                                        Text(_employees[index].knownLanguages !=
                                                ''
                                            ? _employees[index].knownLanguages
                                            : ''),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            'Kursy:'), // do jakich krajow sa kursy
                                        Text('PL, DE'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: FittedBox(
                                  child: Column(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.open_in_new),
                                      onPressed: () {
                                        _openFullDataEmployee(
                                            context,
                                            sentInvitations.any((test) {
                                              return test ==
                                                  _employees[index].driverUid;
                                            })
                                                ? null
                                                : _sendInv,
                                            _employees[index],
                                            companyData);
                                        print('Pokaz szczegoly');
                                      }),
                                  IconButton(
                                      icon: sentInvitations.any((test) {
                                        return test ==
                                            _employees[index].driverUid;
                                      })
                                          ? Icon(Icons.check_box)
                                          : Icon(Icons.add_box),
                                      color: sentInvitations.any((test) {
                                        return test ==
                                            _employees[index].driverUid;
                                      })
                                          ? Colors.grey
                                          : Colors.green,
                                      onPressed: sentInvitations.any((test) {
                                        return test ==
                                            _employees[index].driverUid;
                                      })
                                          ? null
                                          : () {
                                              _sendInv(
                                                  companyData: companyData,
                                                  employeesData: _employees[index]);
                                            }),
                                ],
                              )),
                            ),
                          ),
                          index == _employees.length - 1 &&
                                  _gettingMoreEmployees == true
                              ? Text('Ladowanie')
                              : SizedBox(),
                        ],
                      ),
                    );
                  },
                ),

      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('data'),),
      */
    );
  }
}
*/