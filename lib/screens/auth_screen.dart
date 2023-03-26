import 'package:chitchat/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthentictionScreen extends StatefulWidget {
  const AuthentictionScreen({super.key});

  @override
  State<AuthentictionScreen> createState() => _AuthentictionScreenState();
}

class _AuthentictionScreenState extends State<AuthentictionScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email,
    String userName,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authres;
    try {
      if (isLogin) {
        authres = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authres = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (err) {
      String message = 'An error occured, please check your credentials';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(getAuthFormData: _submitAuthForm),
    );
  }
}
