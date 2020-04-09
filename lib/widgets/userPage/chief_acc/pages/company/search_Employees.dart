import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class SearchEmployees extends StatefulWidget {
  @override
  _SearchEmployeesState createState() => _SearchEmployeesState();
}

class _SearchEmployeesState extends State<SearchEmployees> {
  final _formkey = GlobalKey<FormState>();
  bool filtrActive = false;

  String dropdownValue = 'Wybierz';
  final kmOd = TextEditingController();
  final kmDo = TextEditingController();

  List listFiltr = [{}];

  Widget Filter() {
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
                          controller: kmDo,),
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {setState(() {
                
              });},
              child: Text('Zastosuj'),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilter(BuildContext ctx) {
    Future<void> future = showModalBottomSheet<void>(
      
        context: ctx,
        builder: (_) {
          return Filter();
        });
      future.then((void value) {
        setState(() {
          
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    // final searchEmployeesBaseData = Provider.of<List<SearchEmployeesBaseData>>(context);
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
                        _openFilter(context);
                        print('Pokaz Filtr');
                      })
                  : SizedBox()
            ],
          )
        ],
      ),
      body: dropdownValue == 'Wybierz' && filtrActive == false
          ? Center(child: Text('Prosze wybrac typ wyszukiwania'))
          : StreamBuilder<List<SearchEmployeesBaseData>>(
              stream: Database_CompanyEmployees(searchSettings: [
                {
                  'typeEmployees': dropdownValue,
                  'kmOd':
                      kmOd.value.text == '' ? 0 : int.parse(kmOd.value.text),
                  'kmDo': kmDo.value.text == '' ? 999999999 : int.parse(kmDo.value.text),
                }
              ]).getSearchEmployeesBaseData,
              builder: (context, AsyncSnapshot snapshot) {
                // Trzeba dodac spedytorow
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text('Przejechane km:'),
                                          Text(snapshot
                                              .data[index].totalDistanceTraveled
                                              .toString()),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('Znaj j.Obcych:'),
                                          Text(snapshot.data[index]
                                                      .knownLanguages !=
                                                  ''
                                              ? snapshot
                                                  .data[index].knownLanguages
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
                                          print('Pokaz szczegoly');
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.add_box),
                                        onPressed: () {
                                          print('Wyslij Zaproszenie');
                                        }),
                                  ],
                                )),
                              ),
                            ),
                            snapshot.data.length - 1 == index
                                ? Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: MaterialButton(
                                      onPressed: () {
                                        print('Wiecej');
                                      },
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 24,
                                      ),
                                      padding: EdgeInsets.all(16),
                                      shape: CircleBorder(),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    },
                  );
                } else
                  return Loading();
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
