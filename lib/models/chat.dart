import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/chat/conversation/conversation.dart';

class Chat {
  final String mainUid;
  final String peopleUid;

  Chat({@required this.mainUid, @required this.peopleUid});

  final CollectionReference messages =
      Firestore.instance.collection('Messages');

  Future searchChat(context) async {
    // bool conversation;
    try {
      bool firstMessage;
      String groupChatId;

      if (mainUid.hashCode <= peopleUid.hashCode) {
        groupChatId = '$mainUid-$peopleUid';
      } else {
        groupChatId = '$peopleUid-$mainUid';
      }

      /*
    await messages.document(mainUid + '-' + peopleUid).get().then((val) {
      if (val.exists &&
          val.data[mainUid] == true &&
          val.data[peopleUid] == true) {
        // jezeli istnieje i dwoch uzytkownikow wylalo po jednej wiadomosci to znaczy ze mozna dalej kontynuowac konwersacje.
        conversation = true;
      } else {
        messages.document(peopleUid + '-' + mainUid).get().then((val) {
          if (val.exists &&
              val.data[mainUid] == true &&
              val.data[peopleUid] == true) {
            // jezeli istnieje i dwoch uzytkownikow wylalo po jednej wiadomosci to znaczy ze mozna dalej kontynuowac konwersacje.
            conversation = true;
          } else
            conversation = false;
        });
      }
    });
    */

      open({conversation}) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Conversation(
            conversation: conversation,
            firstMessage: firstMessage ?? null,
            mainUid: mainUid,
            peopleUid: peopleUid,
            groupChatId: groupChatId,
          ); // Trzeba dodac Chat z konktetna osoba oraz wylac wartosc conversation: True
        }));
      }

      await messages.document(groupChatId).get().then((val) {
        if (val.exists &&
            val.data[mainUid] == true &&
            val.data[peopleUid] == true) {
          // jezeli istnieje i dwoch uzytkownikow wylalo po jednej wiadomosci to znaczy ze mozna dalej kontynuowac konwersacje.
          open(conversation: true);
        } else
          messages
              .document(groupChatId)
              .collection(groupChatId)
              .limit(1)
              .where('idFrom', isEqualTo: mainUid)
              .getDocuments()
              .then((val) {
            for (var value in val.documents) {
              if (value.documentID != null) {
                open(conversation: false);
              } else {
                open(conversation: true);
              }
            }
          });
      });

      /*
    if (conversation == true) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Conversation(
            conversation:
                conversation, getMessages: getMessages); // Trzeba dodac Chat z konktetna osoba oraz wylac wartosc conversation: True
      }));
    } else if (conversation == false) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Conversation(
            conversation:
                conversation, getMessages: getMessages); // Trzeba dodac Chat z konktetna osoba oraz wylac wartosc conversation: False
      }));
    }
    */
    } catch (err) {
      print(err);
    }
  }

  Future sendMessage({bool conversation, String message}) async {
    /*
    final String mainUid = mainData.typeUser != 'DriverTruck'
        ? mainData.uidCompany
        : mainData.driverUid;
    final String peopleUid = peopleData.typeUser != 'DriverTruck'
        ? peopleData.uidCompany
        : peopleData.driverUid;
        */

    try {
      String groupChatId;

      if (mainUid.hashCode <= peopleUid.hashCode) {
        groupChatId = '$mainUid-$peopleUid';
      } else {
        groupChatId = '$peopleUid-$mainUid';
      }

      if (conversation == true) {
        await messages.document(groupChatId).get().then((val) {
          if (val.exists) {
            messages.document(groupChatId).updateData({
              mainUid: true,
            }).whenComplete(() {
              messages
                  .document(groupChatId)
                  .collection(groupChatId)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData({
                'content': message,
                'idFrom': mainUid,
                'idTo': peopleUid,
                'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                'typeMessage': 0,
              });
            });
          } else {
            messages.document(groupChatId).setData({
              mainUid: true,
              peopleUid: false,
            }).whenComplete(() {
              messages
                  .document(groupChatId)
                  .collection(groupChatId)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData({
                'content': message,
                'idFrom': mainUid,
                'idTo': peopleUid,
                'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                'typeMessage': 0,
              });
            });
          }
        });
      } else {
        await messages
            .document(groupChatId)
            .collection(groupChatId)
            .document(DateTime.now().millisecondsSinceEpoch.toString())
            .setData({
          'content': message,
          'idFrom': mainUid,
          'idTo': peopleUid,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'typeMessage': 0,
        });
      }
    } catch (err) {
      print(err);
    }
  }
}
