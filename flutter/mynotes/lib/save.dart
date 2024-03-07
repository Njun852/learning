// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(
        title: const Text('Login'),
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
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                final String email = _email.text;
                final String password = _password.text;
                try {
                  final UserCredential user = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);

                  if (!(user.user?.emailVerified ?? false)) {
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                    return;
                  }
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case 'invalid-credential':
                      await showErrorDialog(context,
                          'User doesn\'t exist or credential is invalid');
                      //user doesnt exist or wrong credential
                      break;
                    case 'invalid-email':
                      await showErrorDialog(context, 'Email is invalid');
                      break;
                    case 'channel-error':
                      await showErrorDialog(
                          context, 'Please enter the required informations');
                      // a field is empty
                      break;
                    default:
                      await showErrorDialog(context, 'Error: ${e.code}');
                      break;
                  }
                } catch (e) {
                  await showErrorDialog(context, 'Error: ${e.toString()}');
                }
              },
              child: const Text('Login')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Create an account'))
        ],
      ),
    );
  }
}

