/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldCreateNewTrucker extends StatefulWidget {
  final Function addDriverTruck;

  TextFieldCreateNewTrucker(this.addDriverTruck);

  @override
  _TextFieldCreateNewTruckerState createState() =>
      _TextFieldCreateNewTruckerState();
}

class _TextFieldCreateNewTruckerState extends State<TextFieldCreateNewTrucker> {
  // Wartosci NewDriver
  final _firstNameDriver = TextEditingController();

  final _lastNameDriver = TextEditingController();

  final _salary = TextEditingController();

  DateTime _dateOfEmplotment;

  DateTime _payday;

  final _numberPhone = TextEditingController();

  // Napis z prosba o uzupenienie wszytkich pol

  bool hints; // dzieki temu moge wlaczac lub wylaczac

  String noCompleteAllField = 'Prosze uzupelnic wszytkie pola.';

  //

  void _presentDatePicker(pick) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (pick == 'dateOfEmplotment') {
          _dateOfEmplotment = pickedDate;
        } else if (pick == 'payday') {
          _payday = pickedDate;
        }
      });
      if (_dateOfEmplotment != null && _payday != null) {
        _submitData();
      }
    });
  }

  void _submitData({bool activehints}) {
    if (_firstNameDriver.text.isEmpty || _lastNameDriver.text.isEmpty ||
        _salary.text.isEmpty ||
        _dateOfEmplotment == null ||
        _payday == null ||
        _numberPhone.text.isEmpty) {
      if (activehints == true) {
        setState(() {
          hints = true;
        });
      }

      return;
    }

    print('Dodawanie DriverTruck 1/2');

    widget.addDriverTruck(_firstNameDriver.text, _lastNameDriver.text, _salary.text, _dateOfEmplotment,
        _payday, _numberPhone.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Imie:'),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(
                    child: TextField(
                  controller: _firstNameDriver,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) {
                    _submitData();
                  },
                )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Nazwisko:'),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(
                    child: TextField(
                  controller: _lastNameDriver,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) {
                    _submitData();
                  },
                )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Pensja:'),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(
                    child: TextField(
                  controller: _salary,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    _submitData();
                  },
                )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Data Zatrudnienia:'),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    _dateOfEmplotment != null
                        ? DateFormat('dd-MM-yyy').format(_dateOfEmplotment)
                        : 'Dodaj Date',
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _presentDatePicker('dateOfEmplotment');
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Data Wyplaty:'),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    _payday != null
                        ? DateFormat('dd-MM-yyy').format(_payday)
                        : 'Dodaj Date',
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _presentDatePicker('payday');
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('Numer Telefonu:'),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(
                    child: TextField(
                  controller: _numberPhone,
                  keyboardType: TextInputType.phone,
                  onSubmitted: (_) {
                    _submitData();
                  },
                )),
              ),
            ],
          ),
          FlatButton(
            color: Colors.red,
            onPressed: () {
              _submitData(activehints: true);
            },
            child: Text(
              'Dodaj',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          hints == true ? Text(noCompleteAllField) : Text(''),
        ],
      ),
    );
  }
}
*/