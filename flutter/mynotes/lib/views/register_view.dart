import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

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
    final Color theme = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: theme,
        ),
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
                  try {
                    final UserCredential userCredentials = await FirebaseAuth
                        .instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    print(userCredentials);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('Weak Password');
                    } else if (e.code == 'email-already-in-use') {
                      print('This account already exist');
                    } else if (e.code == 'invalid-email') {
                      print('Email is not valid');
                    } else {
                      print('Something else happened');
                      print(e.code);
                    }
                  }
                },
                child: const Text('Register'))
          ],
        ));
  }
}