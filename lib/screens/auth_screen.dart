import 'dart:io';

import 'package:chitchat/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthentictionScreen extends StatefulWidget {
  const AuthentictionScreen({super.key});

  @override
  State<AuthentictionScreen> createState() => _AuthentictionScreenState();
}

class _AuthentictionScreenState extends State<AuthentictionScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
    String email,
    String userName,
    String password,
    bool isLogin,
    File userImage,
    BuildContext ctx,
  ) async {
    UserCredential authres;
    try {
      setState(() {
        _isLoading = true;
      });
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

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authres.user!.uid + '.jpg');

        await ref.putFile(userImage).whenComplete(() => null);

        String imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authres.user!.uid)
            .set({
          'username': userName,
          'emal': email,
          'url': imageUrl,
        });
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
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        getAuthFormData: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
