// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

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
    return 'Invalid email';
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
