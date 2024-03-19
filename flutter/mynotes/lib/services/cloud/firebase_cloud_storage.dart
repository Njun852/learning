import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:mynotes/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  Future<void> deleteNote({
    required String documentId,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (_) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      print(text);
      await notes.doc(documentId).update({textFieldName: text});
    } catch (_) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({
    required String ownerUserId,
  }) {
    return notes.snapshots().map((event) => event.docs
        .map((doc) => CloudNote.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>))
        .where((note) => note.ownerUserId == ownerUserId));
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetchedNote = await document.get();

    return CloudNote(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  Future<Iterable<CloudNote>> getNotes({
    required String ownerUserId,
  }) async {
    try {
      return await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get()
          .then((value) {
        return value.docs.map((doc) {
          return CloudNote.fromSnapshot(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>);
        });
      });
    } catch (_) {
      throw CouldNotGetAllNotesException();
    }
  }
}
