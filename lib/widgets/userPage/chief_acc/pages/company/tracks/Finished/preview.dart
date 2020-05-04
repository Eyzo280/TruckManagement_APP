import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';

class TracksFinished extends StatefulWidget {
  final companyData;

  TracksFinished({this.companyData});

  @override
  _TracksFinishedState createState() => _TracksFinishedState();
}

class _TracksFinishedState extends State<TracksFinished> {
  DateTime pickedDate;

  DateTime dayNow = DateTime.now();

  List<Track> trackData = [];

  bool loading;

  Future _getTrackData(DateTime date) async {
    try {
      final Timestamp viewDate = Timestamp.fromDate((date.add(Duration(
          hours: -date.hour,
          minutes: -date.minute,
          seconds: -date.second,
          microseconds: -date.microsecond,
          milliseconds: -date.millisecond))));

      var checkData;
      checkData = trackData.where((val) {
        // Sprawdzanie czy w liscie sa juz dane, aby zapobiec ponownemu wczytywaniu tych samych danych, moze byc tylko problem, gdy w momencie gdy beda juz dane w liscie i sie zmienia w bazie to ciagle beda wyswietlane stare dane.
        if (DateFormat('d-M-y').format(val.termin) ==
                DateFormat('d-M-y').format(pickedDate) &&
            Timestamp.fromDate(val.termin).seconds >= viewDate.seconds &&
            val.termin.second <= viewDate.seconds + (23 * 59 * 59)) {
          return true;
        } else {
          return false;
        }
      });
      print(checkData);
      if (checkData.isEmpty) {
        await Firestore.instance
            .collection('Companys')
            .document(widget.companyData.uidCompany)
            .collection(
                'Tracks') // V // W bazie danych zawsze musza byc 2 godz do przodu bo jest UTC+2, dlatego czasami nie pojawia sie dana z dnia, gdy np. jest przed 2 w nocy.
            .where('Termin',
                isGreaterThanOrEqualTo: viewDate,
                isLessThanOrEqualTo:
                    Timestamp(viewDate.seconds + (23 * 59 * 59), 0))
            .getDocuments()
            .then((val) async {
          for (var doc in val.documents) {
            trackData.add(Track(
              dodatkoweInfo: doc.data['DodatkoweInfo'] ?? null,
              fracht: doc.data['Fracht'] ?? null,
              from: doc.data['From'] ?? null,
              status: doc.data['Status'] ?? null,
              termin: DateTime.fromMillisecondsSinceEpoch(
                  doc.data['Termin'].seconds * 1000),
              to: doc.data['To'] ?? null,
              wspolrzedneDostawy: doc.data['WspolrzedneDostawy'] ?? null,
            ));
          }
          print('Znaleziono w indeksie 0: ' + trackData.length.toString());
          setState(() {
            loading = false;
          });
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Widget _selectDate({bool selected}) {
    return RaisedButton(
      onPressed: () {
        showDatePicker(
                context: context,
                initialDate: dayNow.add(Duration(
                    hours: -dayNow.hour,
                    minutes: -dayNow.minute,
                    seconds: -dayNow.second,
                    microseconds: -dayNow.microsecond,
                    milliseconds: -dayNow.millisecond)),
                firstDate: DateTime(2019),
                lastDate: dayNow)
            .then((pickdate) {
          if (pickdate == null) {
            return;
          }
          setState(() {
            loading = true;
            pickedDate = pickdate;

            _getTrackData(pickdate);
            print(pickdate);
          });
        });
      },
      child: Text(selected == false ? 'Prosze Wybrac date' : 'Zmien'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Zakonczone Kursy'),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.vertical,
            padding: EdgeInsets.all(5),
            child: pickedDate != null
                ? loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height) *
                                0.1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          pickedDate ==
                                                  dayNow.add(Duration(
                                                      hours: -dayNow.hour,
                                                      minutes: -dayNow.minute,
                                                      seconds: -dayNow.second,
                                                      microseconds:
                                                          -dayNow.microsecond,
                                                      milliseconds:
                                                          -dayNow.millisecond))
                                              ? 'Dzisiaj'
                                              : pickedDate ==
                                                      dayNow.add(Duration(
                                                          days: -1,
                                                          hours: -dayNow.hour,
                                                          minutes:
                                                              -dayNow.minute,
                                                          seconds:
                                                              -dayNow.second,
                                                          microseconds: -dayNow
                                                              .microsecond,
                                                          milliseconds: -dayNow
                                                              .millisecond))
                                                  ? 'Wczoraj'
                                                  : 'Data: ' +
                                                      DateFormat('d-M-y')
                                                          .format(pickedDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        _selectDate()
                                      ],
                                    ))),
                          ),
                          Flexible(
                            child: Container(
                              height: double.infinity,
                              child: ListView.builder(
                                itemCount: trackData.where((val) { // wybiera tylko te elementy, której data sie zgadza z wybraną.
                                  return DateFormat('d-M-y')
                                              .format(val.termin) ==
                                          DateFormat('d-M-y').format(pickedDate)
                                      ? true
                                      : false;
                                }).length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                appBar.preferredSize.height) *
                                            0.1,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      color: Colors.blue,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            'Rozpoczety Z: ${trackData[index].from}'),
                                        Text('Do: ${trackData[index].to}'),
                                        Text('Zakonczony przez: trzeba dodac')
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height) *
                                0.05,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.blue),
                          ),
                        ],
                      )
                : Center(child: _selectDate(selected: false)),
          )
        ],
      ),
    );
  }
}
