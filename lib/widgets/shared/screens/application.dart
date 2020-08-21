import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementForwarder.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/application.dart'
    as model;

class Application extends StatelessWidget {
  static const routeName = '/Application/';

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
                      child: Hero(
                        tag: application.uidAdvertisement + '-Image',
                        child:
                            application.infoAdvertisement.companyInfo.logoUrl ==
                                    ''
                                ? Image.asset('images/default.jpg')
                                : Image.network(application
                                    .infoAdvertisement.companyInfo.logoUrl),
                      ),
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
                                        'Nazwa: ${application.infoAdvertisement.companyInfo.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Telefon: ${application.infoAdvertisement.companyInfo.phone}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(
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
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return application
                                                                .infoAdvertisement
                                                                .type ==
                                                            'Trucker'
                                                        ? PreviewAdvertisementTrucker(
                                                            advertisement:
                                                                application
                                                                    .infoAdvertisement,
                                                            application: false,
                                                          )
                                                        : PreviewAdvertisementForwarder();
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Card(
                                              color: Colors.white,
                                              child: const Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Text('Podglad'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
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
                                    'Imie: ${application.userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Nazwisko: ${application.userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Doswiadczenie: ${application.userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Imie: ${application.userInfo.nickName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Telefon: ${application.userInfo.nickName}',
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
                child: application.infoAdvertisement.companyInfo.logoUrl == ''
                    ? Image.asset('images/default.jpg')
                    : Image.network(
                        application.infoAdvertisement.companyInfo.logoUrl),
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
            const SizedBox(height: 15),
            companyInfo(),
            const Divider(),
            Text(
              'Moje dane',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 15,
            ),
            myInfo(),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(application.additionalInfo)),
            ),
          ],
        ),
      ),
    );
  }
}
