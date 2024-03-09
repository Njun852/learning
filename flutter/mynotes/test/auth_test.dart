import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized first', () {
      expect(provider.isInitialized, false);
      expect(provider.logOut(),
          throwsA(const TypeMatcher<ProviderNotInitialized>()));
    });
    test('Should be initialized upon calling initialize', () async {
      await provider.initialiaze();
      expect(provider.isInitialized, true);
      expect(provider.currentUser, null);
    });
    test('Initialization should take less than 2 second', () async {
      await provider.initialiaze();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));
    test('Bad user creation', () {
      expect(
        provider.createUser(email: '', password: ''),
        throwsA(const TypeMatcher<ChannelErrorAuthException>()),
      );
      expect(
        provider.createUser(email: 'foobarbaz@gmail.com', password: 'hello'),
        throwsA(const TypeMatcher<EmailAlreadyInUseAuthException>()),
      );
    });
    test('Good user creation', () async {
      final user = await provider.createUser(
        email: 'njun1232@gmail.com',
        password: 'yoooo',
      );
      expect(provider._currentUser, user);
    });
    test('User verifation', () async {
      expect(provider._currentUser?.isEmailVerified, false);
      await provider.sendEmailVerification();
      expect(provider._currentUser?.isEmailVerified, true);
    });
    test('User logout', () async {
      await provider.logOut();
      expect(provider._currentUser, null);
      expect(
          provider.sendEmailVerification(),
          throwsA(
            const TypeMatcher<UserNotLoggedInAuthException>(),
          ));
      expect(provider.logOut(),
          throwsA(const TypeMatcher<UserNotLoggedInAuthException>()));
    });
    test('Bad user login', () {
      expect(provider.logIn(email: 'foobarbaz@gmail.com', password: 'yoooo'),
          throwsA(const TypeMatcher<InvalidCredentialsAuthExcepion>()));
      expect(provider.logIn(email: '', password: ''),
          throwsA(const TypeMatcher<ChannelErrorAuthException>()));
    });
    test('Good user login', () async {
      AuthUser? user = await provider.logIn(
          email: 'foobarbaz@gmail.com', password: 'foobarbaz');
      expect(user, provider._currentUser);
      user = await provider.logIn(email: 'joe@gmail.com', password: 'joe123');
      expect(user, provider._currentUser);
    });
  });
}

class ProviderNotInitialized extends AuthException {
  @override
  String get message {
    return 'Provider is not initialized';
  }
}

class MockAuthProvider implements AuthProvider {
  bool _isInitialized = false;
  AuthUser? _currentUser;
  bool get isInitialized => _isInitialized;
  final Map<String, AuthUser> _userDB = {
    'foobarbaz@gmail.com': const AuthUser(
        isEmailVerified: true, password: 'foobarbaz', email: 'foobarbaz@gmail'),
    'joe@gmail.com': const AuthUser(
        isEmailVerified: true, password: 'joe123', email: 'joe@gmail.com')
  };

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) throw ChannelErrorAuthException();
    if (!isInitialized) throw ProviderNotInitialized();
    if (_userDB[email] != null) throw EmailAlreadyInUseAuthException();
    AuthUser newUser = await Future.delayed(
        const Duration(seconds: 1),
        () =>
            AuthUser(isEmailVerified: false, email: email, password: password));
    _userDB.addAll({email: newUser});
    _currentUser = newUser;
    return newUser;
  }

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Future<void> initialiaze() async {
    await Future.delayed(
        const Duration(seconds: 1), () => _isInitialized = true);
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw ProviderNotInitialized();
    if (email.isEmpty) {
      if (password.isEmpty) throw ChannelErrorAuthException();
      throw InvalidEmailAuthException();
    }
    if (_userDB[email] == null || password != _userDB[email]?.password) {
      throw InvalidCredentialsAuthExcepion();
    }
    AuthUser user = AuthUser(
        isEmailVerified: _userDB[email]?.isEmailVerified ?? false,
        email: email,
        password: password);
    _currentUser = user;
    return await Future.delayed(const Duration(seconds: 1), () => user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw ProviderNotInitialized();
    if (currentUser == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1), () {
      _currentUser = null;
    });
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw ProviderNotInitialized();
    if (currentUser == null) throw UserNotLoggedInAuthException();
    return Future.delayed(const Duration(seconds: 1), () {
      _currentUser = AuthUser(
          email: currentUser?.email,
          password: currentUser?.password ?? 'hidden',
          isEmailVerified: true);
    });
  }
}
