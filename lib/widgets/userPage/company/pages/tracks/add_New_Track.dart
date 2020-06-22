import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/company/services/database_company.dart';


class AddNewTrack extends StatefulWidget {
  final companyData;

  AddNewTrack({this.companyData});

  @override
  _AddNewTrackState createState() => _AddNewTrackState();
}

class _AddNewTrackState extends State<AddNewTrack> {
  final _formkey = GlobalKey<FormState>();
  bool _formComplete = true;

  int _currentStep = 0;
  bool _complete = false;
  bool loading = false;
  bool error = false;

  ///////////////////////////
  // Dane Firmy
  TextEditingController dodatkoweInfo = TextEditingController();
  TextEditingController fracht = TextEditingController();
  TextEditingController from = TextEditingController();
//  TextEditingController termin = TextEditingController(); // chyba lepszy bedzie wybor z kalendarza
  DateTime termin;
  TextEditingController to = TextEditingController();
  TextEditingController dlugoscGeo = TextEditingController();
  TextEditingController szerokoscGeo = TextEditingController();

  ////////////////////////////////////////////////////////////////////// Trzeba bedzie zrobic funkcje z roznymi pakietami firm
  String _dropdownDriver = '';

  void newPakietComapny(String newValue) {
    setState(() {
      _dropdownDriver = newValue;
      print(newValue);
    });
  }

