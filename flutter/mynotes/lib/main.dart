import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/new_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.deepPurple,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              )),
              iconTheme: const IconThemeData(color: Colors.white),
          popupMenuTheme: const PopupMenuThemeData(
            iconColor: Colors.white,
            iconSize: 30,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        notesRoute: (context) => const NotesView(),
        newNoteRoute: (context) => const NewNoteView()
      },
    ));
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialiaze(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: CircularProgressIndicator());
        }
        final AuthUser? user = AuthService.firebase().currentUser;
        if (user == null) {
          return const LoginView();
        }
        if (user.isEmailVerified) {
          return const NotesView();
        }
        return const VerifyEmailView();
      },
    );
  }
}
