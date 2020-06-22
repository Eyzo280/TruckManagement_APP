import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';

class FullDataEmployee extends StatefulWidget {
  Function sendInv;
  final driverData;
  final companyData;

  FullDataEmployee(this.sendInv, this.driverData, this.companyData);

  @override
  _FullDataEmployeeState createState() => _FullDataEmployeeState();
}

class _FullDataEmployeeState extends State<FullDataEmployee> {
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
                Text('Imie: ${widget.driverData.firstName}'),
                Text('Nazwisko: ${widget.driverData.lastName}'),
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.vertical -
                          10) *
                      0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Nr Tel: ${widget.driverData.numberPhone}'),
                      IconButton(
                          icon: Icon(
                            Icons.call,
                            color: widget.driverData.numberPhone != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => widget.driverData.numberPhone != null
                              ? print('Zadzwon')
                              : null)
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.vertical -
                          10) *
                      0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Chat: '),
                      IconButton(
                          icon: Icon(
                            Icons.chat,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Chat(
                                    mainUid: widget.companyData.uidCompany,
                                    peopleUid: widget.driverData.driverUid)
                                .searchChat(context);
                            print('Wlacz Chat');
                          })
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
                Text(
                    'Przejechane Km: ${widget.driverData.totalDistanceTraveled}'),
                Text(
                    'Zarejsetrowany od: ${SearchEmployeesBaseData().calculationAccountActivityTime(registerAccTime: widget.driverData.dateOfEmplotment)}'),
                Text(
                    'Prawo jazdy od: ${SearchEmployeesBaseData().calculationAccountActivityTime(registerAccTime: widget.driverData.drivingLicenseFrom)}'),
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
        title: Text('Szczegoly - Nazwa'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Align(
                alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color:
                          widget.sendInv != null ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      if (widget.sendInv != null) {
                        setState(() {
                          widget.sendInv(
                            companyData: widget.companyData,
                            employeesData: widget.driverData,
                          );
                          widget.sendInv = null;
                        });
                      } else {
                        print('Nie mozna wyslac zaproszenia.');
                      }
                    })),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
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
