// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

class FirebaseAuthExceptionHandler {
  static void tryAndCatch(BuildContext context, tryCallback,
      [Map<String, String>? handlers]) async {
    try {
      await tryCallback();
    } on FirebaseAuthException catch (e) {
      final String? err = handlers?[e.code];
      if (err != null) {
        await showErrorDialog(context, err);
      }else {
        await showErrorDialog(context, 'Error: ${e.code}');
      }
    } catch (e) {
      await showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }
}
