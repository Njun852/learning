import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
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
                  try {
                    final UserCredential userCredentials = await FirebaseAuth
                        .instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);

                    if (!context.mounted) return;
                    userCredentials.user?.sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    switch (e.code) {
                      case 'weak-password':
                        await showErrorDialog(
                            context, 'Please enter a strong password');
                        break;
                      case 'email-already-in-use':
                        await showErrorDialog(
                            context, 'This account already exist');
                        break;
                      case 'invalid-email':
                        await showErrorDialog(context, 'Email is not valid');
                        break;
                      default:
                        await showErrorDialog(context, 'Error: ${e.code}');
                        break;
                    }
                  } catch (e) {
                    await showErrorDialog(context, 'Error: ${e.toString()}');
                  }
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
