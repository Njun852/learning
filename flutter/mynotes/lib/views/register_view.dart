// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Enter password')),
            TextButton(
                onPressed: () async {
                  final String email = _email.text;
                  final String password = _password.text;
                  FirebaseAuthExceptionHandler.tryAndCatch(context, () async {
                    final UserCredential userCredentials = await FirebaseAuth
                        .instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    await userCredentials.user?.sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }, {
                    'weak-password': 'Please enter a strong password',
                    'email-already-in-use': 'This account already exist',
                    'invalid-email': 'Email is not valid'
                  });
                },
                child: const Text('Register')),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text('Already have an account? Login here'))
          ],
        ));
  }
}
