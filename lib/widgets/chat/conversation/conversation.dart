import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmanagement_app/widgets/chat/conversation/inputConversation.dart';

class Conversation extends StatelessWidget {
  bool conversation;
  bool firstMessage;

  final String mainUid;
  final String peopleUid;
  final String groupChatId;

  Conversation({
    @required this.conversation,
    this.firstMessage,
    this.mainUid,
    this.peopleUid,
    @required this.groupChatId,
  });

  List listMessages = [];
  final ScrollController listScrollController = new ScrollController();

  Widget _viewer_messages(int index, DocumentSnapshot document) {
    if (document['idFrom'] == mainUid) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['typeMessage'] == 0
              // Text
              ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: Colors.blue),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : Container(
                  child: FlatButton(
                    child: Material(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          width: 200.0,
                          height: 200.0,
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'images/img_not_available.jpeg',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: document
                            ['content'], // Trzeba zrobic stream z obiektem i dac tam getUrl
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: () {
                      /*
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                          */
                    },
                    padding: EdgeInsets.all(0),
                  ),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                document['typeMessage'] == 0
                    // Text
                    ? Container(
                        child: Text(
                          document['content'],
                          style: TextStyle(color: Colors.blue),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageLeft(index) ? 20.0 : 10.0,
                            right: 10.0),
                      )
                    : Container(
                        child: FlatButton(
                          child: Material(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                                width: 200.0,
                                height: 200.0,
                                padding: EdgeInsets.all(70.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Material(
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                              imageUrl: document['content'],
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            clipBehavior: Clip.hardEdge,
                          ),
                          onPressed: () {
                            /*
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                          */
                          },
                          padding: EdgeInsets.all(0),
                        ),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                            right: 10.0),
                      ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['timestamp']))),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessages != null &&
            listMessages[index - 1]['idFrom'] == mainUid) ||
            //listMessages[index - 1].idFrom == mainUid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessages != null &&
            listMessages[index - 1]['idFrom'] != mainUid) ||
            // listMessages[index - 1].idFrom != mainUid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Name'),
      centerTitle: true,
    );

    print(conversation.toString() + ' ' + firstMessage.toString());
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(10)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue)));
                } else {
                  listMessages = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        _viewer_messages(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
          ),
          InputConversation(
            conversation: conversation,
            firstMessage: firstMessage,
            mainUid: mainUid,
            peopleUid: peopleUid,
          ),
        ],
      ),
    );
  }
}
