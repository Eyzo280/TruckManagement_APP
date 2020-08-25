import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/invites/invitesFullData.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';

class Invitations extends StatefulWidget {
  static const routeName = '/Invitations';

  final companyUid;

  Invitations({this.companyUid});

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<InvData> _invites = [];

  bool _loadingInvites = true;

  int _per_page = 8;

  DocumentSnapshot _lastDocument;

  ScrollController _scrollController = ScrollController();

  bool _gettingMoreInvites = false;

  bool _moreInvitesAbailable = true;

  _getEmployees() async {
    Query q = _firestore
        .collection('Companys')
        .doc(widget.companyUid)
        .collection('Invitations')
        .limit(_per_page);

    setState(() {
      _loadingInvites = true;
    });
    QuerySnapshot querySnapshot = await q.get();
    _invites = querySnapshot.docs.map((doc) {
      return InvData(
        invUid: doc.id,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['dateSentInv'].seconds * 1000) ??
            null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['dateOfEmplotment'].seconds * 1000) ??
            null,
        drivingLicense: doc.data()['drivingLicense'] ?? null,
        drivingLicenseFrom: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['drivingLicenseFrom'].seconds * 1000) ??
            null,
        firstName: doc.data()['firstName'] ?? null,
        knownLanguages: doc.data()['knownLanguages'] ?? null,
        lastName: doc.data()['lastName'] ?? null,
        numberPhone: doc.data()['numberPhone'] ?? null,
        totalDistanceTraveled: doc.data()['totalDistanceTraveled'] ?? null,
        type: doc.data()['type'] ?? null,
      );
    }).toList();
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loadingInvites = false;
    });
  }

  _getMoreEmployees() async {
    print("_getMoreEmployees called");

    if (_moreInvitesAbailable == false) {
      print("No More Employees");
      return;
    }

    if (_gettingMoreInvites == true) {
      return;
    }

    _gettingMoreInvites = true;

    Query q = _firestore
        .collection('Companys')
        .doc(widget.companyUid)
        .collection('Invitations')
        .startAfter([_lastDocument.data()['totalDistanceTraveled']]).limit(
            _per_page);

    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _per_page) {
      _moreInvitesAbailable = false;
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    _invites.addAll(querySnapshot.docs.map((doc) {
      return InvData(
        invUid: doc.id,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['dateSentInv'].seconds * 1000) ??
            null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['dateOfEmplotment'].seconds * 1000) ??
            null,
        drivingLicense: doc.data()['drivingLicense'] ?? null,
        drivingLicenseFrom: DateTime.fromMillisecondsSinceEpoch(
                doc.data()['drivingLicenseFrom'].seconds * 1000) ??
            null,
        firstName: doc.data()['firstName'] ?? null,
        knownLanguages: doc.data()['knownLanguages'] ?? null,
        lastName: doc.data()['lastName'] ?? null,
        numberPhone: doc.data()['numberPhone'] ?? null,
        totalDistanceTraveled: doc.data()['totalDistanceTraveled'] ?? null,
        type: doc.data()['type'] ?? null,
      );
    }).toList());

    setState(() {});

    _gettingMoreInvites = false;
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

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Zaproszenia'),
      centerTitle: true,
      flexibleSpace: appBarLook(context: context),
    );
    return _invites == null
        ? Loading()
        : Scaffold(
            appBar: appBar,
            body: Container(
              decoration: bodyLook(context: context),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: _invites.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return InvitesFullData(_invites[index]);
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.01),
                        child: Card(
                          child: ListTile(
                            leading: Hero(
                              tag: 'img_Employee' + index.toString(),
                              child: Image.asset('images/image-512.png'),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${_invites[index].firstName} ${_invites[index].lastName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Przejechane km: ',
                                        ),
                                        Hero(
                                          tag: 'PrzejechaneKM' +
                                              index.toString(),
                                          flightShuttleBuilder:
                                              flightShuttleBuilder,
                                          child: Text(
                                            _invites[index].totalDistanceTraveled.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Konto od: '
                                        ),
                                        Text(
                                          (DateTime.now().year - _invites[index].dateOfEmplotment.year).toString() + ' lat',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Glowne trasy - ',
                                        ),
                                        Image.asset(
                                          'icons/flags/png/nl.png',
                                          package: 'country_icons',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
  }
}
