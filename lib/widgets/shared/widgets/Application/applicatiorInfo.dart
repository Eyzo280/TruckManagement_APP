import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/application.dart';

class ApplicatorInfo extends StatelessWidget {
  final Application application;
  final double heightDevice;

  ApplicatorInfo({
    this.application,
    this.heightDevice,
  });

  @override
  Widget build(BuildContext context) {
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
}
