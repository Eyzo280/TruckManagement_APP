import 'package:flutter/material.dart';

class PreviewCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Podglad Firm'),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Card(
                    child: Text('data'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
