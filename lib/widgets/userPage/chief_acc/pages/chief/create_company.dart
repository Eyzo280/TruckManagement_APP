import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_chief.dart';

class CreateCompany extends StatefulWidget {
  final String chiefUid;

  CreateCompany({this.chiefUid});

  @override
  _CreateCompanyState createState() => new _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final _formkey = GlobalKey<FormState>();
  bool _formComplete = true;

  int _currentStep = 0;
  bool _complete = false;
  bool loading = false;
  bool error = false;

  _next() async {
    if (_currentStep == 0) {
      _goTo(_currentStep + 1);
    } else if (_currentStep == 1) {
      if (_formkey.currentState.validate()) {
        _goTo(_currentStep + 1);
      }
    } else if (_currentStep == 2) {
      setState(() {
        loading = true;
      });
      dynamic result = await DataBase_Chief(uid: widget.chiefUid)
          .addedNewCompany(
              nameCompany: nameCompany.value.text,
              phoneNumber: phoneNumber.value.text,
              advertisement: _advertisement,
              active: _active,
              pakiet: _dropdownValue,
              yearEstablishmentCompany: yearEstablishmentCompany);
      if (result == null) {
        setState(() {
          loading = false;
          error = true;
        });
      } else {
        setState(() {
          loading = false;
          error = false;
          _complete = true;
        });
      }
    }
  }

  _cancel() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  _goTo(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  ///////////////////////////
  // Dane Firmy
  TextEditingController nameCompany = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  DateTime yearEstablishmentCompany = DateTime.now();

  //

  bool _advertisement = false;
  bool _active = false;

  ////////////////////////////////////////////////////////////////////// Trzeba bedzie zrobic funkcje z roznymi pakietami firm
  String _dropdownValue = 'Pakiet-mini';

  void newPakietComapny(String newValue) {
    setState(() {
      _dropdownValue = newValue;
      print(newValue);
    });
  }

  //
  List<DropdownMenuItem<String>> dropDownValues = <String>[
    'Pakiet-mini',
    'Pakiet-medium',
    'Pakiet-high',
    'Pakiet-Premium'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  //////////////////////////////////////////////////////////////////////

  List<Step> _getSteps() {
    var steps = [
      Step(
        title: const Text(
            'Wybor Pakietu Firmy'), // czyli np. mini-Company, medium-company, high-company, roznica bedzie polegala na tym ilu pracownikow mozna zatrudnic
        isActive: _currentStep > 0,
        state: _currentStep > 0 ? StepState.complete : StepState.editing,
        content: Row(
          children: <Widget>[
            Text('Wybierz Pakiet:  '),
            DropdownButton<String>(
              value: _dropdownValue,
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
        isActive: _currentStep > 1,
        state: _currentStep > 1
            ? StepState.complete
            : _currentStep < 1 ? StepState.disabled : StepState.editing,
        title: Text('Dane'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nazwa'),
                    controller: nameCompany,
                    validator: (val) =>
                        val.isEmpty ? 'Prosze podac Nazwe' : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Numer Tel'),
                    controller: phoneNumber,
                    validator: (val) =>
                        val.isEmpty ? 'Prosze podac Numer Tel' : null,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Ogloszenie:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                    value: _advertisement,
                    onChanged: (val) {
                      setState(() {
                        _advertisement = val;
                      });
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Czy Firma ma byc odrazu aktywna:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                    value: _active,
                    onChanged: (val) {
                      setState(() {
                        _active = val;
                      });
                    }),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 50,
                      ),
                      onPressed: () {
                        print('Dodaj logo');
                      }),
                ),
                Text('Dodaj logo firmy'),
              ],
            )
          ],
        ),
      ),
      Step(
        state: _currentStep == 2 ? StepState.complete : StepState.disabled,
        title: Text('Podsumowanie'),
        content: Column(
          children: <Widget>[
            Text(
              'Podsumowanie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            size: 50,
                          ),
                          Text('Pakiet: ${_dropdownValue}'),
                          Text('Nazwa: ${nameCompany.value.text}'),
                          Text('Numer Tel: ${phoneNumber.value.text}'),
                          Row(
                            children: <Widget>[
                              Text('Ogloszenie: '),
                              _advertisement == true
                                  ? Text('Wlaczone')
                                  : Text('Wylaczone'),
                            ],
                          ),
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
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: _complete
                  ? Text('Stworzono Nowa Firme')
                  : Text('Stworz Firme'),
            ),
            body: Column(children: <Widget>[
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Nazwa Firmy '),
                                      _active
                                          ? Icon(
                                              Icons.radio_button_checked,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.radio_button_checked,
                                              color: Colors.red,
                                            ),
                                    ],
                                  ),
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
                                            Icon(
                                              Icons.image,
                                              size: 50,
                                            ),
                                            Text(
                                                'Nazwa: ${nameCompany.value.text}'),
                                            Text(
                                                'Data Zalozenia Firmy: ${DateFormat('dd-MM-yyy').format(yearEstablishmentCompany)}'),
                                            Text('Pakiet: ${_dropdownValue}'),
                                            Text(
                                                'Numer Telefonu: ${phoneNumber.value.text}'),
                                            Text(
                                                'Lokalizacja Firmy: Stefanow, Stanislawowa 1'),
                                            Text(
                                                'Ogłoszenie: ${_active ? "Wlaczone" : "Wylaczone"}'),
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
                                    FlatButton(
                                      color: Colors.grey,
                                      onPressed: onStepCancel,
                                      child: const Text('Powrot'),
                                    ),
                                  ]);
                            },
                          ),
                        )
            ]));
  }
}
