import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/providers/advetisement.dart';

class NewAdvertisementTrucker extends StatefulWidget {
  @override
  _NewAdvertisementTruckerState createState() =>
      _NewAdvertisementTruckerState();
}

class _NewAdvertisementTruckerState extends State<NewAdvertisementTrucker> {
  final _formKey = GlobalKey<FormState>();

  Advertisement _advertisement = Advertisement(
    companyUid: '',
    title: '',
    requirements: RequirementsAdvertisementTrucker(
      kartaKierowcy: false,
      zaswiadczenieoniekaralnosci: false,
    ),
    description: '',
    type: 'Trucker',
  );

  @override
  Widget build(BuildContext context) {
    final CompanyData company = Provider.of<CompanyData>(context);
    return Form(
      key: _formKey,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Tytul',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) {
                      if (!RegExp(r'^([a-zA-Z]){6,}|[0-9].*([a-zA-Z]){6,}$')
                          .hasMatch(val)) {
                        return 'Tytul ma zbyt malo liter';
                      } else {
                        return null;
                      }
                    },
                    maxLength: 30,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    onSaved: (val) {
                      _advertisement = Advertisement(
                        companyUid: _advertisement.companyUid,
                        title: val,
                        requirements: _advertisement.requirements,
                        description: _advertisement.description,
                        type: _advertisement.type,
                      );
                    },
                  ),
                ),
                Divider(),
                Text(
                  'Wymagania',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                CheckboxFormField(
                  title: Text('Karta Kierowcy'),
                  onSaved: (val) {
                    _advertisement = Advertisement(
                      companyUid: _advertisement.companyUid,
                      title: _advertisement.title,
                      requirements: RequirementsAdvertisementTrucker(
                        kartaKierowcy: val,
                        zaswiadczenieoniekaralnosci: _advertisement
                            .requirements.zaswiadczenieoniekaralnosci,
                      ),
                      description: _advertisement.description,
                      type: _advertisement.type,
                    );
                  },
                ),
                CheckboxFormField(
                  title: Text('Zaswiadczenie o niekaralnosci'),
                  onSaved: (val) {
                    _advertisement = Advertisement(
                      companyUid: _advertisement.companyUid,
                      title: _advertisement.title,
                      requirements: RequirementsAdvertisementTrucker(
                        kartaKierowcy:
                            _advertisement.requirements.kartaKierowcy,
                        zaswiadczenieoniekaralnosci: val,
                      ),
                      description: _advertisement.description,
                      type: _advertisement.type,
                    );
                  },
                ),
                Divider(),
                Text(
                  'Opis',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: null,
                    maxLength: 300,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    onSaved: (val) {
                      _advertisement = Advertisement(
                        companyUid: _advertisement.companyUid,
                        title: _advertisement.title,
                        requirements: _advertisement.requirements,
                        description: val,
                        type: _advertisement.type,
                      );
                    },
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Provider.of<CompanyAdvertisements>(context, listen: false)
                        .viewTrucker();
                    print(Provider.of<CompanyAdvertisements>(context,
                            listen: false)
                        .truckers[0]
                        .companyInfo
                        .logoUrl
                        .toString());
                    if (company.uid == null) {
                      return;
                    }
                    _advertisement = Advertisement(
                      companyUid: company.uid,
                      title: _advertisement.title,
                      requirements: _advertisement.requirements,
                      description: _advertisement.description,
                      type: _advertisement.type,
                    );
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      /*
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return PreviewAdvertisementTrucker(
                            uid: company.uid,
                            title: _advertisement.title,
                            requirements: _advertisement.requirements,
                            description: _advertisement.description,
                          );
                        }),
                      );
                      */

                    }
                  },
                  child: Text(
                    'Dodaj Ogłoszenie',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
