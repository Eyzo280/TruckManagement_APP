import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/buttonsView.dart';
import '../models/advertisement.dart';

class Advertisement extends StatelessWidget {
  static const routeName = '/advertisement/';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      title: Text('Advertisement'),
      centerTitle: true,
    );

    final bodyHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            ButtonsView(),
            Flexible(
              fit: FlexFit.loose,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {},
                            contentPadding: EdgeInsets.all(15),
                            leading: Text('Logo'),
                            title: Text('Kierowca Wlochy/Niemcy'),
                            trailing: DropdownButton(
                              underline: Container(
                                height: 0,
                              ),
                              icon: Icon(
                                Icons.more_vert,
                              ),
                              onChanged: (String selectedValue) {
                                // Zarzadzanie ogloszeniem
                              },
                              iconEnabledColor: Theme.of(context).primaryColor,
                              items: <String>[
                                'Przedluz',
                                'Usun',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: value == 'Usun'
                                      ? Row(
                                          children: <Widget>[
                                            Icon(Icons.delete_outline),
                                            Text(value),
                                          ],
                                        )
                                      : Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