  // Trzeba przerobic
  List<DropdownMenuItem<String>> dropDownValues = <String>[
    // Dodawane są dane w funkcji initState, czyli przy tworzeniu widgetu
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  _next() async {
    FocusScope.of(context)
        .unfocus(); // wylaczenie klawiatury po nacisnieciu przycisku dalej
    if (_currentStep == 0) {
      if (_formkey.currentState.validate()) {
        _goTo(_currentStep + 1);
      }
    } else if (_currentStep == 1) {
      if (_formkey.currentState.validate()) {
        _goTo(_currentStep + 1);
      }
    } else if (_currentStep == 2) {
      setState(() {
        loading = true;
      });
      await Database_Company(companyUid: widget.companyData.uidCompany)
          .addNewTrack(
              dodatkoweInfo: dodatkoweInfo.value.text,
              fracht: int.parse(fracht.value.text),
              from: from.value.text,
              termin: DateTime.now(),
              to: to.value.text,
              wspolrzedneDostawy: GeoPoint(double.parse(dlugoscGeo.value.text),
                  double.parse(szerokoscGeo.value.text)),
              driver: _dropdownDriver)
          .whenComplete(() {
        setState(() {
          loading = false;
          error = false;
          _complete = true;
        });
      });
    }
  }

  _cancel() {
    FocusScope.of(context).unfocus();
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  _goTo(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  //////////////////////////////////////////////////////////////////////

  List<Step> _getSteps() {
    var steps = [
      Step(
          title: const Text(
              'Dane kursu'), // czyli np. mini-Company, medium-company, high-company, roznica bedzie polegala na tym ilu pracownikow mozna zatrudnic
          isActive: _currentStep > 0,
          state: _currentStep > 0 ? StepState.complete : StepState.editing,
          content: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adres Odbioru'),
                      controller: from,
                      validator: (val) => val.isEmpty
                          ? 'Prosze podac gdzie zaczyna sie kurs.'
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adres Dostarczenia'),
                      controller: to,
                      validator: (val) => val.isEmpty
                          ? 'Prosze podac gdzie konczy sie kurs.'
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Fracht'),
                      controller: fracht,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val.isEmpty ? 'Prosze podac fracht za kurs.' : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Wspolrzedne Dostawy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Dlugosc Geograficzna'),
                      controller: dlugoscGeo,
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty
                          ? 'Prosze podac dlugosc geograficzna.'
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Szerokosc Geograficzna'),
                      controller: szerokoscGeo,
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty
                          ? 'Prosze podac szerokosc geograficzna.'
                          : null,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        'Wybrana data: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text((termin == null ? '' : termin.toString())),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime.now().add(Duration(days: 180)))
                          .then((pickdate) {
                        if (pickdate == null) {
                          return;
                        }
                        setState(() {
                          termin = pickdate;
                        });
                      });
                    },
                    icon: const Icon(Icons.date_range),
                  )
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Dodatkowe Info'),
                controller: dodatkoweInfo,
              ),
              // Dodatkowe Info
            ],
          )),
      Step(
        isActive: _currentStep > 1,
        state: _currentStep > 1
            ? StepState.complete
            : _currentStep < 1 ? StepState.disabled : StepState.editing,
        title: const Text('Dane Kierowcy'),
        content: Row(
          children: <Widget>[
            const Text('Wybierz Kierowce: '),
            DropdownButton<String>(
              value: _dropdownDriver,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.green,
              ),
              onChanged: (String newValue) {
                newPakietComapny(newValue);
              },
              items: dropDownValues,
            ),
          ],
        ),
      ),
      Step(
        state: _currentStep == 2 ? StepState.complete : StepState.disabled,
        title: const Text('Podsumowanie'),
        content: Column(
          children: <Widget>[
            const Text(
              'Podsumowanie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Kierowca: ${_dropdownDriver}'),
                          Text('From: ${from.value.text}'),
                          Text('To: ${to.value.text}'),
                          Text('Fracht: ${fracht.value.text}'),
                          Text('Termin: ${termin.toString()}'),
                          Text(
                              'Wspolrzedne Dostawy: ${dlugoscGeo.value.text}, ${szerokoscGeo.value.text}'),
                          // dodatkoweInfo.value.text.isNotEmpty ?? Text('Dodatkowe Info: ${dodatkoweInfo.value.text}'),
                          dodatkoweInfo.value.text != ''
                              ? Text(
                                  'Dodatkowe Info: ${dodatkoweInfo.value.text}')
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
    return steps;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Firestore.instance
        .collection('Companys')
        .document(widget.companyData.uidCompany)
        .collection('DriverTrucks')
        .where('statusDriver', isEqualTo: true)
        .getDocuments()
        .then((val) {
      for (var doc in val.documents) {
        dropDownValues.add(
          DropdownMenuItem(
            child: Text(
              doc.data['firstName'],
              style: TextStyle(color: Color(0xff11b719)),
            ),
            value: doc.data['firstName'],
          ),
        );
      }
      _dropdownDriver = val.documents[0].data['firstName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: _complete
                  ? const Text('Dodano Nowy Kurs')
                  : const Text('Nowy Kurs'),
              centerTitle: true,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(children: <Widget>[
                error
                    ? ErrorPage()
                    : _complete
                        ? Expanded(
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Text('Nowy Kurs'),
                                    Container(
                                      height: 350,
                                      width: double.infinity,
                                      child: Card(
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('From : ${from.value.text}'),
                                              Text('To: ${to.value.text}'),
                                              Text(
                                                  'Fracht: ${fracht.value.text}'),
                                              Text(
                                                  'Termin: ${termin.toString()}'),
                                              Text(
                                                  'Wspolrzedne Dostawy: ${dlugoscGeo.value.text}, ${szerokoscGeo.value.text}'),
                                              Text(
                                                  'Kierowca: ${_dropdownDriver}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Stepper(
                              steps: _getSteps(),
                              onStepCancel: _cancel,
                              currentStep: _currentStep,
                              onStepContinue: _next,
                              controlsBuilder: (BuildContext context,
                                  {VoidCallback onStepContinue,
                                  VoidCallback onStepCancel}) {
                                return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.blue,
                                        onPressed: _formComplete == true &&
                                                    _currentStep == 1 ||
                                                _currentStep != 1
                                            ? onStepContinue
                                            : null,
                                        child: const Text('Dalej'),
                                      ),
                                      _currentStep > 0
                                          ? FlatButton(
                                              color: Colors.grey,
                                              onPressed: onStepCancel,
                                              child: const Text('Powrot'),
                                            )
                                          : const SizedBox(),
                                    ]);
                              },
                            ),
                          )
              ]),
            ));
  }
}
