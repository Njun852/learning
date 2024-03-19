import 'package:bloc/bloc.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialiaze();
      final AuthUser? user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
        return;
      }
      if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
        return;
      }
      emit(AuthStateLoggedIn(user));
    });

    on<AuthEventLogIn>(
      (event, emit) async {
        try {
          final AuthUser user = await provider.logIn(
            email: event.email,
            password: event.password,
          );
          emit(AuthStateLoggedIn(user));
        } on Exception catch (e) {
          emit(AuthStateLoginFailure(e));
        }
      },
    );

    on<AuthEventLogOut>(((event, emit) async {
      emit(const AuthStateLoading());
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (_) {
        emit(const AuthStateLogoutFailure());
      }
    }));
  }
}
