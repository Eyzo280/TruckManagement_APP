import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/services_Trucker/database_Trucker.dart';

class TruckerSearchCompany extends StatelessWidget {
  // final userData;

  // TruckerSearchCompany(this.userData);

  static const routeName = '/searchCompany';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, DriverTruck>;

    final userData = routeArgs['userData'];
    final searchCompanys = Provider.of<List<BaseSearchCompany>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wyszukiwarka Firmy',
            style: TextStyle(
              color: Theme.of(context).canvasColor,
            )),
      ),
      body: ListView.builder(
        itemCount: searchCompanys.length,
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
                            child: Text(searchCompanys[index].nameCompany),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Salary:'),
                              Text('dsadsa'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('Znaj j.Obcych:'),
                              Text('Nie'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('Kursy:'), // do jakich krajow sa kursy
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
                              DataBase_Trucker(uid: userData.driverUid).sendInvite(
                                companyUid: searchCompanys[index].idCompany,
                                dateOfEmplotment: userData.dateOfEmplotment,
                                drivingLicense: userData.drivingLicense,
                                drivingLicenseFrom: userData.drivingLicenseFrom,
                                firstName: userData.firstName,
                                knownLanguages: userData.knownLanguages,
                                lastName: userData.lastName,
                                numberPhone: userData.numberPhone,
                                totalDistanceTraveled:
                                    userData.totalDistanceTraveled,
                                type: userData.type,
                              );
                              print('Wyslij Prosbe');
                            }),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
