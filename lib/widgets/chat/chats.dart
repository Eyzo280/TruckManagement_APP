import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/theme.dart';

class Chats extends StatefulWidget {
  static const routeName = '/Chats';

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  /*
  String _imageUrl;

  Future _getImage() async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('images/Users/ID/stefan.png')
          .getDownloadURL()
          .then((val) {
        if (_imageUrl == null) {
          setState(() {
            _imageUrl = val;
            print(val);
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }
  */
  Widget _screen({
    @required BuildContext context,
    @required PeerChat document,
    @required String userUid,
    @required int index,
  }) {
    // _getImage();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: (index % 2 == 0) ? Colors.white70 : Colors.grey.shade100,
        child: ListTile(
          onTap: () {
            Chat(
                    mainUid: userUid,
                    peopleUid: document.uid,
                    peopleFirstName: document.firstName,
                    peopleLastName: document.lastName)
                .searchChat(context);
            print('Wlaczono Chat ' + index.toString());
          },
          leading: Icon(
            Icons.image,
          ),
          title: Hero(
            tag: 'NameChat' + index.toString(),
            child: Text(document.firstName),
            flightShuttleBuilder: flightShuttleBuilder,
          ),
          trailing: Stack(
            children: <Widget>[
              new Icon(Icons.notifications),
              new Positioned(
                // draw a red marble
                top: 0.0,
                right: 0.0,
                child: new Icon(Icons.brightness_1,
                    size: 8.0, color: Colors.redAccent),
              )
            ],
          ),
        ),

        //),
      ),
    );

/*
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Material(
              child: Icon(
                Icons.account_circle,
                size: 50.0,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Nickname: ${document.firstName}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'Typ konta: ${document.type ?? 'Not available'}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
          ],
        ),
        onPressed: () {
          Chat(mainUid: userUid, peopleUid: document.uid).searchChat(context);
        },
        color: Colors.grey,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final userUid = routeArgs['userUid'];

    final chats = Provider.of<List<PeerChat>>(context) ?? null;
    if (chats != null) {
      print(chats[0].conversation);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          centerTitle: true,
          flexibleSpace: appBarLook(context: context),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: bodyLook(context: context),
          child: chats == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: chats.length,
                  itemBuilder: (context, index) => _screen(
                      context: context,
                      document: chats[index],
                      userUid: userUid,
                      index: index),
                ),
        ));

    /* Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('Messages').where(widget.companyUid, whereIn: [true, false]
            ).snapshots(),
            builder: (context, snapshot) {
              return Container(
                height: 500,
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                  return Text('s');
                }),
              );
            })
        ],
      ),
    );
    */
  }
}
