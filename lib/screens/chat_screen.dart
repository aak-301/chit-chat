import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
        ),
        itemCount: 10,
      ),
    );
  }
}
