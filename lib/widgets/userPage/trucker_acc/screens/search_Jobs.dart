import 'package:flutter/material.dart';

class SearchJobs extends StatelessWidget {
  static const routeName = '/searchJobs/';

  @override
  Widget build(BuildContext context) {
    final generatedList = List.generate(10, (index) => 'Item $index');

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: false,
            floating: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Jobs'),
              centerTitle: true,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 90.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Text('No image'),
                        title: Text(
                          'Firma Transportowa',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Warszawa'),
                        trailing: Text(
                          '3k - 5k',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(),
                    )
                  ],
                );
              },
              childCount: generatedList.length,
            ),
          ),
        ],
      ),
    );
  }
}
