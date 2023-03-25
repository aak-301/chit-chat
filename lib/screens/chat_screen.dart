import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("data"),
        ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          FirebaseFirestore.instance
              .collection('chats/fvuc3G3EX0iwO15MlMbw/messages')
              .snapshots()
              .listen((data) {
            print("++++++++++++");
            print(data.docs[0]['text']);
            print("++++++++++++");
          });
        }),
      ),
    );
  }
}
