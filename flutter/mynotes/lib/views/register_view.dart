// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utils/dialogs/error_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          final Exception? exception = state.exception;
          if (exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Please provide a strong password');
          } else if (exception is InvalidCredentialsAuthExcepion) {
            await showErrorDialog(context, 'Please provide a valid info');
          } else if (exception is ChannelErrorAuthException) {
            await showErrorDialog(context, 'Please fill out the fields');
          } else {
            await showErrorDialog(context, 'Something went wrong');
          }
        }
      },
      child: Scaffold(
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
                  decoration:
                      const InputDecoration(hintText: 'Enter password')),
              TextButton(
                  onPressed: () async {
                    final String email = _email.text;
                    final String password = _password.text;
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            email: email,
                            password: password,
                          ),
                        );
                  },
                  child: const Text('Register')),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text('Already have an account? Login here'))
            ],
          )),
    );
  }
}
