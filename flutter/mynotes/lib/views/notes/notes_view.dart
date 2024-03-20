// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';
import 'package:mynotes/utils/dialogs/loading_dialog.dart';
import 'package:mynotes/utils/dialogs/logout_dialog.dart';
import 'package:mynotes/utils/dialogs/error_dialog.dart';
import 'package:mynotes/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _noteService;
  String get userId => AuthService.firebase().currentUser!.id;
  CloseDialog? _closeDialogHandler;
  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final handler = _closeDialogHandler;
        if (state is AuthStateLoggedOut) {
          if (state.isLoading && handler == null) {
            _closeDialogHandler = showLoadingDialog(
              context: context,
              text: 'Logging Out',
            );
          }
        } else if (handler != null) {
          _closeDialogHandler!();
          _closeDialogHandler = null;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Notes',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(createOrUpdateNoteRoute,
                        arguments: 'Yooooo');
                  },
                  icon: const Icon(Icons.add)),
              PopupMenuButton<MenuAction>(
                onSelected: (MenuAction value) async {
                  final shouldLogOut = await showLogoutDialog(context);
                  if (!shouldLogOut) return;
                  context.read<AuthBloc>().add(const AuthEventLogOut());
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
          body: StreamBuilder(
              stream: _noteService.allNotes(ownerUserId: userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    if (snapshot.hasData) {
                      final allNotes = snapshot.data as Iterable<CloudNote>;
                      // print(allNotes);
                      return NotesListView(
                        notes: allNotes,
                        onDeleteNote: (note) async {
                          await _noteService.deleteNote(
                              documentId: note.documentId);
                        },
                        onTap: (note) {
                          Navigator.of(context).pushNamed(
                              createOrUpdateNoteRoute,
                              arguments: note);
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  default:
                    return const CircularProgressIndicator();
                }
              })),
    );
  }
}
