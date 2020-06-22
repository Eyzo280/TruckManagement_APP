import 'package:flutter/material.dart';
import 'package:truckmanagement_app/theme.dart';

class FilterWidget extends StatelessWidget {
  final kmOd;
  final kmDo;

  FilterWidget(this.kmOd, this.kmDo);

  final List<Map<String, Object>> filtres = [{'Name': 'Przejechane Km'}, {'Name': 'Doswiadczenie'}, {'Name': 'Cos'},];

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bodyLook(context: context),
      child: Form(
        child: ListView.builder(
          itemCount: filtres.length,
          itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Text(
                '${filtres[index]['Name']}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: kmOd,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Od'),
                        ),
                      ),
                    ),
                  ),
                  Text('-'),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: kmDo,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Do'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
