import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/ChatList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  ChatList chatList;

  ChatScreen(ChatList nam) {
    this.chatList = nam;
  }

  @override
  _ChatScreenState createState() => _ChatScreenState(chatList);
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  ChatList chatList;
  AnimationController animationController;
  String messageText;
  final fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  _ChatScreenState(ChatList chatList) {
    this.chatList = chatList;
  }

  // void getMessages() async {
  //   Query messages = fireStore.collection('messages');
  //   AsyncSnapshot<QuerySnapshot> snapshot;
  //   if (!snapshot.hasData) {
  //     return null;
  //   } else {
  //     snapshot.data.docs.map((e) => document);
  //     print(document);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 100.0);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        leadingWidth: 28.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(chatList.image),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(chatList.name),
          ],
        ),
        backgroundColor: Colors.pink[100],
      ),
      body: Center(
        child: Text('${animationController.value.toInt()}%'),
      ),
    );
  }
}
