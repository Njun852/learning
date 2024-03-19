import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';
import 'package:mynotes/utils/generics/get_arguments.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _noteService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) return;
    final text = _textController.text;
    await _noteService.updateNote(documentId: note.documentId, text: text);
  }

  void _setUpTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote() async {
    final existingNote = context.getArgument<CloudNote>();
    if (existingNote != null) {
      _note = existingNote;
      _textController.value = TextEditingValue(text: existingNote.text);
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final id = currentUser.id;
    _note = await _noteService.createNewNote(ownerUserId: id);
    return _note!;
  }

  void _deleteNoteIfTextIsEmpty() async {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      await _noteService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextIsNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _noteService.updateNote(documentId: note.documentId, text: text);
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text('Create Note'),
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _setUpTextControllerListener();
            return TextField(
              controller: _textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: 'Start typing your note...',
                  border: InputBorder.none),
            );
          } else {
            return const Text('Hi');
          }
        },
      ),
    );
  }
}
