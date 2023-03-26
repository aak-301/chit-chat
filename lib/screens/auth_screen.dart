import 'package:chitchat/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthentictionScreen extends StatefulWidget {
  const AuthentictionScreen({super.key});

  @override
  State<AuthentictionScreen> createState() => _AuthentictionScreenState();
}

class _AuthentictionScreenState extends State<AuthentictionScreen> {
  void _submitAuthForm(
    String email,
    String userName,
    String password,
    bool isLogin,
  ) {
    print(email);
    print(userName);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(getAuthFormData: _submitAuthForm),
    );
  }
}
