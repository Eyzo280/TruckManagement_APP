import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
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
      //bool firstMessage;
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

      open({conversation, firstMessage}) {
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
          open(conversation: true, firstMessage: false);
        } else if (val.exists == false) {
          open(conversation: false, firstMessage: true);
        } else if (val.data[peopleUid] == false) {
          open(conversation: false, firstMessage: false);
        }
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

  Future sendMessage(
      {@required bool conversation,
      @required String message,
      @required int typeMessage}) async {
    /*
    final String mainUid = mainData.type != 'DriverTruck'
        ? mainData.uidCompany
        : mainData.driverUid;
    final String peopleUid = peopleData.type != 'DriverTruck'
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
            'typeMessage': typeMessage,
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
            'typeMessage': typeMessage,
          });
        });
      }
    } catch (err) {
      print(err);
    }
  }

  // Pobieranie danych o Chacie
  /*
  Stream<List<PeerChat>> getUserChats() async* {
    var chatsStream = Firestore.instance
        .collection('Messages')
        .where(mainUid, whereIn: [true, false]).snapshots();
    var chats = List<PeerChat>();
    await for (var chatsSnapshot in chatsStream) {
      for (var chatDoc in chatsSnapshot.documents) {
        var chat;
        var chatUid = chatDoc.documentID.split('-');
        print(chatDoc.data[uid]);
        for (var splitedUid in chatUid) {
          if (mainUid != splitedUid) {

            final bool conversation = chatDoc.data[uid];
            print(conversation);
            await Firestore
                .instance // Sprawdzanie, gdzie znajduja sie uzytkownicy i tworzenie objektow
                .collection('Drivers')
                .document(splitedUid)
                .get()
                .then((val) {
              if (val.exists) {
                chat = PeerChat(
                    uid: splitedUid ?? null,
                    firstName: val.data['firstName'] ?? null,
                    lastName: val.data['lastName'] ?? null,
                    type: val.data['type'] ?? null);
              } else {
                Firestore.instance
                    .collection('Drivers')
                    .document(splitedUid)
                    .get()
                    .then((val) {
                  if (val.exists) {
                    chat = PeerChat(
                        uid: splitedUid ?? null,
                        conversation: conversation ?? null,
                        firstName: val.data['firstName'] ??
                            null, // Pasowalo by przerobic baze danych, zeby zamiast firstName bylo firstName itp
                        lastName: val.data['lastName'] ?? null,
                        type: val.data['type'] ?? null);
                        
                  } else {
                    print('Trzeba dodac Forwarders do Chatu w models/chat.dart !!!');
                  }
                });
              }
            });
          }
          chats.add(chat);
        }
        yield chats;
      }
    }
  }
  */

  Stream<List<PeerChat>> getUserChats() async* {
    var chatsStream = Firestore.instance
        .collection('Messages')
        .where(mainUid, whereIn: [true, false]).snapshots();
    var chats = List<PeerChat>();
    await for (var chatsSnapshot in chatsStream) {
      for (var chatDoc in chatsSnapshot.documents) {
        var chat;
        var chatUid = chatDoc.documentID.split('-');
        for (var splitedUid in chatUid) {
          if (mainUid != splitedUid) {
            var complete;
            await Firestore
                .instance // Sprawdzanie, gdzie znajduja sie uzytkownicy i tworzenie objektow
                .collection('Chiefs')
                .document(splitedUid)
                .get()
                .then((val) async {
              if (val.exists) {
                complete = val;
              } else {
                await Firestore.instance
                    .collection('Companys')
                    .document(splitedUid)
                    .get()
                    .then((val) async {
                  if (val.exists) {
                    complete = val;
                  } else {
                    await Firestore.instance
                        .collection('Drivers')
                        .document(splitedUid)
                        .get()
                        .then((val) async {
                      if (val.exists) {
                        complete = val;
                      } else {
                        await Firestore.instance
                            .collection('Forwarders')
                            .document(splitedUid)
                            .get()
                            .then((val) async {
                          if (val.exists) {
                            complete = val;
                          } else {
                            print('Problem przy znalezieniu danych.');
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
            if (complete != null) {
              if (complete.data['type'] == 'Chief') {
                chat = PeerChat(
                  uid: splitedUid ?? null,
                  conversation: chatDoc.data[splitedUid] ?? null,
                  firstName: complete.data['firstName'] ??
                      null, // Pasowalo by przerobic baze danych, zeby zamiast firstName bylo firstName itp
                  lastName: complete.data['lastName'] ?? null,
                  type: complete.data['type'] ?? null,
                );
              } else if (complete.data['type'] == 'Company') {
                chat = PeerChat(
                  uid: splitedUid ?? null,
                  conversation: chatDoc.data[splitedUid] ?? null,
                  firstName: complete.data['nameCompany'] ??
                      null, // Pasowalo by przerobic baze danych, zeby zamiast firstName bylo firstName itp
                  lastName: null,
                  type: complete.data['type'] ?? null,
                );
              } else if (complete.data['type'] == 'DriverTruck') {
                chat = PeerChat(
                  uid: splitedUid ?? null,
                  conversation: chatDoc.data[splitedUid] ?? null,
                  firstName: complete.data['firstName'] ??
                      null, // Pasowalo by przerobic baze danych, zeby zamiast firstName bylo firstName itp
                  lastName: complete.data['lastName'] ?? null,
                  type: complete.data['type'] ?? null,
                );
              } else if (complete.data['type'] == 'Forwarder') {
                chat = PeerChat(
                  uid: splitedUid ?? null,
                  conversation: chatDoc.data[splitedUid] ?? null,
                  firstName: complete.data['firstName'] ??
                      null, // Pasowalo by przerobic baze danych, zeby zamiast firstName bylo firstName itp
                  lastName: complete.data['lastName'] ?? null,
                  type: complete.data['type'] ?? null,
                );
              }
            } else {
              print('Nie znaleziono danych.');
            }
            chats.add(chat);
          }
        }
      }
      yield chats;
    }
  }
}

// Zamienilem na poprzednia wersje, czyli bez pobierania url tylko odrazu w bazie jest url do obrazka
/*
class ChatMessage {
  final String content;
  final String idFrom;
  final String idTo;
  final String timestamp;
  final int typeMessage;

  ChatMessage({
    this.content,
    this.idFrom,
    this.idTo,
    this.timestamp,
    this.typeMessage,
  });

  FutureOr<List<ChatMessage>> _message(QuerySnapshot snapshot) async {
    List<ChatMessage> messages = List<ChatMessage>();
    for (var doc in snapshot.documents) {
      var message;
      if (doc.data != null) {
        if (doc.data['typeMessage'] == 1) {
          await FirebaseStorage.instance
              .ref()
              .child(doc.data['content'])
              .getDownloadURL()
              .then((val) {
            message = ChatMessage(
              content: val,
              idFrom: doc.data['idFrom'],
              idTo: doc.data['idTo'],
              timestamp: doc.data['timestamp'],
              typeMessage: doc.data['typeMessage'],
            );
          });
        } else {
          message = ChatMessage(
            content: doc.data['content'],
            idFrom: doc.data['idFrom'],
            idTo: doc.data['idTo'],
            timestamp: doc.data['timestamp'],
            typeMessage: doc.data['typeMessage'],
          );
        }
      }

      messages.add(message);
    }

    return messages;
  }

  Stream<List<ChatMessage>> getMessages({@required groupChatId}) {
    return Firestore.instance
        .collection('Messages')
        .document(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .asyncMap(_message);
  }
}
*/
