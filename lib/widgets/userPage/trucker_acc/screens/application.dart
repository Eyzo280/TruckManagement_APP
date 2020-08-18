import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';

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

    Widget companyInfo() {
      return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Firma:',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: advertisement.companyInfo.logoUrl == ''
                          ? Image.asset('images/default.jpg')
                          : Image.network(advertisement.companyInfo.logoUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              FlatButton(
                                  color: Theme.of(context).canvasColor,
                                  onPressed: () {},
                                  child: Text('Podglad')),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget myInfo() {
      return Flexible(
        fit: FlexFit.tight,
        child: Row(
          // Dane uzytkownika
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green,
                  child: Text('Imie: ${userInfo.nickName}', style: Theme.of(context).textTheme.bodyText1,),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: advertisement.companyInfo.logoUrl == ''
                      ? Image.asset('images/default.jpg')
                      : Image.network(advertisement.companyInfo.logoUrl),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikacja'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            companyInfo(),
            Divider(),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    'Moje dane',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  myInfo(),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child: Column(
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
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Theme.of(context).canvasColor,
                    child: Text(
                      'Aplikuj',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
