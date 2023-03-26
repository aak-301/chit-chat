import 'package:chitchat/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthentictionScreen extends StatefulWidget {
  const AuthentictionScreen({super.key});

  @override
  State<AuthentictionScreen> createState() => _AuthentictionScreenState();
}

class _AuthentictionScreenState extends State<AuthentictionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const AuthForm(),
    );
  }
}
