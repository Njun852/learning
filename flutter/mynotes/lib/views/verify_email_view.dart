// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Confirmation link is sent to your email'),
          TextButton(
              onPressed: () async {
                try {
                  await AuthService.firebase().sendEmailVerification();
                } on AuthException catch (e) {
                  showErrorDialog(context, e.message);
                }
              },
              child: const Text('Resend email')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Restart'))
        ]),
      ),
    );
  }
}
