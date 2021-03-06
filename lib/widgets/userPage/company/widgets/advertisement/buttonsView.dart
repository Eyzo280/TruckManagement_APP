import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/adventisement.dart';

class ButtonsView extends StatefulWidget {
  final Function changeSelectedAdvertisement;

  ButtonsView({this.changeSelectedAdvertisement});

  @override
  _ButtonsViewState createState() => _ButtonsViewState();
}

class _ButtonsViewState extends State<ButtonsView> {
  var view = SelectedAdvertisement.Active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Flexible(
            child: InkWell(
              onTap: () {
                setState(() {
                  view = SelectedAdvertisement.Active;
                });
                widget.changeSelectedAdvertisement(
                  selectedAdvertisement: SelectedAdvertisement.Active,
                );
                print('Aktywne');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Aktywne',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: view == SelectedAdvertisement.Active
                              ? Colors.white
                              : Colors.grey,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                setState(() {
                  view = SelectedAdvertisement.Finished;
                });
                widget.changeSelectedAdvertisement(
                  selectedAdvertisement: SelectedAdvertisement.Finished,
                );
                print('Zakonczone');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Zakonczone',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: view == SelectedAdvertisement.Finished
                              ? Colors.white
                              : Colors.grey,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
