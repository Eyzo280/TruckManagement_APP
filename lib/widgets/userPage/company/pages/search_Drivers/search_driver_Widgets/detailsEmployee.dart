import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';

class DetailsDriver extends StatefulWidget {
  final int index;
  final SearchDriverData driverData;
  final List sentInvitations;
  final Function sendInv;

  DetailsDriver({
    @required this.index,
    @required this.driverData,
    @required this.sentInvitations,
    @required this.sendInv,
  });

  @override
  _DetailsDriverState createState() => _DetailsDriverState();
}

class _DetailsDriverState extends State<DetailsDriver> {
  Widget topDetail({@required context, @required companyData}) {
    return Flexible(
      // Zdj imie, nazwisko itp.
      fit: FlexFit.tight,
      flex: 2,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).padding.vertical -
                      10) *
                  0.5,
              child: Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: 'img_Employee' + widget.index.toString(),
                  child: Image.asset('images/image-512.png'),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Imie: '),
                    Text(
                      widget.driverData.firstName,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Nazwisko: '),
                    Text(
                      widget.driverData.lastName,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.vertical -
                          10) *
                      0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Nr Tel: '),
                          Text(
                            widget.driverData.numberPhone.toString(),
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        onPressed: () => print('Zadzwon'),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.vertical -
                          10) *
                      0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Chat: '),
                      IconButton(
                          icon: Icon(
                            Icons.chat,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Chat(
                              mainUid: companyData.uidCompany,
                              peopleUid: widget.driverData.driverUid,
                            ).searchChat(context: context, peopleFirstName: widget.driverData.firstName, peopleLastName: widget.driverData.lastName);
                            print('Wlaczono Chat');
                          })
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget midDetail({@required context}) {
    return Flexible(
      // Szczegolowe informacje
      fit: FlexFit.tight,
      flex: 2,
      child: Container(
        width: double.infinity,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Przejechane Km: '),
                    Hero(
                      tag: 'PrzejechaneKM' + widget.index.toString(),
                      child: Text(
                        widget.driverData.totalDistanceTraveled.toString(),
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Text('Zarejsetrowany od: '),
                Text('Prawo jazdy od: '),
                Text('Kursy Wschod/Zachod'),
                Text('Pozwolenia: ADR'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomDetail({@required context}) {
    return Flexible(
      // Dodatkowe informacje, ktore wypisze pracownik
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        width: double.infinity,
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    color: Theme.of(context).textTheme.display3.color,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text('Dodatkowe Informacje'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Jestem Stefan, mam doswiadczenie, jezdzilem kilka lat do roznych zakatkow swiata.'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'name' + widget.index.toString(),
            child: Text(
                '${widget.driverData.firstName} ${widget.driverData.lastName}')),
        centerTitle: true,
        flexibleSpace: appBarLook(context: context),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.insert_invitation),
            onPressed:
                widget.sentInvitations.contains(widget.driverData.driverUid)
                    ? null
                    : () {
                        widget.sendInv(
                            companyData: companyData,
                            driverData: widget.driverData);
                      },
          ),
        ],
      ),
      body: Container(
        decoration: bodyLook(context: context),
        child: Column(
          children: <Widget>[
            topDetail(context: context, companyData: companyData),
            midDetail(context: context),
            bottomDetail(context: context),
          ],
        ),
      ),
    );
  }
}
