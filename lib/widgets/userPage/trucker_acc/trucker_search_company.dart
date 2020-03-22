import 'package:flutter/material.dart';

class TruckerSearchCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Available seats'),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle),
                  tooltip: 'Add new entry',
                  onPressed: () {/* ... */},
                ),
              ]),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                Container(
                  child: Card(
                    color: Colors.red,
                    child: ListTile(
                      leading: FlutterLogo(size: 56.0),
                      title: Row(
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text('Salary'),),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              children: <Widget>[
                                Text('Name'),
                                Text('Company'),
                              ],
                            )),
                            Flexible(
                            fit: FlexFit.tight,
                            child: Text('s'),),
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text('s'),),
                            Flexible(
                            fit: FlexFit.tight,
                            child: Text('s'),),
                            Flexible(
                            fit: FlexFit.tight,
                            child: Text('s'),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
