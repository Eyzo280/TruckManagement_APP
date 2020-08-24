import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/application.dart' as model;
import 'package:truckmanagement_app/widgets/shared/widgets/Application/applicatiorInfo.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/Application/companyInfo.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/applications.dart';

class Application extends StatelessWidget {
  static const routeName = '/Application/';

  final String userUid;

  Application({this.userUid});

  @override
  Widget build(BuildContext context) {
    final model.Application application =
        ModalRoute.of(context).settings.arguments;

    final appBar = AppBar(
      title: const Text('Aplikacja'),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Applications>(
                builder: (_, applications, __) {
                  var check = applications
                      .fetchApplications.firstWhere((element) => element.applicationID == application.applicationID);
                  return Text(
                    check.status,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 15,
                          color: check.status == 'Rozpatrywana'
                              ? Colors.green
                              : check.status == 'Zaproszenie'
                                  ? Theme.of(context).canvasColor
                                  : Theme.of(context).errorColor,
                        ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );

    final heightDevice =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height);

    Widget userControlWidget() {
      return application.status == 'Rozpatrywana' ||
              application.status == 'Zakonczona'
          ? SizedBox()
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      color: Theme.of(context).canvasColor,
                      child: Text('Akceptuj'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Theme.of(context).canvasColor,
                      child: Text('Odrzuc'),
                    ),
                  ],
                ),
              ],
            );
    }

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            Text(
              'Firma:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 15),
            CompanyInfo(
              application: application,
              heightDevice: heightDevice,
            ),
            const Divider(),
            Text(
              application.uidCompany != userUid ? 'Moje dane' : 'Dane Kierowcy',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 15,
            ),
            ApplicatorInfo(
              application: application,
              heightDevice: heightDevice,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Dodatkowe informacje:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(application.additionalInfo)),
            ),
            application.uidApplicator == userUid
                ? userControlWidget()
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
