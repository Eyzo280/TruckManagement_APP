import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/widgets/userPage/company/providers/advetisement.dart';

class EditAdvertisement extends StatefulWidget {
  final Advertisement advertisement;

  EditAdvertisement({this.advertisement});

  @override
  _EditAdvertisementState createState() => _EditAdvertisementState();
}

class _EditAdvertisementState extends State<EditAdvertisement> {
  final _formKey = GlobalKey<FormState>();

  Advertisement editData; // zmienione dane do zapisu

  @override
  Widget build(BuildContext context) {
    editData = Advertisement(
      advertisementUid: widget.advertisement.advertisementUid,
      companyInfo: CompanyInfoAdvertisement(
        logoUrl: widget.advertisement.companyInfo.logoUrl,
        name: widget.advertisement.companyInfo.name,
        phone: '', // Trzeba dodac numer kontaktowy do ogłoszenia
      ),
      title: widget.advertisement.title,
      requirements: widget.advertisement.type == 'Trucker'
          ? RequirementsAdvertisementTrucker(
              kartaKierowcy: widget.advertisement.requirements.kartaKierowcy,
              zaswiadczenieoniekaralnosci:
                  widget.advertisement.requirements.zaswiadczenieoniekaralnosci,
            )
          : RequirementsAdvertisementForwarder(
              doswiadczenie: widget.advertisement.requirements.doswiadczenie,
              zaswiadczenieoniekaralnosci:
                  widget.advertisement.requirements.zaswiadczenieoniekaralnosci,
              umiejetnoscianalityczne:
                  widget.advertisement.requirements.umiejetnoscianalityczne,
            ),
      description: widget.advertisement.description,
      endDate: widget
          .advertisement.endDate, // obecnie jest na stale 7 dni od utworzenia
      type: widget.advertisement.type,
    );

    Widget truckerRequirements({BuildContext context}) {
      return Column(
        children: [
          CheckboxFormField(
            initialValue: editData.requirements.kartaKierowcy,
            title: Text('Karta Kierowcy'),
            onSaved: (val) {
              editData = Advertisement(
                advertisementUid: editData.advertisementUid,
                companyUid: editData.companyUid,
                companyInfo: editData.companyInfo,
                title: editData.title,
                requirements: RequirementsAdvertisementTrucker(
                  kartaKierowcy: val,
                  zaswiadczenieoniekaralnosci: widget
                      .advertisement.requirements.zaswiadczenieoniekaralnosci,
                ),
                description: editData.description,
                endDate: editData.endDate,
                type: editData.type,
              );
            },
          ),
          CheckboxFormField(
            initialValue: editData.requirements.zaswiadczenieoniekaralnosci,
            title: Text('Zaswiadczenie o niekaralnosci'),
            onSaved: (val) {
              editData = Advertisement(
                advertisementUid: editData.advertisementUid,
                companyUid: editData.companyUid,
                companyInfo: editData.companyInfo,
                title: editData.title,
                requirements: RequirementsAdvertisementTrucker(
                  kartaKierowcy: editData.requirements.kartaKierowcy,
                  zaswiadczenieoniekaralnosci: val,
                ),
                description: editData.description,
                endDate: editData.endDate,
                type: editData.type,
              );
            },
          ),
        ],
      );
    }

    Widget forwarderRequirements({BuildContext context}) {
      return Column(
        children: [
          CheckboxFormField(
            initialValue: editData.requirements.doswiadczenie,
            title: Text('Doświadczenie w branży'),
            onSaved: (val) {
              editData = Advertisement(
                advertisementUid: editData.advertisementUid,
                companyUid: editData.companyUid,
                companyInfo: editData.companyInfo,
                title: editData.title,
                requirements: RequirementsAdvertisementForwarder(
                  doswiadczenie: val,
                  zaswiadczenieoniekaralnosci:
                      editData.requirements.zaswiadczenieoniekaralnosci,
                  umiejetnoscianalityczne:
                      editData.requirements.umiejetnoscianalityczne,
                ),
                description: editData.description,
                endDate: editData.endDate,
                type: editData.type,
              );
            },
          ),
          CheckboxFormField(
            initialValue: editData.requirements.zaswiadczenieoniekaralnosci,
            title: Text('Zaświadczenie o niekaralności'),
            onSaved: (val) {
              editData = Advertisement(
                advertisementUid: editData.advertisementUid,
                companyUid: editData.companyUid,
                companyInfo: editData.companyInfo,
                title: editData.title,
                requirements: RequirementsAdvertisementForwarder(
                  doswiadczenie: editData.requirements.doswiadczenie,
                  zaswiadczenieoniekaralnosci: val,
                  umiejetnoscianalityczne:
                      editData.requirements.umiejetnoscianalityczne,
                ),
                description: editData.description,
                endDate: editData.endDate,
                type: editData.type,
              );
            },
          ),
          CheckboxFormField(
            initialValue: editData.requirements.umiejetnoscianalityczne,
            title: Text('Umiejętności analityczne'),
            onSaved: (val) {
              editData = Advertisement(
                advertisementUid: editData.advertisementUid,
                companyUid: editData.companyUid,
                companyInfo: editData.companyInfo,
                title: editData.title,
                requirements: RequirementsAdvertisementForwarder(
                  doswiadczenie: editData.requirements.doswiadczenie,
                  zaswiadczenieoniekaralnosci:
                      editData.requirements.zaswiadczenieoniekaralnosci,
                  umiejetnoscianalityczne: val,
                ),
                description: editData.description,
                endDate: editData.endDate,
                type: editData.type,
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edytuj'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(35),
          ),
          child: Container(
            height: double.infinity,
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
                      initialValue: widget.advertisement.title,
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
                        editData = Advertisement(
                          advertisementUid: editData.advertisementUid,
                          companyUid: editData.companyUid,
                          companyInfo: editData.companyInfo,
                          title: val,
                          requirements: editData.requirements,
                          description: editData.description,
                          endDate: editData.endDate,
                          type: editData.type,
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
                  editData.type == 'Trucker'
                      ? truckerRequirements(context: context)
                      : forwarderRequirements(context: context),
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
                      initialValue: editData.description,
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
                        editData = Advertisement(
                          advertisementUid: editData.advertisementUid,
                          companyUid: editData.companyUid,
                          companyInfo: editData.companyInfo,
                          title: editData.title,
                          requirements: editData.requirements,
                          description: val,
                          endDate: editData.endDate,
                          type: editData.type,
                        );
                      },
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Provider.of<CompanyAdvertisements>(context,
                                listen: false)
                            .editAdversitsement(
                          advUid: editData.advertisementUid,
                          companyInfo: editData.companyInfo,
                          description: editData.description,
                          requirements: editData.requirements,
                          title: editData.title,
                          type: editData.type,
                        );
                      }
                      /*
                      if (widget.advertisement.companyUid == null) {
                        return;
                      }
                      editData = Advertisement(
                        advertisementUid: widget.advertisement.advertisementUid,
                        companyUid: widget.advertisement.companyUid,
                        companyInfo: widget.advertisement.companyInfo,
                        title: widget.advertisement.title,
                        requirements: widget.advertisement.requirements,
                        description: widget.advertisement.description,
                        endDate: widget.advertisement.endDate,
                        type: widget.advertisement.type,
                      );
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Provider.of<CompanyAdvertisements>(context,
                                listen: false)
                            .addAdvertisement(
                          companyUid: widget.advertisement.companyUid,
                          companyInfo: widget.advertisement.companyInfo,
                          description: widget.advertisement.description,
                          requirements: widget.advertisement.requirements,
                          title: widget.advertisement.title,
                          type: widget.advertisement.type,
                        );
                        /*
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return PreviewAdvertisementTrucker(
                            uid: company.uid,
                            title: advertisement.title,
                            requirements: advertisement.requirements,
                            description: advertisement.description,
                          );
                        }),
                      );
                      */

                      }
                      */
                    },
                    child: Text(
                      'Zapisz zmiany',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
