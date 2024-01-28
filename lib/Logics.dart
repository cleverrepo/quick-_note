import 'package:flutter/cupertino.dart';
import 'Note/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> myNote = [];
  List get notes => myNote;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("notes");
  Future<void> fetchNote() async {
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      myNote = querySnapshot.docs
          .map((doc) => NoteModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  bool hasdata(NoteModel noteModel) {
    return myNote.contains(noteModel);
  }

  void addNote(NoteModel noteModel) async {
    try {
      await collectionReference.add(noteModel);
      await fetchNote();
    } catch (error) {
      print(error.toString());
    }
  }

  void updateNote(NoteModel note, String newTitle, String newContent) async {
    try {
      note.dateModified = DateTime.now();
      await collectionReference.doc(note.id).update({
        'title': newTitle,
        'content': newContent,
      });
      await fetchNote();
    } catch (err) {
      print(err.toString());
    }
  }

  void deleteNote(NoteModel noteModel) async {
    try {
      await collectionReference.doc(noteModel.id).delete();
      myNote.removeWhere((element) => element.id == noteModel.id);
      await fetchNote();
    } catch (r) {
      print(r.toString());
    }
  }
}
