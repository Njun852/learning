import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) {
        throw UserNotLoggedInAuthException();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          throw WeakPasswordAuthException();
        case 'invalid-email':
          throw InvalidCredentialsAuthExcepion();
        case 'channel-error':
          throw ChannelErrorAuthException();
        default:
          throw AuthException();
      }
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;
    return AuthUser(currentUser.emailVerified);
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final AuthUser? user = currentUser;
      if (user == null) throw UserNotLoggedInAuthException();
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          throw InvalidCredentialsAuthExcepion();
        case 'invalid-email':
          throw InvalidEmailAuthException();
        case 'channel-error':
          throw ChannelErrorAuthException();
        default:
          throw AuthException();
      }
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  Future<void> logOut() async {
    if (currentUser == null) throw UserNotLoggedInAuthException();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      if (currentUser == null) throw UserNotLoggedInAuthException();
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  Future<void> initialiaze() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } on FirebaseAuthException catch (_) {
      throw AuthException();
    } catch (_) {
      throw AuthException();
    }
  }
}
