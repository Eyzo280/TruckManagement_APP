import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chief/create_company.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_chief.dart';

class PreviewCompany extends StatelessWidget {
  final String chiefUid;

  PreviewCompany({this.chiefUid});

  void openCreateCompany(BuildContext ctx, chiefUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
      return CreateCompany(chiefUid: chiefUid);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final companysBaseData = Provider.of<List<BaseCompanyData>>(context);
    return companysBaseData == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Podglad Firm'),
              ),
            ),
            body: ListView.builder(
              itemCount: companysBaseData.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
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
                                              topRight: Radius.circular(20)),
                                          child: Container(
                                              padding: EdgeInsets.all(2),
                                              alignment: Alignment.centerLeft,
                                              color: Colors.blue,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.radio_button_checked,
                                                    size: 20,
                                                    color:
                                                        companysBaseData[index]
                                                                    .status ==
                                                                true
                                                            ? Colors.green
                                                            : Colors.red,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Text(companysBaseData[
                                                                    index]
                                                                .nameCompany ==
                                                            null
                                                        ? 'Brak Danych'
                                                        : companysBaseData[
                                                                index]
                                                            .nameCompany),
                                                  ),
                                                ],
                                              )),
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
                                    leading: Icon(Icons.add_photo_alternate),
                                    title: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Dochod: functions w firestore',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              Text(companysBaseData[index]
                                                          .employees ==
                                                      null
                                                  ? 'Brak Danych'
                                                  : 'Ilosc Pracownikow: ${companysBaseData[index].employees}'),
                                              Text(companysBaseData[index]
                                                          .topEmployees ==
                                                      null
                                                  ? 'Brak Danych'
                                                  : 'Najnowszy pracownik: ${companysBaseData[index].topEmployees}'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: FittedBox(
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                              iconSize: 60,
                                              icon: Icon(Icons.open_in_new),
                                              onPressed: () {
                                                print('otworz okno firmy');
                                              }),
                                          IconButton(
                                              iconSize: 60,
                                              icon: Icon(Icons.pan_tool),
                                              color: companysBaseData[index]
                                                          .status ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.green,
                                              onPressed: () {
                                                DataBase_Chief(uid: companysBaseData[index].idCompany).changeActiveCompany(chiefUid: chiefUid, active: companysBaseData[index].status);
                                                print('Wylacz lub wlacz firme');
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: companysBaseData.length < 5 // dodac ile firm mozna zrobic maksymalnie
                  ? Colors.blue : Colors.grey,
              splashColor: Colors.green,
              child: Icon(Icons.add),
              onPressed: companysBaseData.length < 5 // dodac ile firm mozna zrobic maksymalnie
                  ? () {
                      openCreateCompany(context, chiefUid);
                      print('Dodaj Nowa firme');
                    }
                  : null,
            ),
          );
  }
}
