import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/chat/conversation/inputConversation.dart';

class Conversation extends StatefulWidget {
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

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  List listMessages = [];
  final ScrollController listScrollController = new ScrollController();

  Widget _peopleMessages() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.grey,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Text('Message'),
          ),
        ),
      ),
    );
  }

  Widget _myMessages() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.grey,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Text('Message'),
          ),
        ),
      ),
    );
  }

  Widget _viewer_messages(int index, DocumentSnapshot document) {
    if (document['idFrom'] == widget.mainUid) {
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
              : SizedBox(),
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
                    : SizedBox(),
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
            listMessages[index - 1]['idFrom'] == widget.mainUid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessages != null &&
            listMessages[index - 1]['idFrom'] != widget.mainUid) ||
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

    print(
        widget.conversation.toString() + ' ' + widget.firstMessage.toString());
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Messages')
                  .document(widget.groupChatId)
                  .collection(widget.groupChatId)
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
          InputConversation(conversation: widget.conversation, mainUid: widget.mainUid, peopleUid: widget.peopleUid,),
        ],
      ),
    );
  }
}
