import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class InvitesFullData extends StatelessWidget {
  final String companyUid;
  final inviteData;

  InvitesFullData(this.companyUid, this.inviteData);

  Widget _topContent(context) {
    return Flexible(
      // Zdj imie, nazwisko itp.
      fit: FlexFit.tight,
      flex: 2,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).padding.vertical -
                      10) *
                  0.5,
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  // Trzeba zrobic zdj w przyszlosci
                  Icons.image,
                  size: (MediaQuery.of(context).size.width) * 0.5,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Imie: ${inviteData.firstNameDriver}'),
                Text('Nazwisko: ${inviteData.lastNameDriver}'),
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.vertical -
                          10) *
                      0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Nr Tel: ${inviteData.numberPhone}'),
                      IconButton(
                          icon: Icon(
                            Icons.call,
                            color: inviteData.numberPhone != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => inviteData.numberPhone != null
                              ? print('Zadzwon')
                              : null)
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

  Widget _centerContent(context) {
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
                Text('Przejechane Km: ${inviteData.totalDistanceTraveled}'),
                Text(
                    'Zarejsetrowany od: ${SearchEmployeesBaseData().calculationAccountActivityTime(registerAccTime: inviteData.dateOfEmplotment)}'),
                Text(
                    'Prawo jazdy od: ${SearchEmployeesBaseData().calculationAccountActivityTime(registerAccTime: inviteData.drivingLicenseFrom)}'),
                Text('Kursy Wschod/Zachod'),
                Text('Pozwolenia: ADR'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomContent(context) {
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
                    color: Theme.of(context).primaryColorDark,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Szczególy - Name'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
                    /*
                      if (widget.sendInv != null) {
                        setState(() {
                          widget.sendInv(
                              companyData: widget.companyData.uidCompany,
                              employeesUid: widget.driverData.driverUid,
                              nameCompany: widget.companyData.nameCompany,
                              yearEstablishmentCompany:
                                  widget.companyData.yearEstablishmentCompany,
                              firstNameDriver:
                                  widget.driverData.firstNameDriver,
                              lastNameDriver: widget.driverData.lastNameDriver,
                              drivingLicenseFrom:
                                  widget.driverData.drivingLicenseFrom,
                              drivingLicense: widget.driverData.drivingLicense,
                              knownLanguages: widget.driverData.knownLanguages,
                              totalDistanceTraveled:
                                  widget.driverData.totalDistanceTraveled);
                          widget.sendInv = null;
                        });
                      } else {
                        print('Nie mozna wyslac zaproszenia.');
                      }
                      */
                    Database_CompanyEmployees(companyUid: companyUid).acceptInv(
                        driverUid: inviteData.invUid,
                        firstNameDriver: inviteData.firstNameDriver,
                        lastNameDriver: inviteData.lastNameDriver,
                        numberPhone: inviteData.numberPhone);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Akceptuj',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _topContent(context),
            _centerContent(context),
            _bottomContent(context),
          ],
        ),
      ),
    );
  }
}
