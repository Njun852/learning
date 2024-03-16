// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/crud/note_service.dart';
import 'package:mynotes/utils/show_error_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NoteService _noteService;
  String get userEmail => AuthService.firebase().currentUser!.email!;
  @override
  void initState() {
    _noteService = NoteService();
    if (!_noteService.dbIsOpen) {
      _noteService.open();
    }

    super.initState();
  }

  @override
  void dispose() {
    _noteService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Notes',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(newNoteRoute);
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton<MenuAction>(
            onSelected: (MenuAction value) async {
              final shouldLogOut = await showLogoutDialog(context);
              if (!shouldLogOut) {
                devtools.log('You are still signed in');
                return;
              }
              try {
                await AuthService.firebase().logOut();
                devtools.log('You are now logged out');
              } on AuthException catch (e) {
                showErrorDialog(context, e.message);
              }
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Logout'))
              ];
            },
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: _noteService.notes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return const Text('Waiting for all notes...');
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
        future: _noteService.getOrCreateUser(userEmail),
      ),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          )).then((bool? value) => value ?? false);
}
