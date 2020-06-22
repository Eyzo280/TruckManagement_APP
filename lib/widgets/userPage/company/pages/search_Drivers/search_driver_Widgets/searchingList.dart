import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/search_driver_Widgets/detailsEmployee.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';

class SearchingList extends StatefulWidget {
  @override
  _SearchingListState createState() => _SearchingListState();
}

class _SearchingListState extends State<SearchingList> {
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

  _getEmployees() async {
    Query q = _firestore
        .collection('Drivers')
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
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];

    setState(() {
      _loadingEmployees = false;
    });
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

  // Wysylanie Zaproszenia

  void _sendInv(
      {@required CompanyData companyData,
      @required SearchDriverData driverData}) {
    if (companyData != null && driverData != null) {
      Database_Company(companyUid: companyData.uidCompany).sendInvite(
        companyData: companyData,
        driverData: driverData,
      );

      setState(() {
        sentInvitations.add(driverData.driverUid);
      });
      print('Wyslano Zaproszenie');
    } else {
      print('Problem z wyslaniem zaproszenia. Brak Uid firmy i pracownika.');
    }
  }

  @override
  void initState() {
    super.initState();
    _getEmployees();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreEmployees();
      }
    });
  }

  final Color colorContent = Colors.white;

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);

    return Flexible(
      fit: FlexFit.tight,
      flex: 9,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              print('Pokaz Szczegoly');
              // Zbiera informacje do kogo nie ma mozliwosci wyslania Zaproszenia
              if (sentInvitations.isEmpty) {
                await Firestore.instance
                    .collection('Companys')
                    .document(companyData.uidCompany)
                    .collection('DriverTrucks')
                    .where('dateOfEmplotment',
                        isLessThan:
                            null) // Sprawdzanie, czy uztkownik jest pracownikiem firmy, czy nie
                    .getDocuments()
                    .then((QuerySnapshot snapshot) {
                  for (var val in snapshot.documents) {
                    sentInvitations.add(val.documentID);
                  }
                  print(sentInvitations.length);
                });
                await Firestore.instance
                    .collection('Companys')
                    .document(companyData.uidCompany)
                    .collection('SentInvitations')
                    .getDocuments()
                    .then((QuerySnapshot snapshot) {
                  for (var val in snapshot.documents) {
                    if (!sentInvitations.contains(val.documentID)) {
                      sentInvitations.add(val.documentID);
                    }
                  }
                  print(sentInvitations.length);
                });
              }

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsDriver(
                  index: index,
                  driverData: _employees[index],
                  sentInvitations: sentInvitations,
                  sendInv: _sendInv,
                );
              }));
            },
            child: Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Card(
                child: ListTile(
                  leading: Hero(
                    tag: 'img_Employee' + index.toString(),
                    child: Image.asset('images/image-512.png'),
                  ),
                  title: Hero(
                    tag: 'name' + index.toString(),
                    flightShuttleBuilder: _flightShuttleBuilder,
                    child: Text(
                      '${_employees[index].firstName} ${_employees[index].lastName}',
                      style: TextStyle(color: colorContent),
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Text(
                        'Przejechane km: ',
                        style: TextStyle(color: colorContent),
                      ),
                      Hero(
                        tag: 'PrzejechaneKM' + index.toString(),
                        flightShuttleBuilder: _flightShuttleBuilder,
                        child: Text(
                          '${_employees[index].totalDistanceTraveled}',
                          style: TextStyle(
                              color: colorContent,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.insert_invitation,
                      color: colorContent,
                    ),
                    onPressed: () {
                      print('Wyslij Zaproszenie');
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
