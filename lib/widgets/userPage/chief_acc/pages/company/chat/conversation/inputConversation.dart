import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/chat.dart';

class InputConversation extends StatefulWidget {
  bool conversation;
  var mainUid;
  var peopleUid;

  InputConversation({this.conversation, this.mainUid, this.peopleUid});

  @override
  _InputConversationState createState() => _InputConversationState();
}

class _InputConversationState extends State<InputConversation> {
  final TextEditingController _value_meesage = TextEditingController();
  bool sending = false;

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
                onPressed: null,
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
                      sending == false &&
                      _value_meesage.value.text != ''
                  ? () async {
                      if (widget.conversation == false) {
                        setState(() {
                          sending = true;
                        });
                        await Chat(
                                mainUid: widget.mainUid,
                                peopleUid: widget.peopleUid)
                            .sendMessage(
                          conversation: widget.conversation,
                          message: _value_meesage.value.text,
                        );
                        setState(() {
                          _value_meesage.clear();
                          widget.conversation = false;
                          sending = false;
                        });
                        print('Wyslano Wiadomosc');
                      } else if (widget.conversation == true) {
                        setState(() {
                          sending = true;
                        });
                        await Chat(
                                mainUid: widget.mainUid,
                                peopleUid: widget.peopleUid)
                            .sendMessage(
                          conversation: widget.conversation,
                          message: _value_meesage.value.text,
                        );
                        setState(() {
                          _value_meesage.clear();
                          sending = false;
                        });
                        print('Wyslano Wiadomosc');
                      } else {
                        print('Nie mozna wyslac wiadomosci');
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
