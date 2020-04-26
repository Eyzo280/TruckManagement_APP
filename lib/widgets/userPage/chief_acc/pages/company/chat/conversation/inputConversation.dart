import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truckmanagement_app/models/chat.dart';

class InputConversation extends StatefulWidget {
  bool conversation;
  bool firstMessage;
  var mainUid;
  var peopleUid;

  InputConversation(
      {this.conversation, this.firstMessage, this.mainUid, this.peopleUid});

  @override
  _InputConversationState createState() => _InputConversationState();
}

class _InputConversationState extends State<InputConversation> {
  final TextEditingController _value_meesage = TextEditingController();
  bool sending = false;
  var _imageFile;
  bool isLoading;
  String imageUrl;

  Future getImage() async {
    String groupChatId;

    if (widget.mainUid.hashCode <= widget.peopleUid.hashCode) {
      groupChatId = '${widget.mainUid}-${widget.peopleUid}';
    } else {
      groupChatId = '${widget.peopleUid}-${widget.mainUid}';
    }
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (_imageFile != null && groupChatId != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile(groupChatId: groupChatId);
    }
  }

  Future uploadFile({groupChatId}) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('images/Chat/' + groupChatId + '/' + fileName);
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        Chat(mainUid: widget.mainUid, peopleUid: widget.peopleUid).sendMessage(
            conversation: widget.conversation,
            message: downloadUrl,
            typeMessage: 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      // Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
          color: Colors.white),
      height: 50,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed:
                    widget.firstMessage == true || widget.conversation == true
                        ? () {
                            if (widget.firstMessage == true) {
                              setState(() {
                                widget.firstMessage = false;
                              });
                              getImage();
                            } else {
                              getImage();
                            }
                          }
                        : null,
                color: Colors.blue,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: null,
                color: Colors.blue,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Message'),
                  controller: _value_meesage,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              )),
          Container(
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: widget.conversation != false &&
                      widget.firstMessage != true &&
                      sending == false &&
                      _value_meesage.value.text != ''
                  ? () async {
                      try {
                        setState(() {
                          sending = true;
                        });
                        await Chat(
                          mainUid: widget.mainUid,
                          peopleUid: widget.peopleUid,
                        ).sendMessage(
                            conversation: widget.conversation,
                            message: _value_meesage.value.text,
                            typeMessage: 0);
                        setState(() {
                          _value_meesage.clear();
                          sending = false;
                        });
                        print('Wyslano Wiadomosc');
                      } catch (err) {
                        print('Nie mozna wyslac wiadomosci.' + err);
                      }
                    }
                  : widget.conversation == false &&
                          widget.firstMessage == true &&
                          sending == false &&
                          _value_meesage.value.text != ''
                      ? () async {
                          setState(() {
                            sending = true;
                          });
                          await Chat(
                            mainUid: widget.mainUid,
                            peopleUid: widget.peopleUid,
                          ).sendMessage(
                              conversation: widget.conversation,
                              message: _value_meesage.value.text,
                              typeMessage: 0);
                          setState(() {
                            _value_meesage.clear();
                            widget.firstMessage = false;
                            sending = false;
                          });
                          print('Wyslano Wiadomosc');
                        }
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
