import 'package:bloc/bloc.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: false)) {
    on<AuthEventSendVerificationEmail>(
      ((event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      }),
    );
    on<AuthEventRegister>(
      (event, emit) async {
        try {
          await provider.createUser(
            email: event.email,
            password: event.password,
          );
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(exception: e));
        }
      },
    );
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialiaze();
      final AuthUser? user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(isLoading: false));
        return;
      }
      if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
        return;
      }
      emit(AuthStateLoggedIn(user));
      print('hi')
    });

    on<AuthEventLogIn>(
      (event, emit) async {
        try {
          emit(const AuthStateLoggedOut(
              isLoading: true, loadingText: 'Logging in...'));
          final AuthUser user = await provider.logIn(
            email: event.email,
            password: event.password,
          );
          if (!user.isEmailVerified) {
            emit(const AuthStateNeedsVerification());
          } else {
            emit(const AuthStateLoggedOut(isLoading: false));
            emit(AuthStateLoggedIn(user));
          }
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e, isLoading: false));
        }
      },
    );

    on<AuthEventLogOut>(((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    }));
  }
}
