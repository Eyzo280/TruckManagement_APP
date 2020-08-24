import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementForwarder.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';
import 'package:truckmanagement_app/models/application.dart' as model;
import 'package:truckmanagement_app/widgets/shared/widgets/Application/applicatiorInfo.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/Application/companyInfo.dart';

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
    );

    final heightDevice =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height);

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
            application.uidCompany != userUid
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
                            child: Text('Zapros'),
                          ),
                          FlatButton(
                            onPressed: () {},
                            color: Theme.of(context).canvasColor,
                            child: Text('Odrzuc'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
