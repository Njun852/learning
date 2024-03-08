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
      } else {
        await showErrorDialog(context, 'Error: ${e.code}');
      }
    } catch (e) {
      await showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }
}

//login exception
class InvalidCredentialsAuthExcepion extends AuthException
    implements Exception {
  @override
  String get message {
    return 'Wrong password or user doesn\'t exist';
  }
}

// register exceptions
class WeakPasswordAuthException extends AuthException implements Exception {
  @override
  String get message {
    return 'Weak password';
  }
}

class EmailAlreadyInUseAuthException extends AuthException
    implements Exception {
  @override
  String get message {
    return 'Email is already in use';
  }
}

//others
class ChannelErrorAuthException extends AuthException implements Exception {
  @override
  String get message {
    return 'Please enter the required informations';
  }
}

class InvalidEmailAuthException extends AuthException implements Exception {
  @override
  String get message {
    return 'Wrong password or user doesn\'t exist';
  }
}

class UserNotLoggedInAuthException extends AuthException implements Exception {
  @override
  String get message {
    return 'User is not logged in';
  }
}

//generic exceptions
class AuthException implements Exception {
  final String message = 'Something went wrong';
}
