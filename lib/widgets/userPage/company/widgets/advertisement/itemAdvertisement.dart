import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementForwarder.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart';
import '../../providers/advetisement.dart';
import '../../providers/advetisement.dart';

class ItemAdvertisement extends StatelessWidget {
  final Advertisement advertisement;
  final SelectedAdvertisement selectedAdvertisement;

  ItemAdvertisement({
    this.advertisement,
    this.selectedAdvertisement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) {
                if (advertisement.type == 'Trucker') {
                  return PreviewAdvertisementTrucker(
                    advertisement: advertisement,
                  );
                } else {
                  return PreviewAdvertisementForwarder(
                    advertisement: advertisement,
                  );
                }
              }),
            );
          },
          contentPadding: EdgeInsets.all(15),
          leading: advertisement.companyInfo.logoUrl == ''
              ? Image.asset('images/default.jpg')
              : Image.network(advertisement.companyInfo.logoUrl),
          title: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              advertisement.title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          subtitle: advertisement.endDate == ''
              ? Text(
                  'Zakonczone',
                  style: TextStyle(color: Theme.of(context).errorColor),
                )
              : Text('Do: ${advertisement.endDate}'),
          trailing: DropdownButton(
            underline: Container(
              height: 0,
            ),
            icon: Icon(
              Icons.more_vert,
            ),
            onChanged: (String selectedValue) async {
              // Zarzadzanie ogloszeniem
              if (selectedValue == 'Przedluz') {
                try {
                  await Provider.of<CompanyAdvertisements>(context,
                          listen: false)
                      .reconditioningAdvertisement(
                    advUid: advertisement.advertisementUid,
                    type: advertisement.type,
                    selectedAdvertisement: selectedAdvertisement,
                  )
                      .then((_) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Odnowiono czas ${advertisement.title}.'),
                      ),
                    );
                  });
                } catch (err) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Problem z odnowieniem ogloszenia.'),
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                  );
                }
              } else if (selectedValue == 'Edytuj') {
              } else if (selectedValue == 'Usun') {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Center(
                        child: Text('Czy usunąć tytul?'),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Tak'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Provider.of<CompanyAdvertisements>(context,
                                    listen: false)
                                .deleteAdversitsement(
                                  selectedAdvertisement: selectedAdvertisement,
                                  uidAdvertisement:
                                      advertisement.advertisementUid,
                                )
                                .whenComplete(
                                  () => Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Usunieto ogloszenie ${advertisement.title}'),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                    ),
                                  ),
                                );
                          },
                        ),
                        FlatButton(
                          child: Text('Nie'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            iconEnabledColor: Theme.of(context).buttonColor,
            items: <String>[
              'Przedluz',
              'Edytuj',
              'Usun',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == 'Usun'
                    ? Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                          ),
                          Text(value),
                        ],
                      )
                    : value == 'Edytuj'
                        ? Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              Text(value),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.replay,
                                  color: Colors.white,
                                ),
                              ),
                              Text(value),
                            ],
                          ),
              );
            }).toList(),
          ),
        ),
        Divider()
      ],
    );
  }
}
