import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class TracksActive extends StatelessWidget {
  static const routeName = '/TracksActive';

  final String companyUid;

  TracksActive({@required this.companyUid});

  Future getActiveTracks() async {
    final tracks = await Firestore.instance
        .collection('Companys')
        .document(companyUid)
        .collection('Tracks')
        .where('Status', isEqualTo: true)
        .getDocuments();
    print(tracks.documents);
  }

  @override
  Widget build(BuildContext context) {
    //
    void keyboardOff() {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    //
    AppBar appBar = AppBar(
      title: Text('Aktywne'),
      centerTitle: true,
    );

    Widget SearchCard() {
      return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          height: (MediaQuery.of(context).size.height * 0.2) -
              appBar.preferredSize.height,
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Szukaj'),
                      //controller: ,
                    ),
                  )),
              Flexible(
                child: Container(
                  color: Colors.blue,
                  child: FlatButton(
                    onPressed: () {
                      print('Szukaj');
                      keyboardOff();
                    },
                    child: Text('Szukaj'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget ListTracks() {
      return Card(
        elevation: 5,
        child: Container(
            height: (MediaQuery.of(context).size.height * 0.8) -
                appBar.preferredSize.height,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child:
                /*ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.03),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text('Warszawa - Krakow'),
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
                          child: ListTile(
                              leading: Icon(
                                Icons.image,
                                size: MediaQuery.of(context).size.width * 0.1,
                              ),
                              onTap: () {
                                print('Pokaz Active Track ${index}');
                                keyboardOff();
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Stawka: '),
                                  Text('Termin: '),
                                  Text('Zleceniodawca: '),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
                
              }),
              */
                StreamBuilder<List<Track>>(
              stream: Database_CompanyEmployees(companyUid: companyUid)
                  .streamActiveTracks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data[0].fracht);
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.03),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Container(
                                            color: Colors.blue,
                                            child: Center(
                                              child: Text('${snapshot.data[index].from} - ${snapshot.data[index].to}'),
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
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.image,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      onTap: () {
                                        print('Pokaz Active Track ${index}');
                                        keyboardOff();
                                      },
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Stawka: ${snapshot.data[index].fracht}'),
                                          Text('Termin: ${snapshot.data[index].termin.toString()}'),
                                          Text('Zleceniodawca: '),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchCard(),
            ListTracks(),
          ],
        ),
      ),
    );
  }
}
