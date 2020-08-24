import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/application.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementForwarder.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';

class CompanyInfo extends StatelessWidget {
  final Application application;
  final double heightDevice;

  CompanyInfo({
    this.application,
    this.heightDevice,
  });
  @override
  Widget build(BuildContext context) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                          advertisement: application
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
}
