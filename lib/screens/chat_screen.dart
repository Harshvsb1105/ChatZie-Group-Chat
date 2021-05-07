import 'package:chatzie/Controller/AccessController.dart';
import 'package:chatzie/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final int mode;

  const ChatScreen({
    Key key,
    this.mode,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String messageText;
  AccessController accessController = Get.put(AccessController());

  @override
  void initState() {
    super.initState();
    accessController.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              color: Color(0xFFff9ad4),
              icon: Icon(Icons.close),
              onPressed: () {
                widget.mode == 1
                    ? accessController.fbSignOut(context)
                    : accessController.signOut();
                Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (Route<dynamic> route) => false);
              })
        ],
        title: Center(
            child: Text(
          '️Messages',
          style:
              TextStyle(color: Color(0xFFff9ad4), fontWeight: FontWeight.w900),
        )),
        backgroundColor: Color(0xFF6226a7),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Color(0xFFff9ad4)),
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                      //messageText + loggedInUser.email
                      //always check for spellings.
                      //Pathway for storing data in cloud firestore.
                      _firestore.collection('messages').add({
                        'text': messageText, //take the typed text
                        'sender': accessController
                            .loggedInUser.email, //take the users ID
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AccessController accessController = Get.put(AccessController());

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF6226a7),
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageTime = message.data['time'] as Timestamp;

          final currentUser = accessController.loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            time: messageTime,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    this.text,
    this.sender,
    this.isMe,
    this.time,
  });

  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1.0, -4.0),
                    end: Alignment(1.0, 4.0),
                    colors: [Color(0xFFe6e6e6), Color(0xFFffffff)]),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFd9d9d9),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1.0,
                      spreadRadius: 3.0),
                  BoxShadow(
                      color: Color(0xFFffffff),
                      offset: Offset(-2.0, -2.0),
                      blurRadius: 1.0,
                      spreadRadius: 3.0),
                ]),
            child: Material(
              borderRadius: isMe
                  ? BorderRadius.all(Radius.circular(30.0))
                  : BorderRadius.all(Radius.circular(30.0)),
//              elevation: 5.0,
              color: isMe ? Color(0xFF6226a7) : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Color(0xFFff9ad4) : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '$sender',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11.0,
                ),
              ),
              if (time != null)
                Text(
                  "${DateTime.fromMicrosecondsSinceEpoch(time.seconds * 1000)}",
                  style: TextStyle(fontSize: 0.0),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
