import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? email;
  final String password;
  
  const AuthUser({
    required this.isEmailVerified,
    required this.password,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified, email: user.email, password: 'hidden');
}
