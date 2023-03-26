import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.getAuthFormData});

  final Function getAuthFormData;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  String userEmail = "";
  String userPassword = "";
  String userName = "";

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.getAuthFormData(userEmail,userName,userPassword,_isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid emial address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                    onSaved: (newValue) {
                      userEmail = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username should be at least 4 charecter long';
                        }
                        return null;
                      }),
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (newValue) {
                        userName = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 charecter long';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(labelText: 'Passowrd'),
                    obscureText: true,
                    onSaved: (newValue) {
                      userPassword = newValue!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Create new accout'
                          : 'I already have an account',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
