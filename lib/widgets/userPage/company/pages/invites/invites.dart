import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/invites/invitesFullData.dart';

class Invitations extends StatefulWidget {
  static const routeName = '/Invitations';

  final companyUid;

  Invitations({this.companyUid});

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  Firestore _firestore = Firestore.instance;

  List<InvData> _invites = [];

  bool _loadingInvites = true;

  int _per_page = 8;

  DocumentSnapshot _lastDocument;

  ScrollController _scrollController = ScrollController();

  bool _gettingMoreInvites = false;

  bool _moreInvitesAbailable = true;

  _getEmployees() async {   
      Query q = _firestore.collection('Companys')
          .document(widget.companyUid)
        .collection('Invitations')
          .limit(_per_page);

      setState(() {
        _loadingInvites = true;
      });
      QuerySnapshot querySnapshot = await q.getDocuments();
      _invites = querySnapshot.documents.map((doc) {
        return InvData(
        invUid: doc.documentID,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
                doc.data['dateSentInv'].seconds * 1000) ??
            null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
              doc.data['dateOfEmplotment'].seconds * 1000) ?? null,
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

    Query q = _firestore.collection('Companys')
          .document(widget.companyUid)
        .collection('Invitations')
        .startAfter([_lastDocument.data['totalDistanceTraveled']]).limit(
            _per_page);

    QuerySnapshot querySnapshot = await q.getDocuments();

    if (querySnapshot.documents.length < _per_page) {
      _moreInvitesAbailable = false;
    }

    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];

    _invites.addAll(querySnapshot.documents.map((doc) {
      return InvData(
        invUid: doc.documentID,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
                doc.data['dateSentInv'].seconds * 1000) ??
            null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
              doc.data['dateOfEmplotment'].seconds * 1000) ?? null,
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

  void _openInvitesFullData(ctx, companyUid, inviteData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return InvitesFullData(companyUid, inviteData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Zaproszenia'),
      centerTitle: true,
    );
    return _invites == null ? Loading() : Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: _invites.length,
        itemBuilder: (context, index) {
        return Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text('nazwa'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
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
                      color: Colors.grey,
                      child: ListTile(
                        leading: Icon(Icons.add_a_photo),
                        title: Container(
                          color: Colors.blueGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('Salary:'),
                                  Text('dsadsa'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Znaj j.Obcych:'),
                                  Text('Nie'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Kursy:'), // do jakich krajow sa kursy
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
                                  _openInvitesFullData(context, widget.companyUid, _invites[index]);
                                  print('Pokaz szczegoly');
                                }),
                            FlatButton(
                                onPressed: () {
                                  Database_CompanyEmployees(companyUid: widget.companyUid).acceptInv(driverUid: _invites[index].invUid, firstName: _invites[index].firstName, lastName: _invites[index].lastName, numberPhone: _invites[index].numberPhone);
                                  print('Akceptuj');
                                },
                                child: Text('Akceptuj'))
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
