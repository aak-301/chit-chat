import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: ((context, index) {
            return Text(chatDoc[index]['text']);
          }),
          itemCount: chatDoc.length,
        );
      },
    );
  }
}
