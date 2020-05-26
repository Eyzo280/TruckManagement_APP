import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services/database_company.dart';

class TracksActive extends StatefulWidget {
  static const routeName = '/TracksActive';

  final String companyUid;
  final List<Track> listTracks;

  TracksActive({
    @required this.companyUid,
    @required this.listTracks,
  });

  @override
  _TracksActiveState createState() => _TracksActiveState();
}

class _TracksActiveState extends State<TracksActive> {
  Future getActiveTracks() async {
    final tracks = await Firestore.instance
        .collection('Companys')
        .document(widget.companyUid)
        .collection('Tracks')
        .where('Status', isEqualTo: true)
        .getDocuments();
    print(tracks.documents);
  }

  // Sprawdzanie oraz uzywanie Search //

  String searchText = '';
  List<Track> sortListTracks = [];

  useSearch({searchTrack}) {
    setState(() {
      searchText = searchTrack;
    });
  }

  //                    //

  @override
  Widget build(BuildContext context) {
    if (searchText != '') {
      sortListTracks = widget.listTracks
          .where((val) => val.from == searchText)
          .toList(); // pozniej trzeba dodac || val.to == searchText
    } else {
      sortListTracks = widget.listTracks;
    }

    //
    void keyboardOff() {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    //
    AppBar appBar = AppBar(
      title: Text('Aktywne'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            List tracksFromTo = [];

            for (var val in widget.listTracks) {
              tracksFromTo.add(val.from + ' - ' + val.to);
            }
            showSearch(
                context: context,
                delegate: DataSearch(
                    useSearch: useSearch, tracksFromTo: tracksFromTo));
          },
        )
      ],
    );
    /*
    Widget SearchCard() {
      return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          height: (MediaQuery.of(context).size.height * 0.2) -
              appBar.preferredSize.height,
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Szukaj'),
                      //controller: ,
                    ),
                  )),
              Flexible(
                child: Container(
                  color: Colors.blue,
                  child: FlatButton(
                    onPressed: () {
                      print('Szukaj');
                      keyboardOff();
                    },
                    child: Text('Szukaj'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    */
    Widget ListTracks() {
      return Card(
        elevation: 5,
        child: Container(
          height: (MediaQuery.of(context).size.height * 0.95) -
              appBar.preferredSize.height,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child:
              /*ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.03),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text('Warszawa - Krakow'),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Opacity(opacity: 0.0),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                          margin: EdgeInsets.only(top: 0),
                          elevation: 5,
                          child: ListTile(
                              leading: Icon(
                                Icons.image,
                                size: MediaQuery.of(context).size.width * 0.1,
                              ),
                              onTap: () {
                                print('Pokaz Active Track ${index}');
                                keyboardOff();
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Stawka: '),
                                  Text('Termin: '),
                                  Text('Zleceniodawca: '),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
                
              }),
              */
              ListView.builder(
                  itemCount: sortListTracks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.03),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(20),
                                      ),
                                      child: Container(
                                        color: Colors.blue,
                                        child: Center(
                                          child: Text(
                                              '${sortListTracks[index].from} - ${sortListTracks[index].to}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Opacity(opacity: 0.0),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )),
                              margin: EdgeInsets.only(top: 0),
                              elevation: 5,
                              child: ListTile(
                                  leading: Icon(
                                    Icons.image,
                                    size:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  onTap: () {
                                    print('Pokaz Active Track ${index}');
                                    keyboardOff();
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          'Stawka: ${sortListTracks[index].fracht}'),
                                      Text(
                                          'Termin: ${sortListTracks[index].termin.toString()}'),
                                      Text('Zleceniodawca: '),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SearchCard(),
            ListTracks(),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  Function useSearch;
  final List tracksFromTo;

  DataSearch({@required this.useSearch, @required this.tracksFromTo});

  /*
  final cities = [
    'Warszawa',
    'Krakow',
    'Poznan',
    'Lodz',
  ];
  */
  final recentCities = [
    // pozniej trzeba zrobic zeby u uzytkownika zapisywaly sie jego wyszukiwania
    'Warszawa',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : tracksFromTo
            .where((p) =>
                p.toLowerCase().contains(query.toLowerCase()) ??
                p.contains(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        /*
        final userQuery = query;
        final viewSuggestion = suggestionList[index].split(query);

        final textStyle_Black_Bold =
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

        final textStyle_Grey = TextStyle(color: Colors.grey);
        */

        final viewSuggestion = suggestionList[index].split('');

        var result = '';

        /*
        List<InlineSpan> listText = query != ''
            ? [
                TextSpan(
                    text: viewSuggestion.length == 2
                        ? viewSuggestion[0]
                        : userQuery,
                    style: viewSuggestion.length == 2
                        ? textStyle_Black_Bold
                        : textStyle_Grey),
                TextSpan(
                    text: viewSuggestion.length == 2
                        ? userQuery
                        : viewSuggestion[0].substring(userQuery.length),
                    style: viewSuggestion.length == 2
                        ? textStyle_Grey
                        : textStyle_Black_Bold),
                TextSpan(
                    text: viewSuggestion.length == 2 ? viewSuggestion[1] : '',
                    style: viewSuggestion.length == 2
                        ? textStyle_Black_Bold
                        : textStyle_Grey),
              ]
            : [TextSpan(text: suggestionList[index], style: TextStyle(color: Colors.grey))];
        */

        List<InlineSpan> listText = [];

        int licznik = 0;

        if (query.isNotEmpty) {
          // Jezeli uzytkownik nic nie wpisal to normalnie dodaje szary tekst
          for (String letter in viewSuggestion) {
            licznik = licznik + 1;
            result = result + letter;
            if (result.toLowerCase() == query.toLowerCase()) {
              listText.add(TextSpan(
                text: result,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ));
              result = '';
            } else if (result.contains(query.toLowerCase()) &&
                result.length > query.length) {
              listText.add(TextSpan(
                text: result.substring(0, result.length - query.length),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ));
              listText.add(TextSpan(
                text: result.substring(result.length - query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ));
              result = '';
            } else if (licznik == viewSuggestion.length) {
              listText.add(TextSpan(
                text: result,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ));
            }
            print(listText.length);
          }
        } else {
          listText.add(TextSpan(
            text: suggestionList[index],
            style: TextStyle(color: Colors.grey),
          ));
        }

        return ListTile(
          onTap: () {
            query = suggestionList[index];
            useSearch(searchTrack: query);
            close(context, result);
          },
          leading: Icon(Icons.done),
          title: RichText(
            text: TextSpan(
                /*
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              */
                children: listText),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
