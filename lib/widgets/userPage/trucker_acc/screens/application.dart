import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/application.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/applications.dart';

class TruckerNewApplication extends StatefulWidget {
  static const routeName = '/TruckerNewApplication/';

  @override
  _TruckerNewApplicationState createState() => _TruckerNewApplicationState();
}

class _TruckerNewApplicationState extends State<TruckerNewApplication> {
  @override
  Widget build(BuildContext context) {
    final Trucker userInfo = Provider.of<UserData>(context).data;

    final Advertisement advertisement =
        ModalRoute.of(context).settings.arguments;

    Application _application = Application(
      userInfo: userInfo,
      infoAdvertisement: advertisement,
      uidAdvertisement: advertisement.advertisementUid,
      uidApplicator: userInfo.uid,
      uidCompany: advertisement.companyUid,
      additionalInfo: '',
    );

    final appBar = AppBar(
      title: Text('Aplikacja'),
      centerTitle: true,
    );

    final heightDevice =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height);

    Widget companyInfo() {
      return Container(
        height: heightDevice * 0.25,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: advertisement.companyInfo.logoUrl == ''
                          ? Image.asset('images/default.jpg')
                          : Image.network(advertisement.companyInfo.logoUrl),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Container(
                                color: Theme.of(context).canvasColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nazwa: ${advertisement.companyInfo.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Telefon: ${advertisement.companyInfo.phone}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Ogloszenie: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(fontSize: 15),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Card(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text('Podglad'),
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget myInfo() {
      return Container(
        height: heightDevice * 0.25,
        child: Row(
          // Dane uzytkownika
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          height: double.infinity,
                          color: Theme.of(context).canvasColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Imie: ${userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Nazwisko: ${userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Doswiadczenie: ${userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Imie: ${userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: advertisement.companyInfo.logoUrl == ''
                    ? Image.asset('images/default.jpg')
                    : Image.network(advertisement.companyInfo.logoUrl),
              ),
            ),
          ],
        ),
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
            SizedBox(height: 15),
            companyInfo(),
            Divider(),
            Text(
              'Moje dane',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 15,
            ),
            myInfo(),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  'Dodatkowe informacje:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(),
                ),
                FlatButton(
                  onPressed: () {
                    Provider.of<Applications>(context, listen: false).sendApplication(
                        application: _application, trucker: userInfo);
                  },
                  color: Theme.of(context).canvasColor,
                  child: Text(
                    'Aplikuj',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
