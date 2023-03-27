import 'package:chitchat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: ((context, index) {
            return MessageBubble(
              uniquekey: ValueKey(chatDoc[index].id),
              message: chatDoc[index]['text'],
              isMe: chatDoc[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              userName: chatDoc[index]['username'],
            );
          }),
          itemCount: chatDoc.length,
        );
      },
    );
  }
}
