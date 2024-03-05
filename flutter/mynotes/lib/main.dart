import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user?.emailVerified ?? false) {
              print('Welcome user');
            } else {
              print('Please verify your email');
            }
            print(user);
            return Scaffold(
                appBar: AppBar(
                    title: const Text('Home'),
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary),
                body: const Text('Welcome to My Notes'));
          } else {
            return const Text('Loading, please wait');
          }
        });
  }
}
